package com.winnerdt.service.impl;

import com.winnerdt.dao.QRCodeInfoDao;
import com.winnerdt.entity.QRCodeInfoEntity;
import com.winnerdt.service.QRCodeInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author:zsk
 * @CreateTime:2019-04-15 15:33
 */
@Service
public class QRCodeInfoServiceImpl implements QRCodeInfoService {
    @Autowired
    private QRCodeInfoDao qrCodeDao;



    @Override
    public QRCodeInfoEntity queryQRCodeById(Integer qrCodeId) {
        QRCodeInfoEntity qrCodeInfoEntity = qrCodeDao.queryQrCodeById(qrCodeId);
        return qrCodeInfoEntity;
    }

}
