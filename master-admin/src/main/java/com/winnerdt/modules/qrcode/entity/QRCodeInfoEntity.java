package com.winnerdt.modules.qrcode.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.winnerdt.common.validator.group.AddGroup;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.util.Date;

/**
 * @author:zsk
 * @CreateTime:2019-04-15 15:34
 */
@Data
@TableName("qrcode_info")
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

    //部门id
    @NotBlank(message = "所属渠道不能为空",groups = {AddGroup.class})
    private Integer deptId;

    //用户id
    private String userId;

    //用户名称
    private String userName;

    //用户手机号
    private String userPhone;

    //图片路径（二维码配置中的路径+二维码生成时根据需求等情况拼接路径+二维码名称）
    private String imgPath;

    //图片部分路径（二维码生成时根据需求拼接的地址）
    private String imgPathSub;

    //导购码图片的名称
    private String imgName;

    //最后生成导购码的时间
    private Date imgTime;

    //是否已经生成二维码，0=未生成，1=已生成
    private Integer isCreateQrcode;

    //公司id
    private Integer enterpriseId;

    //公司名称
    private String enterpriseName;

    //0=未删除 , 1=已经删除
    @TableLogic
    private Integer isDel;

    //创建时间
    private Date createTime;

    //最后更新时间
    private Date UpdateTime;

    //部门推广码
    private String deptCode;

    //图片base64编码，用于前端回显
    @TableField(exist = false)
    private String imgBase64;

}
