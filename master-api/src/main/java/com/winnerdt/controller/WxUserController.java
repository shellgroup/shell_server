package com.winnerdt.controller;

import cn.binarywang.wx.miniapp.api.WxMaService;
import cn.binarywang.wx.miniapp.bean.WxMaJscode2SessionResult;
import cn.binarywang.wx.miniapp.bean.WxMaPhoneNumberInfo;
import cn.binarywang.wx.miniapp.bean.WxMaUserInfo;
import com.alibaba.fastjson.JSONObject;
import com.winnerdt.common.utils.R;
import com.winnerdt.entity.WxUserEntity;
import com.winnerdt.service.TokenService;
import com.winnerdt.service.WxUserService;
import com.winnerdt.utils.CreateRandomCharData;
import com.winnerdt.utils.IPUtil;
import io.swagger.annotations.ApiOperation;
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
    public R userLogin(@RequestBody Map<String, String> map) {
        logger.debug(map.toString());
        String code = map.get("code");
        String scene = map.get("scene");
        String sceneAddress = map.get("sceneAddress");
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
                if (user.getScene() == null){
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
                    if(null != scene && sceneAddress.equals(1011)){
                        Map sceneMap = (Map)JSONObject.parse(scene);
                        user.setShareId(sceneMap.get("qrCodeId").toString());
                        user.setDeptId(Integer.parseInt(sceneMap.get("deptId").toString()));
                        user.setDeptCode(sceneMap.get("deptCode").toString());
                    }

                }catch (Exception e){
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

                    //如果是扫码进来的有scene值，反之没有
//                    String scene = map.get("scene");
//                    if(StringUtils.isBlank(scene)){
//                        //这里处理二维码相关参数
//                        r.put("storeId","false");
//                    }else {
//                        logger.debug("***************获取的scene值：：："+scene);
//                        //通过scene查询门店号
//                        WxQrcodeEntity wxQrcodeEntity = wxQrcodeDao.queryObjectbyCode(scene);
//                        if(wxQrcodeEntity == null){
//                            r.put("storeId","false");
//                        }else {
//                            r.put("storeId",wxQrcodeEntity.getMallCode());
//                            r.put("storeName",wxQrcodeEntity.getMallName());
//                        }
//
//                    }

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


//    /*
//     * 用户注册
//     * */
//    @ApiOperation(value = "用户注册")
//    @PostMapping("/regist")@ApiImplicitParams({
//            @ApiImplicitParam(name = "mobile",dataType="String", paramType = "query",value = "手机号",required = true),
//            @ApiImplicitParam(name = "storeId",dataType="String", paramType = "query",value = "门店编码",required = true)
//    })
//    public R regist(String mobile ,String storeId){
//        logger.info("*************接受到的手机号为："+mobile+"**************接受到的门店id"+storeId);
//        R r = new R();
//        WxUserEntity userEntity = wxUserService.queryObjectByMobile(mobile);
//        if(userEntity == null){
//            return R.error("用户信息丢失！注册失败");
//        }else {
//            try {
//                //处理部分门店号获取为undefined的情况（只能处理有scenc的情况）
//                if("undefined".equals(storeId)){
//                    if(!( StringUtils.isBlank( userEntity.getScene() ) )){
//                        logger.debug("**********需要处理门店号undefined情况的会员号："+userEntity.getVipno()+"**********用于截取门店号的scene值："+userEntity.getScene());
//                        storeId = userEntity.getScene().substring(0,userEntity.getScene().indexOf("_"));
//                    }
//                }
//            }catch (Exception e){
//                logger.debug("**********需要处理门店号undefined情况的会员号："+userEntity.getVipno()+"**********scene值格式出现异常："+userEntity.getScene());
//            }
//
//
//            try {
//                String hdcardMemberId;
//                //通过手机号查询该用户是否已经注册姗姗会员，如果已经注册获取需要的注册信息，如果未查到信息，用户开始注册。
//                String vipNo;
//                try{
//                    /*
//                     * 查询该用户是否已经注册过了
//                     * 实现逻辑：通过手机号查询该用户信息，如果返回结果有相应的值，取相应的值。
//                     * 如果返回结果为空，取值的时候会出现异常，
//                     * 将用户注册的逻辑写在catch块中，实现用户的注册。
//                     *
//                     * */
//                    String identType = "mobile";
//                    String identCode1 = mobile; // 当identType是mobile时，identCode的值和手机号相同，未防止错误，直接将手机号赋值给identCode
//                    String url1="/crm/identservice/identify"+"?ident_type="+identType+"&ident_code="+identCode1;
//                    String result2 = HTTPMethodUtil.httpGet(cp.getBaseurl()+cp.getTenantid()+url1,cp.getUserName(),cp.getUserPass());
//                    JSONObject jsonObject1 = JSONObject.parseObject(result2);
//                    vipNo = jsonObject1.getString("member_id");
//                    JSONArray jsonArray = jsonObject1.getJSONArray("idents");
//                    List<DLYIdent> dlyIdents = JSONObject.parseArray(jsonArray.toJSONString(), DLYIdent.class).stream().filter(m -> "hdcard_mbr_id".equals(m.getType())).collect(Collectors.toList());
//                    hdcardMemberId = dlyIdents.get(0).getCode();
//
//                }catch (Exception e){
//                    //如果该用户没有注册过，则开始注册会员
//
//                    String url="/crm/identservice/register";
//                    //通过随机数生成线下会员号
//                    hdcardMemberId = createHdcardMemberId();
//
//                    Map<String, Object> paramMap=new HashMap<>();
//                    paramMap.put("hdcard_member_id",hdcardMemberId);
//                    paramMap.put("mobile",mobile);
//                    paramMap.put("store_id",storeId);
//                    String result = HTTPMethodUtil.httpPost(cp.getBaseurl()+cp.getTenantid()+url,paramMap,cp.getUserName(),cp.getUserPass());
//                    logger.debug("**********姗姗会员注册返回信息："+result);
//                    JSONObject jsonObject = JSONObject.parseObject(result);
//                    vipNo = jsonObject.get("id").toString();
//                }
//
//                //将注册后的会员id，线下会员号以及注册门店编码保存到数据库中
//                WxUserEntity user = new WxUserEntity();
//                user.setId(userEntity.getId());
//                user.setHdcardMemberId(hdcardMemberId);
//                user.setVipno(vipNo);
//                user.setStoreId(storeId);
//                user.setWebid(mobile);
//                wxUserService.update(user);
//
//                //通过会员id获取会员身份码
//                String identType = "mobile";
//                String identCode1 = mobile; // 当identType是mobile时，identCode的值和手机号相同，未防止错误，直接将手机号赋值给identCode
//                String url1="/crm/identservice/identify"+"?ident_type="+identType+"&ident_code="+identCode1;
//                String result1 = HTTPMethodUtil.httpGet(cp.getBaseurl()+cp.getTenantid()+url1,cp.getUserName(),cp.getUserPass());
//                logger.debug("**********通过会员id获取会员身份码(会员识别）："+result1);
//                JSONObject jsonObject1 = JSONObject.parseObject(result1);
//                String identCode = jsonObject1.get("ident_code").toString();
//                String memberId = jsonObject1.getString("member_id");
//                WxUserEntity wxUserEntity = new WxUserEntity();
//                wxUserEntity.setId(userEntity.getId());
//                wxUserEntity.setIdentCode(identCode);
//                wxUserService.update(wxUserEntity);
//
//                /*
//                 * 前台中，memberId代表了会员号，memberCode代表了会员id
//                 * 同时这里将identCode会员身份识别码作为了会员号
//                 * */
//                r.put("memberId",identCode);
//                r.put("memberCode",memberId);
//                r.put("msg","会员注册成功");
//
//
//                return r;
//            }catch (Exception e){
//                this.logger.error(e.getMessage(), e);
//                return R.error(e.toString());
//            }
//        }

//    }

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
//                if (StringUtils.isBlank(user1.getVipNo())) {
//                    r.put("type",28).put("code", 28);
//                    r.put("msg", "是新用户，跳转到注册珊珊便利会员！");
//                    logger.warn("是新用户，跳转到注册珊珊便利会员！");
//                    return r;
//                }
//                if (!(user1.isWebank())) {
//                    r.put("type", 27).put("code", 27);
//                    r.put("msg", "未注册微众轻会员！");
//                    logger.warn("未注册微众轻会员，请注册微众轻会员！");
//                    return r;
//                }

                //获取用户注册门店信息，用于首页显示
//                if("undefined".equals(user1.getStoreId()) || StringUtils.isBlank(user1.getStoreId())){
//                    r.put("storeName","未授权地理位置");
//                }else {
//                    SSBLStore crmStore1 = new SSBLStore();
//                    crmStore1.setStoreCode(user1.getStoreId());
//                    SSBLStore crmStore =ssblStoreService.queryObject(crmStore1);
//                    r.put("storeName",crmStore.getStoreName());
//                    r.put("storeId",crmStore.getStoreCode());
//                }

                r.put("type",32).put("code", 32);
                r.put("msg", "老用户");
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
