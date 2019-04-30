package com.winnerdt.dao;


import com.winnerdt.entity.QRCodeInfoEntity;

/**
 * @author:zsk
 * @CreateTime:2019-04-15 15:51
 */
public interface QRCodeInfoDao {


    /*
     * 查询单个记录
     * */
    QRCodeInfoEntity queryQrCodeById(Integer qrCodeId);

}
