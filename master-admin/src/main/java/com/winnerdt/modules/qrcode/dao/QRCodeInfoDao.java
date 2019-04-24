package com.winnerdt.modules.qrcode.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.winnerdt.modules.qrcode.entity.QRCodeInfoEntity;

import java.util.List;
import java.util.Map;

/**
 * @author:zsk
 * @CreateTime:2019-04-15 15:51
 */
public interface QRCodeInfoDao extends BaseMapper<QRCodeInfoEntity> {
    /*
     * 分页查询列表，同时级联查询相关的信息
     * */
    List<QRCodeInfoEntity> queryQrCodeListPage(Map map);
    /*
     * 分页查询列表，同时级联查询相关的信息时，查询总数
     * */
    Long queryQrCodeListPageTotal(Map map);

    /*
     * 查询单个记录
     * */
    QRCodeInfoEntity queryQrCodeById(Integer qrCodeId);

}
