package com.winnerdt.modules.qrcode.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.winnerdt.common.utils.PageUtils;
import com.winnerdt.common.utils.Query;
import com.winnerdt.modules.qrcode.dao.QRCodeConfigDao;
import com.winnerdt.modules.qrcode.entity.QRCodeConfigEntity;
import com.winnerdt.modules.qrcode.service.QRCodeConfigService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author:zsk
 * @CreateTime:2019-04-15 17:11
 */
@Service
public class QRCodeConfigServiceImpl extends ServiceImpl<QRCodeConfigDao, QRCodeConfigEntity> implements QRCodeConfigService {
    private static final Logger logger = LoggerFactory.getLogger(QRCodeConfigServiceImpl.class);
    @Autowired
    private QRCodeConfigDao qrCodeConfigDao;


    @Override
    public PageUtils queryPage(Map<String, Object> params) {

        Page<QRCodeConfigEntity> page = new Query<QRCodeConfigEntity>(params).getPage();
        Map map = new HashMap();
        //处理需要的参数
        try{
            if(null != params.get("qrcodeConfigName")){
                map.put("qrcodeConfigName",params.get("qrcodeConfigName"));
            }
            if(null != params.get("qrcodeShape")){
                map.put("qrcodeShape",params.get("qrcodeShape"));
            }
            if(null != params.get("createBeginTime") && null != params.get("createEndTime")){
                map.put("createBeginTime",params.get("createBeginTime"));
                map.put("createEndTime",params.get("createEndTime"));
            }

            map.put("pageSize",page.getSize());
            map.put("currRecord",(page.getCurrent()-1)*page.getSize());
        }catch (Exception e){
            e.printStackTrace();
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String now = sdf.format(date);
            logger.error("后台二维码设置列表，处理参数异常，异常时间："+now+":::异常数据："+params.toString()+":::异常原因："+e.toString());

        }


        /*
         * 使用自定义的sql
         * */
        page.setRecords(qrCodeConfigDao.queryQrCodeConfigListPage(map));
        page.setTotal(qrCodeConfigDao.queryQrCodeConfigListPageTotal(map));


        return new PageUtils(page);
    }

    @Override
    public boolean save(QRCodeConfigEntity qrCodeConfigEntity) {
        qrCodeConfigEntity.setCreateTime(new Date());
        qrCodeConfigEntity.setUpdateTime(new Date());
        qrCodeConfigEntity.setIsDel(0);
        qrCodeConfigDao.updateById(qrCodeConfigEntity);
        return true;
    }


    @Override
    public QRCodeConfigEntity queryQRCodeConfigById(Integer qrCodeConfigId) {
        return qrCodeConfigDao.queryQrCodeConfigById(qrCodeConfigId);
    }

    @Override
    public void update(QRCodeConfigEntity qrCodeConfigEntity) throws Exception {
        if(null == qrCodeConfigEntity.getId()){
            throw new Exception("缺少参数");
        }
        qrCodeConfigDao.updateById(qrCodeConfigEntity);
    }

    @Override
    public void deleteBatch(Long[] qrCodeConfigIds) {
        qrCodeConfigDao.deleteBatchIds(Arrays.asList(qrCodeConfigIds));
    }
}
