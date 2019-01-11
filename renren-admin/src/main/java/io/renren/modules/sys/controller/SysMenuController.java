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

package io.renren.modules.sys.controller;

import com.alibaba.fastjson.JSONArray;
import io.renren.common.annotation.SysLog;
import io.renren.common.exception.RRException;
import io.renren.common.utils.Constant;
import io.renren.common.utils.R;
import io.renren.modules.sys.entity.SysMenuEntity;
import io.renren.modules.sys.service.SysMenuService;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 系统菜单
 *
 * @author chenshun
 * @email sunlightcs@gmail.com
 * @date 2016年10月27日 下午9:58:15
 */
@RestController
@RequestMapping("/sys/menu")
public class SysMenuController extends AbstractController {
	@Autowired
	private SysMenuService sysMenuService;

	/**
	 * 导航菜单
	 */
	@RequestMapping("/nav")
	public R nav(){
		//List<SysMenuEntity> menuList = sysMenuService.getUserMenuList(getUserId());
		List list = JSONArray.parseArray("[\n" +
				"    {\n" +
				"        \"path\": \"/system-manager\",\n" +
				"        \"icon\": \"table\",\n" +
				"        \"name\": \"系统管理\",\n" +
				"        \"locale\": \"menu.systemManager\",\n" +
				"        \"authority\": [\n" +
				"            \"admin\",\n" +
				"            \"user\"\n" +
				"        ],\n" +
				"        \"children\": [\n" +
				"            {\n" +
				"                \"path\": \"/system-manager/admin-manager\",\n" +
				"                \"name\": \"管理员管理\",\n" +
				"                \"exact\": true,\n" +
				"                \"locale\": \"menu.systemManager.adminManager\"\n" +
				"            },\n" +
				"            {\n" +
				"                \"path\": \"/system-manager/department-manager\",\n" +
				"                \"name\": \"部门管理\",\n" +
				"                \"exact\": true,\n" +
				"                \"locale\": \"menu.systemManager.departmentManager\"\n" +
				"            },\n" +
				"            {\n" +
				"                \"path\": \"/system-manager/role-manager\",\n" +
				"                \"name\": \"角色管理\",\n" +
				"                \"exact\": true,\n" +
				"                \"locale\": \"menu.systemManager.roleManager\"\n" +
				"            },\n" +
				"            {\n" +
				"                \"path\": \"/system-manager/menu-manager\",\n" +
				"                \"name\": \"菜单管理\",\n" +
				"                \"exact\": true,\n" +
				"                \"locale\": \"menu.systemManager.menuManager\",\n" +
				"            },\n" +
				"            {\n" +
				"                \"path\": \"/system-manager/sql-manager\",\n" +
				"                \"name\": \"SQL监控\",\n" +
				"                \"exact\": true,\n" +
				"                \"locale\": \"menu.systemManager.sqlManager\"\n" +
				"            },\n" +
				"            {\n" +
				"                \"path\": \"/system-manager/timing-manager\",\n" +
				"                \"name\": \"定时任务\",\n" +
				"                \"exact\": true,\n" +
				"                \"locale\": \"menu.systemManager.timingManager\"\n" +
				"            },\n" +
				"            {\n" +
				"                \"path\": \"/system-manager/parameter-manager\",\n" +
				"                \"name\": \"参数管理\",\n" +
				"                \"exact\": true,\n" +
				"                \"locale\": \"menu.systemManager.parameterManager\"\n" +
				"            },\n" +
				"            {\n" +
				"                \"path\": \"/system-manager/file-upload\",\n" +
				"                \"name\": \"文件上传\",\n" +
				"                \"exact\": true,\n" +
				"                \"locale\": \"menu.systemManager.fileUpload\"\n" +
				"            },\n" +
				"            {\n" +
				"                \"path\": \"/system-manager/dictionary-manager\",\n" +
				"                \"name\": \"字典管理\",\n" +
				"                \"exact\": true,\n" +
				"                \"locale\": \"menu.systemManager.dictionaryManager\"\n" +
				"            },\n" +
				"            {\n" +
				"                \"path\": \"/system-manager/system-log\",\n" +
				"                \"name\": \"系统日志\",\n" +
				"                \"exact\": true,\n" +
				"                \"locale\": \"menu.systemManager.systemLog\"\n" +
				"            },\n" +
				"        ]\n" +
				"    }\n" +
				"]");
		return R.ok().put("menuList", list);
	}

