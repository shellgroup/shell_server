package com.winnerdt.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;
/*
*
* 微信小程序实体类
* */
@Data
@TableName("wx_user")
public class WxUserEntity implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@TableId
	private Integer id;

	//微信openId
	private String openId;

	private String sessionKey;

	//用户注册IP
	private String registerIp;

	//微信unionId
	private String unionId;

	//crm密码
	private String password;

	//用户昵称
	private String nickName;

	//用户头像地址
	private Integer gender;

	//用户头像地址
	private String avatarUrl;

	//用户所在城市
	private String city;

	//用户所在省份
	private String province;

	//用户所在语言
	private String language;

	//用户绑定的手机号
	private String phone;

	//用户没有区号的手机号
	private String purePhone;

	//用户手机区号
	private String countryCode;

	//是否为商户侧的拉新用户
	private Integer isNew;

	// 会员卡号
	private String vipNo;

	//注册时记录用户扫码渠道，如朋友圈广告
	private String qrcodeSource;

	//会员绑定的手机号
	private String memberPhone;

	//身份证号
	private String idCard;

	//姓名
	private String name;

	//与微众唯一key，默认第一次注册手机号
	private String webid;

	// 是否微众会员
	private boolean webank;

	// 二维码
	private String scene;

	//线下会员号
	private String hdcardMemberId;

	/*
	* 如果是扫码进入记录二维码id，如果是分享进入，记录分享人信息
	* */
	private String shareId;

	//如果扫码进入，记录所扫码所属部门
	private Integer deptId;

	//会员识别码
	private String identCode;

	// 渠道
	private String sceneAddress;

	//部门推广码
	private String deptCode;

	//用户注册时填写的手机号
	private String registPhone;

	//用户注册时填写的使用区域
	private String useRegion;

	//用户注册时填写的开票类型
	private String invoiceType;

	//用户是否已经注册
	private Integer isRegist;


	// 新增时间
	private Date createDate;

	// 更新时间
	private Date updateDate;

}
