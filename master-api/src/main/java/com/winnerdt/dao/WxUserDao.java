package com.winnerdt.dao;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.winnerdt.entity.WxUserEntity;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

/**
 * 
 * 
 * @author Stormeye
 * @email wugq@mippoint.com
 * @date 2018-05-22 11:24:14
 */
@Mapper
public interface WxUserDao extends BaseMapper<WxUserEntity> {

	List<WxUserEntity> queryList(Map map);

	int queryTotal(Map map);

	WxUserEntity queryObjectbyOpenid(String openid);

	WxUserEntity queryObjectByMobile(String mobile);

	WxUserEntity queryObjectbyHdcardMbrId(String hdcardMbrId);

	List<WxUserEntity> findUserList(Map<String, Object> map);
}
