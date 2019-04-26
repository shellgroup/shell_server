package com.winnerdt.modules.qrcode.controller;

import com.winnerdt.common.utils.PageUtils;
import com.winnerdt.common.utils.R;
import com.winnerdt.modules.qrcode.entity.WxUserManageEntity;
import com.winnerdt.modules.qrcode.service.WxUserManageService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * @author:zsk
 * @CreateTime:2019-04-24 14:31
 */
@RestController
@RequestMapping("wxUser/manage")
public class WxUserManageController {
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
    * 获取该渠道商下的拉新数目
    * */
    @RequestMapping("WxUserTotleByDataFilter")
    public R  WxUserTotleByDataFilter() {
        HashMap map = new HashMap();
        Integer wxUserTotle = wxUserManageService.queryWxUserTotleByDataFilter(map);
        return R.ok().put("totle",wxUserTotle);
    }

}
