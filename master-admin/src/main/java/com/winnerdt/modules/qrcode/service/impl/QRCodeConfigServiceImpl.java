package com.winnerdt.modules.qrcode.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.winnerdt.modules.qrcode.dao.QRCodeConfigDao;
import com.winnerdt.modules.qrcode.entity.QRCodeConfigEntity;
import com.winnerdt.modules.qrcode.service.QRCodeConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author:zsk
 * @CreateTime:2019-04-15 17:11
 */
@Service
public class QRCodeConfigServiceImpl extends ServiceImpl<QRCodeConfigDao, QRCodeConfigEntity> implements QRCodeConfigService {
    @Autowired
    private QRCodeConfigDao qrCodeConfigDao;



}
