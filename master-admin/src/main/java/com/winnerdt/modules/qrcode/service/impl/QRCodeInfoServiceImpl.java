package com.winnerdt.modules.qrcode.service.impl;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.api.impl.WxMaServiceImpl;
import cn.binarywang.wx.miniapp.bean.WxMaCodeLineColor;
import cn.binarywang.wx.miniapp.config.WxMaInMemoryConfig;
import com.alibaba.fastjson.JSONObject;
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
import java.util.*;
import java.util.concurrent.Semaphore;

/**
 * @author:zsk
 * @CreateTime:2019-04-15 15:33
 */
@Service
public class QRCodeInfoServiceImpl extends ServiceImpl<QRCodeInfoDao, QRCodeInfoEntity> implements QRCodeInfoService {
    private static final Logger logger = LoggerFactory.getLogger(QRCodeInfoServiceImpl.class);
    private static Semaphore semaphore = new Semaphore(2);
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
    @Transactional(rollbackFor = Exception.class)
    public boolean save(QRCodeInfoEntity qrCodeInfoEntity){
        qrCodeDao.insert(qrCodeInfoEntity);
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(QRCodeInfoEntity qrCodeEntity) {
        qrCodeDao.updateById(qrCodeEntity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteBatch(Long[] qrCodeIds) {
        qrCodeDao.deleteBatchIds(Arrays.asList(qrCodeIds));
    }

    @Override
    public R createQrCode(Map map) {
        if(map.get("qrcodeId") == null || ("").equals(map.get("qrcodeId"))){
            return R.error("参数不完整");
        }
        if(map.get("qrcodeConfigId") == null || ("").equals(map.get("qrcodeConfigId"))){
            return R.error("参数不完整");
        }
        if(map.get("wxAppinfoId") == null || ("").equals(map.get("wxappinfoId"))){
            return R.error("参数不完整");
        }
        //获取小程序配置信息
        WxAppinfoEntity appinfo = wxAppinfoService.getById(Integer.valueOf(map.get("wxAppinfoId").toString()));
        if(null == appinfo){
            return R.error("二维码配置信息为空");
        }
        //获取码的相关配置
        QRCodeConfigEntity qrCodeConfigEntity = qrCodeConfigService.getById(Integer.valueOf(map.get("qrcodeConfigId").toString()));
        if(qrCodeConfigEntity == null){
            return R.error("请填写完整二维码的设置信息");
        }
        try {
            createQrCodeUtil(map,qrCodeConfigEntity,appinfo);
            return R.ok();
        }catch (Exception e){
            e.printStackTrace();
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String now = sdf.format(date);
            logger.error("生成二维码异常，异常时间："+now+":::异常数据："+ JSONObject.toJSONString(map)+":::异常原因："+e.toString());
            return R.error("网络错误，二维码生成失败");
        }

    }


    @Override
    public R createQrCodes(Map map) {
        if(!semaphore.tryAcquire(1)) {
            return R.error("当前访问人数过多，请等待5分钟后重试");
        }

        R r = new R();
        try {
            if(map.get("qrcodeIds") == null || ("").equals(map.get("qrcodeId"))){
                return R.error("参数不完整");
            }
            if(map.get("qrcodeConfigId") == null || ("").equals(map.get("qrcodeConfigId"))){
                return R.error("参数不完整");
            }
            if(map.get("wxAppinfoId") == null || ("").equals(map.get("wxappinfoId"))){
                return R.error("参数不完整");
            }
            WxAppinfoEntity appinfo = wxAppinfoService.getById(Integer.valueOf(map.get("wxAppinfoId").toString()));
            if(null == appinfo){
                return R.error("二维码配置信息为空");
            }
            //获取码的相关配置
            QRCodeConfigEntity qrCodeConfigEntity = qrCodeConfigService.getById(Integer.valueOf(map.get("qrcodeConfigId").toString()));
            if(qrCodeConfigEntity == null){
                return R.error("请填写完整二维码的设置信息");
            }
            /*
             * 处理参数
             * */
            List<Integer> qrcodeIdList = (List) map.get("qrcodeIds");
            int successNum = 0;
            List<Integer> failQrcodeIdList = new ArrayList<>();
            for(int i = 0;i < qrcodeIdList.size();i++){
                Map map1 = new HashMap();
                try{
                    map1.put("qrcodeId",qrcodeIdList.get(i));
                    map1.put("qrcodeConfigId",map.get("qrcodeConfigId"));
                    map1.put("wxAppinfoId",map.get("wxappinfoId"));
                    createQrCodeUtil(map,qrCodeConfigEntity,appinfo);
                }catch (Exception e){
                    failQrcodeIdList.add(qrcodeIdList.get(i));
                    Date date = new Date();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String now = sdf.format(date);
                    logger.error("生成二维码异常，异常时间："+now+":::异常数据："+ JSONObject.toJSONString(map1)+":::异常原因："+e.toString());
                    continue;
                }

            }
            r.put("code","0");
            r.put("msg","总共数量为："+qrcodeIdList.size()+"<br>成功生成数："
                    +successNum+"<br>失败生成数："+failQrcodeIdList.size()
                    +"<br>失败的二维码id为："+JSONObject.toJSONString(failQrcodeIdList).replace("[","").replace("]",""));

            //根据中数目，执行完之后睡一会，防止一分钟访问次数过多，微信接口一分钟5000次
            if(qrcodeIdList.size() <= 50){
                Thread.sleep(2000);
            }else if(qrcodeIdList.size() <= 100){
                Thread.sleep(10000);
            }else if(qrcodeIdList.size() <= 300) {
                Thread.sleep(20000);
            }else if(qrcodeIdList.size() <= 500){
                Thread.sleep(32000);
            }else{
                Thread.sleep(60000);
            }

        } catch (InterruptedException e) {
            e.printStackTrace();

            return R.error("网络错误，二维码生成失败");
        } finally {
            semaphore.release();
        }

        return r;
    }

    public void createQrCodeUtil(Map map,QRCodeConfigEntity qrCodeConfigEntity,WxAppinfoEntity appinfo) {
        boolean autoColor = false;
        //底色是否透明 false=不透明
        boolean isHyaline = false;
        WxMaCodeLineColor color = new WxMaCodeLineColor("0", "0", "0");

        /*
        * 处理二维码携带的参数信息
        * */
        Integer qrCodeId = Integer.valueOf(map.get("qrcodeId").toString());
        QRCodeInfoEntity qrCodeInfoEntity = qrCodeDao.selectById(qrCodeId);
        String deptId = qrCodeInfoEntity.getDeptId();
        QrcodeScene qrcodeScene = new QrcodeScene();
        qrcodeScene.setQrCodeId(qrCodeId);
        qrcodeScene.setDeptId(deptId);
        String qrcodeSceneStr = JSONObject.toJSONString(qrcodeScene);

        /*
        * 二维码的小程序配置信息
        * */
        WxMaInMemoryConfig config = new WxMaInMemoryConfig();
        config.setAppid(appinfo.getAppid());
        config.setSecret(appinfo.getSecret());
        WxMaService wxMaService = new WxMaServiceImpl();
        wxMaService.setWxMaConfig(config);



        String destPath = qrCodeConfigEntity.getQrcodePath()
                + File.separator + "员工码"
                + File.separator + qrCodeInfoEntity.getMallName()
                + File.separator + qrCodeInfoEntity.getDeptName()
                + File.separator + qrCodeId + ".png";

        File dest = new File(destPath);
        File pDest = dest.getParentFile();
        if (!pDest.exists()) {
            pDest.mkdirs();
        }
        try {
            Date imgDate = new Date();
            final File wxCode = wxMaService.getQrcodeService().createWxaCodeUnlimit(qrcodeSceneStr, qrCodeConfigEntity.getQrcodeIndexUrl(), qrCodeConfigEntity.getQrcodeWidth(), autoColor, color,isHyaline);
            if(qrCodeConfigEntity.getQrcodeShape().equals("1")){
                QRCodeUtils.graphicsGeneration(wxCode, dest, "No:" + qrCodeInfoEntity.getUserId(),qrCodeConfigEntity.getQrcodeFontHeight(),qrCodeConfigEntity.getQrcodeWidth(),qrCodeConfigEntity.getQrcodeHeight(),qrCodeConfigEntity.getQrcodeFontSize());
            }else {
                wxCode.renameTo(dest);
            }
            qrCodeInfoEntity.setImgTime(imgDate);
            qrCodeInfoEntity.setImgPath(destPath);
            qrCodeInfoEntity.setImgName(qrCodeId+".png");
            qrCodeInfoEntity.setIsCreateQrcode(1);
            qrCodeDao.updateById(qrCodeInfoEntity);

        } catch (WxErrorException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    /*
     * 存放二维码参数
     * */
    class QrcodeScene{
        Integer qrCodeId;
        String deptId;

        public Integer getQrCodeId() {
            return qrCodeId;
        }

        public void setQrCodeId(Integer qrCodeId) {
            this.qrCodeId = qrCodeId;
        }

        public String getDeptId() {
            return deptId;
        }

        public void setDeptId(String deptId) {
            this.deptId = deptId;
        }
    }
}
