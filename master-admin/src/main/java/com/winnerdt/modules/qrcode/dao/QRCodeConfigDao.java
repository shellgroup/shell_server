package com.winnerdt.modules.qrcode.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.winnerdt.modules.qrcode.entity.QRCodeConfigEntity;

import java.util.List;
import java.util.Map;

/**
 * @author:zsk
 * @CreateTime:2019-04-15 17:01
 */
public interface QRCodeConfigDao extends BaseMapper<QRCodeConfigEntity> {
    /*
     * 分页查询列表，同时级联查询相关的信息
     * */
    List<QRCodeConfigEntity> queryQrCodeConfigListPage(Map map);
    /*
     * 分页查询列表，同时级联查询相关的信息时，查询总数
     * */
    Long queryQrCodeConfigListPageTotal(Map map);
    /*
     * 查询单个记录
     * */
    QRCodeConfigEntity queryQrCodeConfigById(Integer qrCodeConfigId);
}
