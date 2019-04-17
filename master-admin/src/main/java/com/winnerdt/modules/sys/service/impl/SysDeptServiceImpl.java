package com.winnerdt.modules.sys.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.winnerdt.common.annotation.DataFilter;
import com.winnerdt.common.utils.Constant;
import com.winnerdt.modules.sys.dao.SysDeptDao;
import com.winnerdt.modules.sys.entity.SysDeptEntity;
import com.winnerdt.modules.sys.service.SysDeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Service("sysDeptService")
public class SysDeptServiceImpl extends ServiceImpl<SysDeptDao, SysDeptEntity> implements SysDeptService {
	@Autowired
	private SysDeptDao sysDeptDao;

	
	@Override
	@DataFilter(subDept = true, user = false, tableAlias = "t1")
	public List<SysDeptEntity> queryList(Map<String, Object> params){
		List<SysDeptEntity> deptList = baseMapper.queryList(params);

		for(SysDeptEntity sysDeptEntity : deptList){
			SysDeptEntity parentDeptEntity =  this.getById(sysDeptEntity.getParentId());
			if(parentDeptEntity != null){
				sysDeptEntity.setParentName(parentDeptEntity.getName());
			}
		}
		return deptList;
	}

	@Override
	public List<Long> queryDetpIdList(Long parentId) {
		return baseMapper.queryDetpIdList(parentId);
	}

	@Override
	public List<Long> getSubDeptIdList(Long deptId){
		//部门及子部门ID列表
		List<Long> deptIdList = new ArrayList<>();

		//获取子部门ID
		List<Long> subIdList = queryDetpIdList(deptId);
		getDeptTreeList(subIdList, deptIdList);

		return deptIdList;
	}

	@Override
	public List<SysDeptEntity> queryDetpList(Long parentId) {
		return sysDeptDao.queryDetpList(parentId);
	}


	@Override
	public List<SysDeptEntity> treeTableShow() {

		/*
		* 查询顶级部门列表
		* */
		List<SysDeptEntity> sysDeptEntityList = sysDeptDao.queryDetpList((long) Constant.MenuType.CATALOG.getValue());
		return getTreeTableList(sysDeptEntityList);
	}

	/*
	 * 递归装填所有的菜单
	 * */
	private List<SysDeptEntity> getTreeTableList(List<SysDeptEntity> sysDeptEntityList){

		for(SysDeptEntity sysDeptEntity:sysDeptEntityList){
			List<SysDeptEntity> sysMenuEntityListTemp = queryDetpList(sysDeptEntity.getDeptId());

			if(sysMenuEntityListTemp != null){
				sysDeptEntity.setChildren(getTreeTableList(sysMenuEntityListTemp));
			}else {
				continue;
			}

		}

		return sysDeptEntityList;
	}

	/**
	 * 递归
	 */
	private void getDeptTreeList(List<Long> subIdList, List<Long> deptIdList){
		for(Long deptId : subIdList){
			List<Long> list = queryDetpIdList(deptId);
			if(list.size() > 0){
				getDeptTreeList(list, deptIdList);
			}

			deptIdList.add(deptId);
		}
	}
}