	/**
	 * 所有菜单列表
	 */
	@RequestMapping("/list")
	@RequiresPermissions("sys:menu:list")
	public List<SysMenuEntity> list(){
		List<SysMenuEntity> menuList = sysMenuService.selectList(null);
		for(SysMenuEntity sysMenuEntity : menuList){
			SysMenuEntity parentMenuEntity = sysMenuService.selectById(sysMenuEntity.getParentId());
			if(parentMenuEntity != null){
				sysMenuEntity.setParentName(parentMenuEntity.getName());
			}
		}

		return menuList;
	}

	/**
	 * 选择菜单(添加、修改菜单)
	 */
	@RequestMapping("/select")
	@RequiresPermissions("sys:menu:select")
	public R select(){
		//查询列表数据
		List<SysMenuEntity> menuList = sysMenuService.queryNotButtonList();

		//添加顶级菜单
		SysMenuEntity root = new SysMenuEntity();
		root.setMenuId(0L);
		root.setName("一级菜单");
		root.setParentId(-1L);
		root.setOpen(true);
		menuList.add(root);

		return R.ok().put("menuList", menuList);
	}

	/**
	 * 菜单信息
	 */
	@RequestMapping("/info/{menuId}")
	@RequiresPermissions("sys:menu:info")
	public R info(@PathVariable("menuId") Long menuId){
		SysMenuEntity menu = sysMenuService.selectById(menuId);
		return R.ok().put("menu", menu);
	}

	/**
	 * 保存
	 */
	@SysLog("保存菜单")
	@RequestMapping("/save")
	@RequiresPermissions("sys:menu:save")
	public R save(@RequestBody SysMenuEntity menu){
		//数据校验
		verifyForm(menu);

		sysMenuService.insert(menu);

		return R.ok();
	}

	/**
	 * 修改
	 */
	@SysLog("修改菜单")
	@RequestMapping("/update")
	@RequiresPermissions("sys:menu:update")
	public R update(@RequestBody SysMenuEntity menu){
		//数据校验
		verifyForm(menu);

		sysMenuService.updateById(menu);

		return R.ok();
	}

	/**
	 * 删除
	 */
	@SysLog("删除菜单")
	@RequestMapping("/delete")
	@RequiresPermissions("sys:menu:delete")
	public R delete(long menuId){
		if(menuId <= 31){
			return R.error("系统菜单，不能删除");
		}

		//判断是否有子菜单或按钮
		List<SysMenuEntity> menuList = sysMenuService.queryListParentId(menuId);
		if(menuList.size() > 0){
			return R.error("请先删除子菜单或按钮");
		}

		sysMenuService.delete(menuId);

		return R.ok();
	}

	/**
	 * 验证参数是否正确
	 */
	private void verifyForm(SysMenuEntity menu){
		if(StringUtils.isBlank(menu.getName())){
			throw new RRException("菜单名称不能为空");
		}

		if(menu.getParentId() == null){
			throw new RRException("上级菜单不能为空");
		}

		//菜单
		if(menu.getType() == Constant.MenuType.MENU.getValue()){
			if(StringUtils.isBlank(menu.getUrl())){
				throw new RRException("菜单URL不能为空");
			}
		}

		//上级菜单类型
		int parentType = Constant.MenuType.CATALOG.getValue();
		if(menu.getParentId() != 0){
			SysMenuEntity parentMenu = sysMenuService.selectById(menu.getParentId());
			parentType = parentMenu.getType();
		}

		//目录、菜单
		if(menu.getType() == Constant.MenuType.CATALOG.getValue() ||
				menu.getType() == Constant.MenuType.MENU.getValue()){
			if(parentType != Constant.MenuType.CATALOG.getValue()){
				throw new RRException("上级菜单只能为目录类型");
			}
			return ;
		}

		//按钮
		if(menu.getType() == Constant.MenuType.BUTTON.getValue()){
			if(parentType != Constant.MenuType.MENU.getValue()){
				throw new RRException("上级菜单只能为菜单类型");
			}
			return ;
		}
	}
}
