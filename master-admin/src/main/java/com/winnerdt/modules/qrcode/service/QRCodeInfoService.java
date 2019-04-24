package com.winnerdt.modules.qrcode.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.winnerdt.common.utils.PageUtils;
import com.winnerdt.common.utils.R;
import com.winnerdt.modules.qrcode.entity.QRCodeInfoEntity;

import java.util.Map;

/**
 * @author:zsk
 * @CreateTime:2019-04-15 15:33
 */
public interface QRCodeInfoService extends IService<QRCodeInfoEntity> {


    PageUtils queryPage(Map<String, Object> params);

    /*
    * 查询单个记录
    * */
    QRCodeInfoEntity queryQRCodeById(Integer qrCodeId);

    @Override
    boolean save(QRCodeInfoEntity qrCodeInfoEntity);

    void update(QRCodeInfoEntity qrCodeInfoEntity) throws Exception;

    void deleteBatch(Long[] qrCodeIds);

    /*
     * 生成单个二维码
     * */
    R createQrCode(Map map);

    /*
    * 生成多个二维码
    * */
    R createQrCodes(Map map);
}
