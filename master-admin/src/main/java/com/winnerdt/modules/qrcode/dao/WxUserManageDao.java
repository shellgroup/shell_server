package com.winnerdt.modules.qrcode.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.winnerdt.modules.qrcode.entity.WxUserManageEntity;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * @author:zsk
 * @CreateTime:2019-04-24 14:33
 */
public interface WxUserManageDao extends BaseMapper<WxUserManageEntity> {
    /*
     * 分页查询列表，同时级联查询相关的信息
     * */
    List<WxUserManageEntity> queryWxUserListPage(Map map);
    /*
     * 分页查询列表，同时级联查询相关的信息时，查询总数
     * */
    Long queryWxUserListPageTotal(Map map);
    /*
     * 查询单个记录
     * */
    WxUserManageEntity queryWxUserById(Integer wxUserId);

    /*
    * 查看部门的拉新排行,会将本部门下的所有子部门都列出来（包含子部门的子部门····）
    * */
    List<LinkedHashMap<String,Object>> queryRankingMsg(Map map);
}
