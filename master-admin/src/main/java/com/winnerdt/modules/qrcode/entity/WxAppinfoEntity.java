package com.winnerdt.modules.qrcode.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * @author:zsk
 * @CreateTime:2019-04-15 16:40
 */
@Data
@TableName("wx_appinfo")
public class WxAppinfoEntity {

    @TableId
    private Integer id;

    //小程序id
    private String appid;

    //小程序secret
    private String secret;

    //小程序名
    private String name;

    //消息token
    private String token;

    //消息aeskey
    private String aeskey;

    //微信访问token
    private String accessToken;

    //上次生成accesstoken时间
    private Date lastTokenTime;

    //微信token有效时间单位（秒）
    private Integer expiresIn;

    //说明
    private String remark;

}
