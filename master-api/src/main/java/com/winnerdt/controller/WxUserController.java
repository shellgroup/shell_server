package com.winnerdt.controller;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import cn.binarywang.wx.miniapp.bean.WxMaPhoneNumberInfo;
import cn.binarywang.wx.miniapp.bean.WxMaUserInfo;
import com.alibaba.fastjson.JSONObject;
import com.winnerdt.common.utils.R;
import com.winnerdt.entity.QRCodeInfoEntity;
import com.winnerdt.entity.WxUserEntity;
import com.winnerdt.service.QRCodeInfoService;
import com.winnerdt.service.TokenService;
import com.winnerdt.service.WxUserService;
import com.winnerdt.utils.CreateRandomCharData;
import com.winnerdt.utils.IPUtil;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.Example;
import io.swagger.annotations.ExampleProperty;
import me.chanjar.weixin.common.error.WxErrorException;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * @author:zsk
 * @CreateTime:2019-04-22 11:58
 */
@RestController
@RequestMapping("/api/user")
public class WxUserController {
    private final static Logger logger = LoggerFactory.getLogger(WxUserController.class);

    @Autowired
    private TokenService tokenService;

    @Autowired
    private WxMaService wxService;

    @Autowired
    private WxUserService wxUserService;

    @Autowired
    private QRCodeInfoService qrCodeInfoService;

//    @Autowired
//    private SSBLStoreService ssblStoreService;
//
//    @Autowired
//    private CRMProperties cp;
//
//    @Autowired
//    private WxQrcodeDao wxQrcodeDao;


