package com.winnerdt.modules.qrcode.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.winnerdt.modules.qrcode.entity.WxUserManageEntity;

import java.util.List;
import java.util.Map;

/**
 * @author:zsk
 * @CreateTime:2019-04-24 14:52
 */
public interface WxUserManageService extends IService<WxUserManageEntity> {

    /*
    * 通过数据权限筛选，获取该部门下的微信小程序拉新人员信息（包括本部门）
    * */
    List<WxUserManageEntity> queryWxUserEntityListByDataFilter(Map map);

    /*
    * 通过数据权限筛选，获取该部门下的微信小程序拉新人员数量（包括本部门拉新数量）
    * */
    Integer queryWxUserTotleByDataFilter(Map map);

    /*
    * 通过deptId筛选，获取该deptId下的微信小程序拉新人员信息（包含本部门的）
    * */
    List<WxUserManageEntity> queryWxUserEntityListByDeptId(Map map) throws Exception;

    /*
    * 通过deptId筛选，获取该deptId下的微信小程序拉新人员数量（包含本部门的）
    * */
    Integer queryWxUserTotleByDeptId(Map map) throws Exception;
}