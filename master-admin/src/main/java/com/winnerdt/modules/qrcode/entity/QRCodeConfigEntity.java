package com.winnerdt.modules.qrcode.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * @author:zsk
 * @CreateTime:2019-04-15 16:48
 */
@Data
@TableName("qrcode_config")
public class QRCodeConfigEntity {

    @TableId
    private Integer id;

    //生成二维码高度
    private Integer qrcodeHeight;

    //生成二维码宽度
    private Integer qrcodeWidth;

    //文字大小
    private Integer qrcodeFontSize;

    //文字高度
    private Integer qrcodeFontHeight;

    //扫描二维码待跳转页面
    private String qrcodeIndexUrl;

    //二维码图片生成后存放地址
    private String qrcodePath;

    //逻辑删除：0=未删除，1=已经删除
    @TableLogic
    private Integer isDel;

    //该条配置的名称
    private String qrcodeConfigName;

    //说明
    private String remark;

    //二维码的形状：0=圆形，1=方形
    private Integer qrcodeShape;

    //创建时间
    private Date createTime;

    //最后修改时间
    private Date updateTime;

    @TableField(exist = false)
    private String qrcodeTypeName;

}