    /**
     * 用户登录
     * @param map
     * @return
     */
    @PostMapping("/login")
    @ApiOperation(value="用户登录", notes="{\"code\":\"string\",\"scene\":\"string\",\"sceneAddress\":\"string\"}")
    public R userLogin(@RequestBody Map<String, Object> map) {
        logger.debug(JSONObject.toJSONString(map));
        if(null == map.get("code")){
            return R.error("code为空");
        }
//        if(null == map.get("scene")){
//            return R.error("scene");
//        }
        if(null == map.get("sceneAddress")){
            return R.error("sceneAddress为空");
        }
        String code = map.get("code").toString();
        String scene = null;
        if(null != map.get("scene")){
            scene = map.get("scene").toString();
        }
        String sceneAddress = map.get("sceneAddress").toString();
        //登录凭证不能为空
        if (StringUtils.isBlank(code)) {
            return R.error(1, "code 不能为空");
        }

        R r = new R();

        String session_key = null;
        String openId = null;
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String ipaddress = IPUtil.getIp(request);

        try {
            WxMaJscode2SessionResult session = this.wxService.getUserService().getSessionInfo(code);
            //获取会话密钥（session_key）
            session_key = session.getSessionKey();
            openId = session.getOpenid();
            logger.info("session_key: " + session_key);
            logger.info("openId: " + openId);
        } catch (WxErrorException e) {
            logger.error(e.getMessage(), e);
            return R.error(e.toString());
        }

        try {
            WxUserEntity user1 = wxUserService.queryObjectByOpenId(openId);
            if (user1 != null) {
                user1.setSessionKey(session_key);
                wxUserService.update(user1);
            } else {
                WxUserEntity user = new WxUserEntity();
                user.setRegisterIp(ipaddress);
                if (user.getScene() == null && null != scene){
                    user.setScene(scene);
                }
                if (user.getSceneAddress() == null){
                    user.setSceneAddress(sceneAddress);
                }
                if (scene != null) {
                    user.setQrcodeSource(scene);
                } else {
                    user.setQrcodeSource(sceneAddress);
                }
                //这里处理二维码带的参数
                try{
                    //扫码进入时处理逻辑
                    if(sceneAddress.equals("1011") || sceneAddress.equals("1012") || sceneAddress.equals("1013") || sceneAddress.equals("1047") ||
                        sceneAddress.equals("1048") || sceneAddress.equals("1049")){
                        Map sceneMap = (LinkedHashMap) map.get("scene");
                        user.setShareId(sceneMap.get("shareId").toString());
                        user.setDeptId(Integer.parseInt(sceneMap.get("deptId").toString()));

                        QRCodeInfoEntity qrCodeInfoEntity = qrCodeInfoService.queryQRCodeById(Integer.parseInt(sceneMap.get("shareId").toString()));
                        if(null != qrCodeInfoEntity){
                            user.setDeptCode(qrCodeInfoEntity.getDeptCode());
                        }
                    }

                }catch (Exception e){
                    e.printStackTrace();
                    Date date = new Date();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String now = sdf.format(date);
                    logger.error("二维码携带参数解析异常，源数据为："+ JSONObject.toJSONString(scene)+"：：：：时间："+now);
                    return R.error(e.toString());
                }

                user.setOpenId(openId);
                user.setSessionKey(session_key);
                wxUserService.save(user);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return R.error(e.toString());
        }

        // create token
//        R r1 = tokenService.createToken(openId);
        R r1 = new R();
        r1.put("session_key", session_key);
        r1.put("openId", openId);
        return r1;
    }

    /**
     * 获取用户的昵称等信息
     * @param map
     * @return
     */
    @PostMapping("/getUserInfo")
    @ApiOperation(value="授权后获取用户的昵称,unionId等信息", notes="{\"encryptedData\":\"string\",\"iv\":\"string\",\"openId\":\"string\"}")
    public R getUserInfo(@RequestBody Map<String, String> map) {
        logger.debug(map.toString());
        String openId = map.get("openId");
        String encryptedData = map.get("encryptedData");
        String iv = map.get("iv");


        if (StringUtils.isBlank(encryptedData)) {
            return R.error(1, "encryptedData 不能为空");
        }
        if (StringUtils.isBlank(iv)) {
            return R.error(2, "iv 不能为空");
        }
        if (StringUtils.isBlank(openId)) {
            return R.error(3, "openId 不能为空");
        }

        R r = new R();

        WxUserEntity user = null;

        user = wxUserService.queryObjectByOpenId(openId);
        if (user != null) {
            logger.debug(user.toString());
            String session_key = user.getSessionKey();
            try {
                // 解密用户信息
                WxMaUserInfo userInfo = this.wxService.getUserService().getUserInfo(session_key, encryptedData, iv);
                if (userInfo != null) {
                    logger.debug(userInfo.toString());
                    user.setUnionId(userInfo.getUnionId());
                    user.setNickName(userInfo.getNickName());
                    user.setGender(Integer.parseInt(userInfo.getGender()));
                    user.setAvatarUrl(userInfo.getAvatarUrl());
                    user.setProvince(userInfo.getProvince());
                    user.setCity(userInfo.getCity());
                    user.setLanguage(userInfo.getLanguage());
                    wxUserService.update(user);
                    r.put("openId", user.getOpenId());
                    r.put("unionId", user.getUnionId());
                    r.put("msg", "获取用户信息成功！");
                    return r;
                } else {
                    return R.error(22, "解密失败");
                }
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
                return R.error(e.toString());
            }
        } else {
            return R.error(20, "用户信息未找到");
        }
    }

    /**
     * 授权后获取用户的手机号等信息
     * @param map
     * @return
     */
    @PostMapping("/getUserPhone")
    @ApiOperation(value = "授权后获取用户的手机号", notes="{\"encryptedData\":\"string\",\"iv\":\"\",\"openId\":\"\"}")
    public R getUserPhone(@RequestBody Map<String, String> map) {
        logger.debug(map.toString());
        R r = new R();
        String encryptedData = map.get("encryptedData");
        String iv = map.get("iv");
        String openId = map.get("openId");

        //登录凭证不能为空
        if (StringUtils.isBlank(encryptedData)) {
            return R.error(1, "encryptedData 不能为空");
        }
        if (StringUtils.isBlank(iv)) {
            return R.error(2, "iv 不能为空");
        }
        if (StringUtils.isBlank(openId)) {
            return R.error(3, "openId 不能为空");
        }

        WxUserEntity user = null;

        try {
            user = wxUserService.queryObjectByOpenId(openId);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return R.error(e.toString());
        }

        if (user != null) {
            logger.debug(user.toString());
            String session_key = user.getSessionKey();
            try {
                // 解密
                WxMaPhoneNumberInfo phoneNoInfo = this.wxService.getUserService().getPhoneNoInfo(session_key, encryptedData, iv);
                if (null != phoneNoInfo) {
                    logger.debug(phoneNoInfo.toString());
                    user.setPhone(phoneNoInfo.getPhoneNumber());
                    user.setPurePhone(phoneNoInfo.getPurePhoneNumber());
                    user.setCountryCode(phoneNoInfo.getCountryCode());
                    wxUserService.update(user);
                    r.put("msg","授权手机成功！");
                    r.put("phone",phoneNoInfo.getPhoneNumber());

                    return r;

                } else {
                    return R.error(22, "解密失败");
                }
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
                return R.error(e.toString());
            }
        } else {
            return R.error(20, "用户信息未找到");
        }
    }


    /*
     * 用户注册
     * */
    @ApiOperation(value = "用户注册",notes="openId:String,name:String,idCard:String,registPhone:String,useRegion:String,invoiceType:String")
    @PostMapping("/regist")
    @ApiImplicitParam(name = "map" , paramType = "body",
            examples = @Example({
                @ExampleProperty(value = "openId", mediaType = "application/json"),
                @ExampleProperty(value = "{'name':'String'}", mediaType = "application/json")
            })
    )
    public R regist(@RequestBody Map<String,String> map){
        logger.info("用户注册接受数据："+JSONObject.toJSONString(map));
        if(null == map.get("openId")){
            return R.error("openId接受为空");
        }
        if(null == map.get("name")){
            return R.error("name为空");
        }
        if(null == map.get("idCard")){
            return R.error("idCard为空");
        }
        if(null == map.get("registPhone")){
            return R.error("registPhone为空");
        }
        if(null == map.get("useRegion")){
            return R.error("useRegion为空");
        }
        if(null == map.get("invoiceType")){
            return R.error("invoiceType为空");
        }

        try {
            wxUserService.updateByOpenId(map);
            return R.ok();
        } catch (Exception e) {
            e.printStackTrace();
            return R.error();
        }


    }

    /**
     * 判断是否是老用户
     * @param map
     * @return
     */
    @PostMapping("/isOldUser")
    @ApiOperation(value = "判断是否是老用户", notes="{\"openId\":\"\"}")
    public R isOldUser(@RequestBody Map<String, String> map) {
        logger.debug(map.toString());
        String openId = map.get("openId");

        //登录凭证不能为空
        if (StringUtils.isBlank(openId)) {
            return R.error(1, "openId 不能为空");
        }

        R r = new R();

        try {
            WxUserEntity user1 = wxUserService.queryObjectByOpenId(openId);
            if (user1 != null) {
                logger.info(user1.toString());
                // nickname, unionId is null, 31
                // phone is null, 29,
                // idcard,name is null, 30
                // all have, 32
                if(!StringUtils.isBlank(user1.getOpenId())){
                    r.put("openId",user1.getOpenId());
                }
                if (!StringUtils.isBlank(user1.getUnionId())) {
                    r.put("unionId", user1.getUnionId());
                }
                if (!StringUtils.isBlank(user1.getPhone())) {
                    r.put("phone", user1.getPhone());
                }
//                //将姗姗会员id返回到前端
//                if (!StringUtils.isBlank(user1.getVipNo())){
//                    r.put("memberCode",user1.getVipNo());
//                }
//                //将identCode作为memberid
//                if (!StringUtils.isBlank(user1.getVipNo())) {
//                    r.put("memberId", user1.getIdentCode());
//                }
                if (StringUtils.isBlank(user1.getUnionId())) {
                    r.put("type", 31).put("code", 31);
                    r.put("msg", "是新用户，请跳转到用户授权页！");
                    logger.warn("是新用户，跳转到用户授权页！");
                    return r;
                }
                if (StringUtils.isBlank(user1.getPhone())) {
                    r.put("type", 29).put("code", 29);
                    r.put("msg", "是新用户，跳转到授权手机号页！");
                    logger.warn("是新用户，跳转到授权手机号页！");
                    return r;
                }
                if( null == user1.getIsRegist() || user1.getIsRegist() == 0 || user1.getIsRegist().equals("0")){
                    r.put("type", 28).put("code", 28);
                    r.put("msg", "是新用户，跳转到注册页面！");
                    logger.warn("是新用户，跳转到注册页面！");
                    return r;
                }

                r.put("type",32).put("code", 32);
                r.put("msg", "老用户，进入首页");
                return r;

            } else {
                r.put("type", 31).put("code", 31);
                r.put("msg", "是新用户，请跳转到用户授权页！");
                logger.warn("是新用户，跳转到用户授权页！");
                return r;
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return R.error(e.toString());
        }

    }


    /**
     * 在跳转微众银行小程序时，获取用户信息phone,unionId,openId
     * @param map
     * @return
     */
    @PostMapping("/getUserMessage")
    @ApiOperation(value="在跳转微众银行小程序时，获取用户信息phone,unionId,openId", notes="{\"code\":\"string\"}")
    public R getUserMessage(@RequestBody Map<String, String> map) {
        logger.debug(map.toString());
        String code = map.get("code");
        //登录凭证不能为空
        if (StringUtils.isBlank(code)) {
            return R.error(1, "code 不能为空");
        }
        R r = new R();
        String session_key = null;
        String openId = null;

        try {
            WxMaJscode2SessionResult session = this.wxService.getUserService().getSessionInfo(code);
            //获取会话密钥（session_key）
            session_key = session.getSessionKey();
            openId = session.getOpenid();
            logger.info("session_key: " + session_key);
            logger.info("openId: " + openId);
        } catch (WxErrorException e) {
            logger.error(e.getMessage(), e);
            return R.error(e.toString());
        }

        try {
            WxUserEntity user1 = wxUserService.queryObjectByOpenId(openId);
            if (user1 != null) {
                r.put("openId", user1.getOpenId());
                r.put("unionId", user1.getUnionId());
                r.put("phone", user1.getPhone());
                r.put("memberId", user1.getWebid());
                return r;
            } else {
                return R.error("用户不存在");
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            return R.error(e.toString());
        }
    }

    //生成线下会员号并校验是否重复
    public String  createHdcardMemberId(){

        String hdcardMemberId = CreateRandomCharData.createData(16);
        //通过比对数据库，判断会员号是否会重复
        WxUserEntity wxUserEntity = wxUserService.queryObjectbyHdcardMbrId(hdcardMemberId);
        if(wxUserEntity != null){
            logger.info("**********线下会员号有重复了"+hdcardMemberId);
            return createHdcardMemberId();
        }else {
            return hdcardMemberId;
        }
    }

}
