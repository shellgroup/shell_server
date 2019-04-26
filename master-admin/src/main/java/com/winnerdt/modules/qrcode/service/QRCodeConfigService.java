package com.winnerdt.modules.qrcode.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.winnerdt.common.utils.PageUtils;
import com.winnerdt.modules.qrcode.entity.QRCodeConfigEntity;

import java.util.List;
import java.util.Map;

/**
 * @author:zsk
 * @CreateTime:2019-04-15 17:10
 */
public interface QRCodeConfigService extends IService<QRCodeConfigEntity> {
    PageUtils queryPage(Map<String, Object> params);

    /*
     * 查询单个记录
     * */
    QRCodeConfigEntity queryQRCodeConfigById(Integer qrCodeConfigId);

    @Override
    boolean save(QRCodeConfigEntity qrCodeConfigEntity);

    void update(QRCodeConfigEntity qrCodeConfigEntity) throws Exception;

    void deleteBatch(Long[] qrCodeConfigIds);

    /*
    * 查询所有的码参数记录
    * */
    List<QRCodeConfigEntity> getQrcodeConfigList();

    /*
     *
     * 检测二维码配置名称是否已经存在
     * */
    String isExitQrcodeConfig(String qrcodeConfigName);
}
