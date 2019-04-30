package com.winnerdt.service;


import com.winnerdt.entity.QRCodeInfoEntity;

/**
 * @author:zsk
 * @CreateTime:2019-04-15 15:33
 */
public interface QRCodeInfoService {

    /*
    * 查询单个记录
    * */
    QRCodeInfoEntity queryQRCodeById(Integer qrCodeId);



}
