package com.winnerdt.modules.qrcode.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.util.Date;

/**
 * @author:zsk
 * @CreateTime:2019-04-15 15:34
 */
@Data
public class QRCodeInfoEntity {

    @TableId
    private Integer id;

    //商店类型
    private String mallType;

    //商店编码
    private String mallCode;

    //商店名称
    private String mallName;

    //部门名称
    private String deptName;

    //用户id
    private String userId;

    //用户名称
    private String userName;

    //用户手机号
    private String userPhone;

    //生成的导购码存放位置
    private String imgPath;

    //导购码图片的名称
    private String imgName;

    //最后生成导购码的时间
    private Date imgTime;

    //对应小程序参数设置的信息
    private Integer wxAppinfoId;

    //对应二维码生成的相关设置
    private Integer qrcodeConfigId;

    //是否已经生成二维码，0=未生成，1=已生成
    private Integer isCreateQrcode;

    //公司id
    private Integer enterpriseId;

    //公司名称
    private String enterpriseName;

    //创建时间
    private Date createTime;

    //最后更新时间
    private Date UpdateTime;

    //前台展示使用
    @TableField(exist = false)
    private WxAppinfoEntity wxAppinfoEntity;

    //前台展示使用
    @TableField(exist = false)
    private QRCodeConfigEntity qrCodeConfigEntity;
}
