package com.winnerdt.modules.qrcode.controller;

import com.alibaba.fastjson.JSONObject;
import com.winnerdt.common.annotation.SysLog;
import com.winnerdt.common.utils.PageUtils;
import com.winnerdt.common.utils.R;
import com.winnerdt.common.validator.ValidatorUtils;
import com.winnerdt.modules.qrcode.entity.QRCodeConfigEntity;
import com.winnerdt.modules.qrcode.service.QRCodeConfigService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * @author:zsk
 * @CreateTime:2019-04-16 15:23
 */
@RequestMapping("qrcode/config")
@RestController
public class QRCodeConfigController {
    private static final Logger logger = LoggerFactory.getLogger(QRCodeInfoController.class);
    @Autowired
    private QRCodeConfigService qrCodeConfigService;

    /*
     * 查询列表
     * */
    @RequestMapping("/list")
    @RequiresPermissions("qrcode:config:list")
    public R list(@RequestBody Map<String, Object> params) {
        //查询分页信息
        PageUtils page = qrCodeConfigService.queryPage(params);

        return R.ok().put("list", page.getList()).put("pagination",page.getPagination());
    }
    /*
     * 查询单个码配置信息
     * */
    @RequestMapping("/info/{qrCodeId}")
    @RequiresPermissions("qrcode:config:info")
    public R info(@PathVariable("qrCodeConfigId") Integer qrCodeConfigId){
        QRCodeConfigEntity qrCodeConfigEntity = qrCodeConfigService.queryQRCodeConfigById(qrCodeConfigId);

        return R.ok().put("qrCodeConfigInfo",qrCodeConfigEntity);
    }


    /**
     * 保存二维码配置信息
     */
    @SysLog("保存二维码配置信息")
    @RequestMapping("/save")
    @RequiresPermissions("qrcode:config:save")
    public R save(@RequestBody QRCodeConfigEntity qrCodeConfigEntity){
        ValidatorUtils.validateEntity(qrCodeConfigEntity);

        try{
            /*保存码配置信息*/
            qrCodeConfigService.save(qrCodeConfigEntity);
            return R.ok();
        }catch (Exception e){
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String now = sdf.format(date);
            logger.error("保存码配置信息异常，异常时间："+now+":::异常数据："+qrCodeConfigEntity.toString()+":::异常原因："+e.toString());
            return R.error("网络错误，二维码配置信息新增失败！");
        }

    }


    /*
     * 修改二维码信息
     * */
    @SysLog("修改二维码信息")
    @RequestMapping("/update")
    @RequiresPermissions("qrcode:config:update")
    public R update(@RequestBody QRCodeConfigEntity qrCodeConfigEntity){
        ValidatorUtils.validateEntity(qrCodeConfigEntity);

        try{
            qrCodeConfigService.update(qrCodeConfigEntity);
            return R.ok();
        }catch (Exception e){
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String now = sdf.format(date);
            logger.error("更新二维码配置信息异常，异常时间："+now+":::异常数据："+qrCodeConfigEntity.toString()+":::异常原因："+e.toString());
            return R.error("网络错误，二维码配置信息更新失败！");
        }

    }


    /*
     * 删除二维码信息
     * */
    @SysLog("删除二维码信息")
    @RequestMapping("/delete")
    @RequiresPermissions("qrcode:config:delete")
    public R delete(@RequestBody Long[] qrCodeConfigIds){
        try{
            qrCodeConfigService.deleteBatch(qrCodeConfigIds);
            return R.ok();
        }catch (Exception e){
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String now = sdf.format(date);
            logger.error("删除二维码配置信息异常，异常时间："+now+":::异常数据："+ JSONObject.toJSONString(qrCodeConfigIds)+":::异常原因："+e.toString());
            return R.error("网络错误，二维码配置信息删除失败！");
        }
    }



}