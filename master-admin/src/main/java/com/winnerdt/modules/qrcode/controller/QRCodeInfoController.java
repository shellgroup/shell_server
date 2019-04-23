package com.winnerdt.modules.qrcode.controller;

import com.alibaba.fastjson.JSONObject;
import com.winnerdt.common.annotation.SysLog;
import com.winnerdt.common.utils.PageUtils;
import com.winnerdt.common.utils.R;
import com.winnerdt.common.validator.ValidatorUtils;
import com.winnerdt.modules.qrcode.entity.QRCodeInfoEntity;
import com.winnerdt.modules.qrcode.service.QRCodeInfoService;
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
 * @CreateTime:2019-04-15 15:00
 */
@RestController
@RequestMapping("/qrcode/info")
public class QRCodeInfoController {
    private static final Logger logger = LoggerFactory.getLogger(QRCodeInfoController.class);
    @Autowired
    private QRCodeInfoService qrCodeInfoService;

    /*
     * 查询列表
     * */
    @RequestMapping("/list")
    @RequiresPermissions("qrcode:info:list")
    public R list(@RequestBody Map<String, Object> params) {
        //查询分页信息
        PageUtils page = qrCodeInfoService.queryPage(params);

        return R.ok().put("list", page.getList()).put("pagination",page.getPagination());
    }
    /*
     * 查询单个码信息
     * */
    @RequestMapping("/info/{qrCodeId}")
    @RequiresPermissions("qrcode:info:info")
    public R info(@PathVariable("qrCodeId") Integer shoppersCodeId){
        QRCodeInfoEntity qrCodeInfoEntity = qrCodeInfoService.queryQRCodeById(shoppersCodeId);

        return R.ok().put("userInfo",qrCodeInfoEntity);
    }


    /**
     * 保存二维码信息
     */
    @SysLog("保存二维码")
    @RequestMapping("/save")
    @RequiresPermissions("qrcode:info:save")
    public R save(@RequestBody QRCodeInfoEntity qrCodeInfoEntity){
        ValidatorUtils.validateEntity(qrCodeInfoEntity);

        try{
            /*保存码信息*/
            qrCodeInfoService.save(qrCodeInfoEntity);
            return R.ok();
        }catch (Exception e){
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String now = sdf.format(date);
            logger.error("保存码信息异常，异常时间："+now+":::异常数据："+qrCodeInfoEntity.toString()+":::异常原因："+e.toString());
            return R.error("网络错误，二维码新增失败！");
        }

    }


    /*
     * 修改二维码信息
     * */
    @SysLog("修改二维码信息")
    @RequestMapping("/update")
    @RequiresPermissions("qrcode:info:update")
    public R update(@RequestBody QRCodeInfoEntity qrCodeInfoEntity){
        ValidatorUtils.validateEntity(qrCodeInfoEntity);

        try{
            qrCodeInfoService.update(qrCodeInfoEntity);
            return R.ok();
        }catch (Exception e){
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String now = sdf.format(date);
            logger.error("更新导购码信息异常，异常时间："+now+":::异常数据："+qrCodeInfoEntity.toString()+":::异常原因："+e.toString());
            return R.error("网络错误，导购码更新失败！");
        }

    }


    /*
     * 删除二维码信息
     * */
    @SysLog("删除二维码信息")
    @RequestMapping("/delete")
    @RequiresPermissions("qrcode:info:delete")
    public R delete(@RequestBody Long[] qrCodeIds){
        try{
            qrCodeInfoService.deleteBatch(qrCodeIds);
            return R.ok();
        }catch (Exception e){
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String now = sdf.format(date);
            logger.error("删除二维码信息异常，异常时间："+now+":::异常数据："+ JSONObject.toJSONString(qrCodeIds)+":::异常原因："+e.toString());
            return R.error("网络错误，二维码删除失败！");
        }
    }

    /*
    * 生成的单个二维码
    * */
    @RequestMapping("createqrCode")
    @RequiresPermissions("qrcode:info:createqrCode")
    public R createQRCode(@RequestBody Map map){

        /*
        * map的字段名：
        * qrcodeId:二维码id
        * qrcodeConfigId：二维码参数id
        * wxAppinfoId：小程序参数id
        * */
        return qrCodeInfoService.createQrCode(map);
    }

    /*
    * 生成多个二维码
    * */
    @RequestMapping("createqrCodes")
    @RequiresPermissions("qrcode:info:createqrCodes")
    public R createqrCodes(@RequestBody Map map){
        /*
        * map参数说明：
        * qrcodeIds：二维码id，示例：[1,2]
        * qrcodeConfigId：二维码参数id
        * wxAppinfoId：小程序参数id
        *
        * */

        return qrCodeInfoService.createQrCodes(map);
    }

}
