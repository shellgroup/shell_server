package com.winnerdt.modules.qrcode.controller;

import com.winnerdt.common.utils.R;
import com.winnerdt.modules.qrcode.service.WxUserManageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;

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
    * 获取该渠道商下的拉新数目
    * */
    @RequestMapping("WxUserTotleByDataFilter")
    public R  WxUserTotleByDataFilter() {
        HashMap map = new HashMap();
        Integer wxUserTotle = wxUserManageService.queryWxUserTotleByDataFilter(map);
        return R.ok().put("totle",wxUserTotle);
    }

}
