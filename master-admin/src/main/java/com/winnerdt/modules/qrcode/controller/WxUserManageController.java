package com.winnerdt.modules.qrcode.controller;

import com.winnerdt.common.utils.PageUtils;
import com.winnerdt.common.utils.R;
import com.winnerdt.modules.qrcode.entity.WxUserManageEntity;
import com.winnerdt.modules.qrcode.service.WxUserManageService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author:zsk
 * @CreateTime:2019-04-24 14:31
 */
@RestController
@RequestMapping("wxUser/manage")
public class WxUserManageController {
    private static final Logger logger = LoggerFactory.getLogger(QRCodeInfoController.class);
    @Autowired
    private WxUserManageService wxUserManageService;



    /*
    * 列表查看
    * */
    @RequestMapping("/list")
    @RequiresPermissions("wxUser:manage:list")
    public R list(@RequestParam Map<String, Object> params) {
        //查询分页信息
        PageUtils page = wxUserManageService.queryPage(params);

        return R.ok().put("list", page.getList()).put("pagination",page.getPagination());
    }

    /*
     * 查询单个会员信息
     * */
    @RequestMapping("/info/{wxUserId}")
    @RequiresPermissions("wxUserId:manage:info")
    public R info(@PathVariable("wxUserId") Integer wxUserId){
        WxUserManageEntity wxUserManageEntity = wxUserManageService.queryWxUserById(wxUserId);

        return R.ok().put("wxUserManageEntity",wxUserManageEntity);
    }




    /*
    * 获取该渠道商下的总拉新数目,包括周同比，日同比和日拉新数量
    * */
    @RequestMapping("WxUserInfoByDataFilter")
    public R  WxUserTotleByDataFilter() {
        R r = new R();
        try {
            r = wxUserManageService.WxUserInfoByDataFilter();
        } catch (ParseException e) {
            e.printStackTrace();
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String now = sdf.format(date);
            logger.error("获取该渠道商下的总拉新数目信息异常，异常时间："+now+":::异常数据："+":::异常原因："+e.toString());
            return R.error("网络错误，获取该渠道商下的总拉新数目信息失败！");
        }

        return r;
    }

    /*
    * 根据时间查询本部门近7天的拉新数量
    * */
    @RequestMapping("queryWxUserTotleLastWeek")
    public R queryWxUserTotleLastWeek(){

        HashMap map = new HashMap();
        return wxUserManageService.queryWxUserTotleLastWeek(map);
    }

    /*
    * 拉取排名信息
    * */
    @RequestMapping("queryRankingMsg")
    public R queryRankingMsg(@RequestBody Map<String,String> map){
        try {
            return wxUserManageService.queryRankingMsg(map);
        } catch (Exception e) {
            e.printStackTrace();
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String now = sdf.format(date);
            logger.error("获取该渠道商下的排名信息异常，异常时间："+now+":::异常数据："+":::异常原因："+e.toString());
            return R.error("网络异常，获取该渠道商下的排名信息失败");
        }

    }



}
