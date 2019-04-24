package com.winnerdt.modules.qrcode.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.winnerdt.common.annotation.DataFilter;
import com.winnerdt.common.utils.Constant;
import com.winnerdt.modules.qrcode.dao.WxUserManageDao;
import com.winnerdt.modules.qrcode.entity.WxUserManageEntity;
import com.winnerdt.modules.qrcode.service.WxUserManageService;
import com.winnerdt.modules.sys.service.SysDeptService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @author:zsk
 * @CreateTime:2019-04-24 14:53
 */
@Service
public class WxUserManageServiceImpl extends ServiceImpl<WxUserManageDao, WxUserManageEntity> implements WxUserManageService {
    @Autowired
    private WxUserManageDao wxUserManageDao;
    @Autowired
    private SysDeptService sysDeptService;

    @Override
    @DataFilter(subDept = false, user = false)
    public List<WxUserManageEntity> queryWxUserEntityListByDataFilter(Map map) {
        List<WxUserManageEntity> wxUserManageEntityList = wxUserManageDao.selectList(new QueryWrapper<WxUserManageEntity>()
                .apply(map.get(Constant.SQL_FILTER) != null, (String)map.get(Constant.SQL_FILTER)));
        return wxUserManageEntityList;
    }

    @Override
    @DataFilter(subDept = false, user = false)
    public Integer queryWxUserTotleByDataFilter(Map map) {
        Integer  wxUserTotle= wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .apply(map.get(Constant.SQL_FILTER) != null, (String)map.get(Constant.SQL_FILTER)));
        return wxUserTotle;
    }

    @Override
    public List<WxUserManageEntity> queryWxUserEntityListByDeptId(Map map) throws Exception {
        if(null == map.get("deptId")){
            throw new Exception("拉新会员信息统计，参数缺失");
        }
        Long deptId = Long.valueOf(map.get("deptId").toString());
        List<WxUserManageEntity> wxUserManageEntityList = wxUserManageDao.selectList(new QueryWrapper<WxUserManageEntity>()
                .apply(true, getSql(deptId,true,""))
        );
        return wxUserManageEntityList;
    }

    @Override
    public Integer queryWxUserTotleByDeptId(Map map) throws Exception {
        if(null == map.get("deptId")){
            throw new Exception("拉新会员数量统计，参数缺失");
        }
        Long deptId = Long.valueOf(map.get("deptId").toString());
        Integer  wxUserTotle= wxUserManageDao.selectCount(new QueryWrapper<WxUserManageEntity>()
                .apply(true, getSql(deptId,true,"")));
        return wxUserTotle;
    }

    /*
    * 通过deptId，拼接查询sql
    * */
    private String getSql(Long deptId,boolean isContainMyDept,String tableAlias){

        //获取表的别名
        if(StringUtils.isNotBlank(tableAlias)){
            tableAlias +=  ".";
        }

        //部门ID列表
        Set<Long> deptIdList = new HashSet<>();
        if(isContainMyDept){
            deptIdList.add(deptId);
        }

        //子部门ID列表
        List<Long> subDeptIdList = sysDeptService.getSubDeptIdList(deptId);
        deptIdList.addAll(subDeptIdList);


        StringBuilder sqlFilter = new StringBuilder();
        sqlFilter.append(" (");

        if(deptIdList.size() > 0){
            sqlFilter.append(tableAlias).append("dept_id").append(" in(").append(StringUtils.join(deptIdList, ",")).append(")");
        }

        sqlFilter.append(")");

        if(sqlFilter.toString().trim().equals("()")){
            return null;
        }
        return sqlFilter.toString();
    }
}
