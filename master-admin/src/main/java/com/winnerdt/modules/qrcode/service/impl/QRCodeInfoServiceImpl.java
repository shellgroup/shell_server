package com.winnerdt.modules.qrcode.service.impl;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.api.impl.WxMaServiceImpl;
import cn.binarywang.wx.miniapp.bean.WxMaCodeLineColor;
import cn.binarywang.wx.miniapp.config.WxMaInMemoryConfig;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.winnerdt.common.utils.PageUtils;
import com.winnerdt.common.utils.Query;
import com.winnerdt.common.utils.R;
import com.winnerdt.modules.qrcode.dao.QRCodeInfoDao;
import com.winnerdt.modules.qrcode.entity.QRCodeConfigEntity;
import com.winnerdt.modules.qrcode.entity.QRCodeInfoEntity;
import com.winnerdt.modules.qrcode.entity.WxAppinfoEntity;
import com.winnerdt.modules.qrcode.service.QRCodeConfigService;
import com.winnerdt.modules.qrcode.service.QRCodeInfoService;
import com.winnerdt.modules.qrcode.service.WxAppinfoService;
import com.winnerdt.modules.qrcode.utils.QRCodeUtils;
import me.chanjar.weixin.common.error.WxErrorException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author:zsk
 * @CreateTime:2019-04-15 15:33
 */
@Service
public class QRCodeInfoServiceImpl extends ServiceImpl<QRCodeInfoDao, QRCodeInfoEntity> implements QRCodeInfoService {
    private static final Logger logger = LoggerFactory.getLogger(QRCodeInfoServiceImpl.class);
    @Autowired
    private QRCodeInfoDao qrCodeDao;
    @Autowired
    private WxAppinfoService wxAppinfoService;
    @Autowired
    private QRCodeConfigService qrCodeConfigService;


    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<QRCodeInfoEntity> page = new Query<QRCodeInfoEntity>(params).getPage();
        Map map = new HashMap();
        //处理需要的参数
        try{
            if(null != params.get("userName")){
                map.put("userName",params.get("userName"));
            }
            if(null != params.get("mallType")){
                map.put("mallType",params.get("mallType"));
            }
            if(null != params.get("mallCode")){
                map.put("mallCode",params.get("mallCode"));
            }
            if(null != params.get("deptName")){
                map.put("deptName",params.get("deptName"));
            }
            if(null != params.get("userId")){
                map.put("userId",params.get("userId"));
            }
            if(null != params.get("userName")){
                map.put("userName",params.get("userName"));
            }
            if(null != params.get("userPhone")){
                map.put("userPhone",params.get("userPhone"));
            }
            if(null != params.get("imgBeginTime") && null != params.get("imgEndTime")){
                map.put("imgBeginTime",params.get("imgBeginTime"));
                map.put("imgEndTime",params.get("imgEndTime"));
            }
            if(null != params.get("enterpriseName")){
                map.put("enterpriseName",params.get("enterpriseName"));
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
            logger.error("后台二维码列表，处理参数异常，异常时间："+now+":::异常数据："+params.toString()+":::异常原因："+e.toString());

        }


        /*
         * 使用自定义的sql
         * */
        page.setRecords(qrCodeDao.queryShoppersCodeListPage(map));
        page.setTotal(qrCodeDao.queryShoppersCodeListPageTotal(map));


        return new PageUtils(page);
    }

    @Override
    public QRCodeInfoEntity queryQRCodeById(Integer qrCodeId) {
        QRCodeInfoEntity shoppersCodeEntity = qrCodeDao.queryShoppersCodeById(qrCodeId);
        return shoppersCodeEntity;
    }

    @Override
    public boolean save(QRCodeInfoEntity shoppersCodeEntity){
        return false;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(QRCodeInfoEntity shoppersCodeEntity) {

    }

    @Override
    public void deleteBatch(Long[] shoppersCodeIds) {

    }

    @Override
    public R createShoppersCode(Integer id) {
        QRCodeInfoEntity shoppersCodeEntity = qrCodeDao.selectById(id);
        return createShoppersCodeUtil(shoppersCodeEntity);
    }



    public R createShoppersCodeUtil(QRCodeInfoEntity qrCodeInfoEntity) {
        boolean autoColor = false;
        //底色是否透明 false=不透明
        boolean isHyaline = false;
        WxMaCodeLineColor color = new WxMaCodeLineColor("0", "0", "0");
        // get app info
        WxAppinfoEntity appinfo = wxAppinfoService.getById(qrCodeInfoEntity.getWxAppinfoId());
        if(null == appinfo){
            return R.error("请完善二维码配置信息");
        }
        String qrCode = qrCodeInfoEntity.getUserId();

        WxMaInMemoryConfig config = new WxMaInMemoryConfig();
        config.setAppid(appinfo.getAppid());
        config.setSecret(appinfo.getSecret());
        WxMaService wxMaService = new WxMaServiceImpl();
        wxMaService.setWxMaConfig(config);

        //获取码的相关配置
        QRCodeConfigEntity qrCodeConfigEntity = qrCodeConfigService.getById(qrCodeInfoEntity.getQrcodeConfigId());
        if(qrCodeConfigEntity == null){
            return R.error("请填写完整二维码的设置信息");
        }

        String destPath = qrCodeConfigEntity.getQrcodePath()
                + File.separator + "员工码"
                + File.separator + qrCodeInfoEntity.getMallName()
                + File.separator + qrCodeInfoEntity.getDeptName()
                + File.separator + qrCode + ".png";

        File dest = new File(destPath);
        File pDest = dest.getParentFile();
        if (!pDest.exists()) {
            pDest.mkdirs();
        }
        try {
            Date imgDate = new Date();
            final File wxCode = wxMaService.getQrcodeService().createWxaCodeUnlimit(qrCode, qrCodeConfigEntity.getQrcodeIndexUrl(), qrCodeConfigEntity.getQrcodeWidth(), autoColor, color,isHyaline);
            QRCodeUtils.graphicsGeneration(wxCode, dest, "No:" + qrCodeInfoEntity.getUserId(),qrCodeConfigEntity.getQrcodeFontHeight(),qrCodeConfigEntity.getQrcodeWidth(),qrCodeConfigEntity.getQrcodeHeight(),qrCodeConfigEntity.getQrcodeFontSize());
            //wxCode.renameTo(dest);
            qrCodeInfoEntity.setImgTime(imgDate);
            qrCodeInfoEntity.setImgPath(destPath);
            qrCodeInfoEntity.setImgName(qrCode+".png");
            qrCodeInfoEntity.setIsCreateQrcode(1);
            qrCodeDao.updateById(qrCodeInfoEntity);
           return R.ok();
        } catch (WxErrorException e) {
            e.printStackTrace();
            return R.error();
        } catch (Exception e) {
            e.printStackTrace();
            return R.error();
        }
    }

}
