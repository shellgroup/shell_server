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
import com.winnerdt.modules.qrcode.utils.ZipUtils;
import com.winnerdt.modules.sys.entity.SysDeptEntity;
import com.winnerdt.modules.sys.service.SysDeptService;
import com.winnerdt.modules.sys.service.SysRoleDeptService;
import com.winnerdt.modules.sys.service.SysUserRoleService;
import com.winnerdt.modules.sys.shiro.ShiroUtils;
import me.chanjar.weixin.common.error.WxErrorException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.Semaphore;
import java.util.zip.ZipOutputStream;

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
    @Autowired
    private SysDeptService sysDeptService;
    @Autowired
    private SysRoleDeptService sysRoleDeptService;
    @Autowired
    private SysUserRoleService sysUserRoleService;


    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        //获取当前的deptid
        Long deptId = ShiroUtils.getUserEntity().getDeptId();

        Long userId = ShiroUtils.getUserId();

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

            //查询拥有的部门id
            //部门ID列表
            Set<Long> deptIdList = new HashSet<>();
            //增加本部门id
            deptIdList.add(deptId);
            //是否需要角色分配下的deptId
            List<Long> roleIdList = sysUserRoleService.queryRoleIdList(userId);
            if(roleIdList.size() > 0){
                List<Long> userDeptIdList = sysRoleDeptService.queryDeptIdList(roleIdList.toArray(new Long[roleIdList.size()]));
                deptIdList.addAll(userDeptIdList);
            }
            //管理员子部门ID列表
            List<Long> subDeptIdList = sysDeptService.getSubDeptIdList(deptId);
            deptIdList.addAll(subDeptIdList);
            map.put("deptIdList",deptIdList);

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
        page.setRecords(qrCodeDao.queryQrCodeListPage(map));
        page.setTotal(qrCodeDao.queryQrCodeListPageTotal(map));


        return new PageUtils(page);
    }

    @Override
    public QRCodeInfoEntity queryQRCodeById(Integer qrCodeId) {
        QRCodeInfoEntity qrCodeInfoEntity = qrCodeDao.queryQrCodeById(qrCodeId);
        String qrcodeImgPath = qrCodeInfoEntity.getImgPath();
        try {
            byte[] b = Files.readAllBytes(Paths.get(qrcodeImgPath));
            qrCodeInfoEntity.setImgBase64("data:image/jpeg;base64,"+Base64.getEncoder().encodeToString(b));
        } catch (IOException e) {
            e.printStackTrace();
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String now = sdf.format(date);
            logger.error("获取二维码图片base64异常，异常时间："+now+":::异常原因："+e.toString());
            qrCodeInfoEntity.setImgBase64(null);
        }

        return qrCodeInfoEntity;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean save(QRCodeInfoEntity qrCodeInfoEntity){
        Long deptId = ShiroUtils.getUserEntity().getDeptId();
        //查询部门的相关信息补充到二维码表中
        SysDeptEntity sysDeptEntity = sysDeptService.getById(deptId);
        qrCodeInfoEntity.setDeptId(Integer.valueOf(String.valueOf(deptId)));
        qrCodeInfoEntity.setDeptName(sysDeptEntity.getName());
        qrCodeInfoEntity.setDeptCode(sysDeptEntity.getDeptCode());
        qrCodeInfoEntity.setIsDel(0);
        qrCodeInfoEntity.setIsCreateQrcode(0);
        qrCodeInfoEntity.setCreateTime(new Date());
        qrCodeInfoEntity.setUpdateTime(new Date());

        qrCodeDao.insert(qrCodeInfoEntity);
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(QRCodeInfoEntity qrCodeEntity) throws Exception {
        if(null == qrCodeEntity.getId()){
            throw new Exception("缺少参数");
        }
        //检查部门是否更改了，如果更改了还要更改有关部门的相关信息
        if(null != qrCodeEntity.getDeptId()){
            //查询部门的相关信息,更新二维码表中的部门信息
            SysDeptEntity sysDeptEntity = sysDeptService.getById(qrCodeEntity.getDeptId());
            qrCodeEntity.setDeptName(sysDeptEntity.getName());
            qrCodeEntity.setDeptCode(sysDeptEntity.getDeptCode());
        }
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
        QRCodeConfigEntity qrCodeConfigEntity = qrCodeConfigService.queryQRCodeConfigById(Integer.valueOf(map.get("qrcodeConfigId").toString()));
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
            QRCodeConfigEntity qrCodeConfigEntity = qrCodeConfigService.queryQRCodeConfigById(Integer.valueOf(map.get("qrcodeConfigId").toString()));
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
                    map1.put("wxAppinfoId",map.get("wxAppinfoId"));
                    createQrCodeUtil(map1,qrCodeConfigEntity,appinfo);
                    successNum ++;
                }catch (Exception e){
                    e.printStackTrace();
                    failQrcodeIdList.add(qrcodeIdList.get(i));
                    Date date = new Date();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String now = sdf.format(date);
                    logger.error("生成二维码异常，异常时间："+now+":::异常数据："+ JSONObject.toJSONString(map1)+":::异常原因："+e.toString());
                    continue;
                }

            }
            r.put("code","0");
            if(failQrcodeIdList.size() <= 0){
                r.put("msg","总共数量为："+qrcodeIdList.size()+" 成功生成数："
                        +successNum);
            }else {
                r.put("msg","总共数量为："+qrcodeIdList.size()+" 成功生成数："
                        +successNum+" 失败生成数："+failQrcodeIdList.size()
                        +" 失败的二维码id为："+JSONObject.toJSONString(failQrcodeIdList).replace("[","").replace("]"   ,""));
            }


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

    @Override
    public void download(HttpServletResponse response, Map map) throws Exception {
        if(null == map.get("qrcodeId")){
            return;
        }
        QRCodeInfoEntity qrCodeInfoEntity = qrCodeDao.selectById(map.get("qrcodeId").toString());
        if(null == qrCodeInfoEntity){
            return;
        }

        //开始下载
        String fileName = qrCodeInfoEntity.getDeptName()+"_"+qrCodeInfoEntity.getId()+".png";

        response.addHeader("Content-Disposition", "attachment;filename="  + new String(fileName.getBytes("GB2312"), "ISO_8859_1")     );
        OutputStream out = null;
        try {
            out = response.getOutputStream();
            String qrcodeImgPath = qrCodeInfoEntity.getImgPath();
            byte[] b = Files.readAllBytes(Paths.get(qrcodeImgPath));
            out.write(b);
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            out.close();
        }
    }

    @Override
    public void batchDownload(HttpServletResponse response, Map<String, Object> map) throws Exception {
        List qrcodeIdList = (List) map.get("qrcodeIdList");

        String zipName = "二维码图片";

        List<QRCodeInfoEntity> qrCodeInfoEntityList = qrCodeDao.selectBatchIds(qrcodeIdList);//查询数据库中记录
        response.setContentType("APPLICATION/OCTET-STREAM");
        response.addHeader("Content-Disposition", "attachment;filename="  + new String((zipName+".zip").getBytes("GB2312"), "ISO_8859_1"));
        ZipOutputStream out = new ZipOutputStream(response.getOutputStream());
        try {
            for(Iterator<QRCodeInfoEntity> it = qrCodeInfoEntityList.iterator();it.hasNext();){
                QRCodeInfoEntity file = it.next();
                ZipUtils.doCompress(new File(file.getImgPath()), out,zipName+file.getImgPathSub());
                response.flushBuffer();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e);
        }finally{
            out.close();
        }
    }

    public void createQrCodeUtil(Map map,QRCodeConfigEntity qrCodeConfigEntity,WxAppinfoEntity appinfo) throws Exception {
        boolean autoColor = false;
        //底色是否透明 false=不透明
        boolean isHyaline = false;
        WxMaCodeLineColor color = new WxMaCodeLineColor("0", "0", "0");

        /*
        * 处理二维码携带的参数信息
        * */
        Integer qrCodeId = Integer.valueOf(map.get("qrcodeId").toString());

        QRCodeInfoEntity qrCodeInfoEntity = qrCodeDao.selectById(qrCodeId);
        Integer deptId = qrCodeInfoEntity.getDeptId();

        StringBuffer qrcodeSceneStr = new StringBuffer();
        qrcodeSceneStr.append("q="+qrCodeId+"&d="+deptId);

        /*
        * 二维码的小程序配置信息
        * */

        WxMaInMemoryConfig config = new WxMaInMemoryConfig();
        config.setAppid(appinfo.getAppid());
        config.setSecret(appinfo.getSecret());
        WxMaService wxMaService = new WxMaServiceImpl();
        wxMaService.setWxMaConfig(config);


        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
        String now = sdf.format(date);

        String qrcodeShapeStr = null;
        if(qrCodeConfigEntity.getQrcodeShape() .equals(new Integer(0))){
            qrcodeShapeStr = "圆形码";
        }else {
            qrcodeShapeStr = "方形码";
        }

        /*
        * 二维码的全路径
        * */
        String destPath = qrCodeConfigEntity.getQrcodePath()
                + File.separator + qrCodeInfoEntity.getDeptName()
                + File.separator + qrCodeConfigEntity.getQrcodeTypeName()
//                + File.separator + now
//                + File.separator + qrcodeShapeStr
                + File.separator + qrCodeInfoEntity.getDeptName()+"_"+qrCodeId + ".png";
        /*
        * 生成二维码的部分目录，可以用于批量压缩下载时生成目录结构
        * */
        String imgPathSub = File.separator + qrCodeInfoEntity.getDeptName()
                + File.separator + qrCodeConfigEntity.getQrcodeTypeName()
//                + File.separator + now
//                + File.separator + qrcodeShapeStr
                ;

        File dest = new File(destPath);
        File pDest = dest.getParentFile();
        if (!pDest.exists()) {
            pDest.mkdirs();
        }
        try {
            Date imgDate = new Date();
            logger.info("******************生成码时的时间"+new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(imgDate)+"码参数："+qrcodeSceneStr.toString());
            if(qrCodeConfigEntity.getQrcodeShape().equals(new Integer(1))){
                //方形码
                String sceneStr = qrCodeConfigEntity.getQrcodeIndexUrl()+ "?scene="+qrcodeSceneStr.toString();
                final File wxCode = wxMaService.getQrcodeService().createQrcode(sceneStr, qrCodeConfigEntity.getQrcodeWidth());
                wxCode.renameTo(dest);
            }else {
                //圆形码
                final File wxCode = wxMaService.getQrcodeService().createWxaCodeUnlimit(qrcodeSceneStr.toString(), qrCodeConfigEntity.getQrcodeIndexUrl(), qrCodeConfigEntity.getQrcodeWidth(), autoColor, color,isHyaline);
                String str = "shell_"+String.format("%06d", qrCodeInfoEntity.getId());
                QRCodeUtils.graphicsGeneration(wxCode, dest, "No:" + str,qrCodeConfigEntity.getQrcodeFontHeight(),qrCodeConfigEntity.getQrcodeWidth(),qrCodeConfigEntity.getQrcodeHeight(),qrCodeConfigEntity.getQrcodeFontSize());
            }
            qrCodeInfoEntity.setImgTime(imgDate);
            qrCodeInfoEntity.setImgPath(destPath);
            qrCodeInfoEntity.setImgPathSub(imgPathSub);
            qrCodeInfoEntity.setImgName(qrCodeInfoEntity.getDeptName()+"_"+qrCodeId+".png");
            qrCodeInfoEntity.setIsCreateQrcode(1);
            qrCodeDao.updateById(qrCodeInfoEntity);


        } catch (WxErrorException e) {
            e.printStackTrace();
            throw new Exception(e);
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e);
        }
    }
}
