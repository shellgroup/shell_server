/**
 * Copyright 2018 人人开源 http://www.renren.io
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

package io.renren.modules.sys.service.impl;


import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import io.renren.common.utils.Constant;
import io.renren.common.utils.MapUtils;
import io.renren.modules.sys.dao.SysMenuDao;
import io.renren.modules.sys.entity.SysMenuEntity;
import io.renren.modules.sys.service.SysMenuService;
import io.renren.modules.sys.service.SysRoleMenuService;
import io.renren.modules.sys.service.SysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static io.renren.modules.sys.shiro.ShiroUtils.getUserId;


@Service("sysMenuService")
public class SysMenuServiceImpl extends ServiceImpl<SysMenuDao, SysMenuEntity> implements SysMenuService {
	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private SysRoleMenuService sysRoleMenuService;


	@Override
	public List<SysMenuEntity> queryListParentId(Long parentId) {
		return baseMapper.queryListParentId(parentId);
	}

	@Override
	public List<SysMenuEntity> queryNotButtonList() {
		return baseMapper.queryNotButtonList();
	}

	@Override
	public void delete(Long menuId){
		//删除菜单
		this.deleteById(menuId);
		//删除菜单与角色关联
		sysRoleMenuService.deleteByMap(new MapUtils().put("menu_id", menuId));
	}


	/*开始装填主页左侧菜单*/
	@Override
	public List<SysMenuEntity> getUserMenuList(Long userId) {
		//系统管理员，拥有最高权限
		if(userId == Constant.SUPER_ADMIN){
			return getAllMenuList(null);
		}
		
		//获取用户所有的菜单列表
		List<Long> menuIdList = sysUserService.queryAllMenuId(userId);

		return getAllMenuList(menuIdList);
	}

	/**
	 * 获取所有菜单列表
	 */
	private List<SysMenuEntity> getAllMenuList(List<Long> menuIdList){
		/*
		* 查询根菜单列表
		* queryListParentId方法主要是筛选出该用户拥有哪些根菜单
		*
		* */
		List<SysMenuEntity> menuList = queryListParentId(0L, menuIdList);

		//递归获取子菜单
		getMenuTreeList(menuList, menuIdList);
		
		return menuList;
	}

	@Override
	public List<SysMenuEntity> queryListParentId(Long parentId, List<Long> menuIdList) {
		/*
		 * 通过传入的parentId参数，获取该parentId下的所有的菜单
		 * 例如：
		 * 筛选方法，通过接受的parentId= 0，查询所有的根目录，
		 * 然后通过接受menuIdList，将查询到的所有根目录和该用户拥有的所有的菜单中通过id进行对比
		 * 获取该用户拥有的根菜单并返回
		 * */
		List<SysMenuEntity> menuList = queryListParentId(parentId);
		if(menuIdList == null){
			return menuList;
		}

		List<SysMenuEntity> userMenuList = new ArrayList<>();
		for(SysMenuEntity menu : menuList){
			if(menuIdList.contains(menu.getMenuId())){
				userMenuList.add(menu);
			}
		}
		return userMenuList;
	}

	/**
	 * 递归
	 */
	private List<SysMenuEntity> getMenuTreeList(List<SysMenuEntity> menuList, List<Long> menuIdList){
		/*
		* menuList：根目录
		* menuIdList:查询的该用户所有的菜单
		* */
		List<SysMenuEntity> subMenuList = new ArrayList<SysMenuEntity>();
		
		for(SysMenuEntity entity : menuList){
			/*
			 * 当menuList是目录时
			 */
			if(entity.getType() == Constant.MenuType.CATALOG.getValue()){
				entity.setChildren(getMenuTreeList(queryListParentId(entity.getMenuId(), menuIdList), menuIdList));
			}

			/*
			* 使用蚂蚁的页面增加的逻辑（如果可以使用shiro的标签，在页面中直接使用标签就不需要这个操作了）：
			* 前台需要该菜单下的所有的按钮的perms字段信息来控制按钮是否显示。
			* 前台具体逻辑：例如管理员管理页面，管理员管理页面有相应的按钮，在这里将按钮的perms信息都以list的形式放到管理员管理菜单项中
			* 当前台点击管理员管理，进入到管理员管理页面时，通过路由参数的形式，将perms信息传到相应的页面，然后再页面中通过比对各个按钮
			* 需要的perms和实际传过去的perms，来达到是否显示按钮的效果。
			*
			* java具体实现：
			* 当menuList是菜单时，获取该菜单下的用户拥有的按钮权限信息，然后通过按钮的parent_id对比是否是该菜单下的按钮，如果是就加入，
			* 反之就不加入
			* */
			if(entity.getType() == Constant.MenuType.MENU.getValue()){
				List<SysMenuEntity> sysMenuEntityList;
				Map map = new HashMap();
				Long userId = getUserId();
				/*
				* 超级管理员拥有所有的按钮
				* */
				if(userId == Constant.SUPER_ADMIN){
					map.put("menuType",Constant.MenuType.BUTTON.getValue());
					sysMenuEntityList = sysUserService.queryAllButton(map);
				}else {
					map.put("userId",getUserId());
					map.put("menuType",Constant.MenuType.BUTTON.getValue());
					sysMenuEntityList = sysUserService.queryAllButton(map);
				}

				List buttonList = new ArrayList();
				for (SysMenuEntity sysMenuEntity:sysMenuEntityList){
					if(sysMenuEntity.getParentId() == entity.getMenuId()){
						buttonList.add(sysMenuEntity.getPerms());
					}
				}
				entity.setParmsList(buttonList);
			}

			subMenuList.add(entity);
		}
		
		return subMenuList;
	}

	/*主页左侧菜单装填结束*/


	/*
	* 开始装填菜单页面的treeTable
	* */
	@Override
	public List<SysMenuEntity> treeTableShow() {
		/*
		 * 获取所有的根节点
		 * */
		List<SysMenuEntity> menuList = queryListParentId((long) Constant.MenuType.CATALOG.getValue());
		return getTreeTableList(menuList);
	}

	/*
	* 递归装填所有的菜单
	* */
	private List<SysMenuEntity> getTreeTableList(List<SysMenuEntity> menuList){

		for(SysMenuEntity menuEntity:menuList){
			List<SysMenuEntity> sysMenuEntityListTemp = queryListParentId(menuEntity.getMenuId());
			if(sysMenuEntityListTemp != null){
				menuEntity.setChildren(getTreeTableList(sysMenuEntityListTemp));
			}else {
				continue;
			}

		}

		return menuList;
	}


}
