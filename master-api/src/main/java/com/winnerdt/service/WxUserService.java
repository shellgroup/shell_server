package com.winnerdt.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.winnerdt.entity.WxUserEntity;

import java.util.List;
import java.util.Map;

/**
 * 
 * 
 * @author Stormeye
 * @email wugq@mippoint.com
 * @date 2018-05-22 11:24:14
 */
public interface WxUserService extends IService<WxUserEntity> {
	
	WxUserEntity queryObject(Integer id);

	WxUserEntity queryObjectByOpenId(String openId);

	WxUserEntity queryObjectByMobile(String mobile);
	
	List<WxUserEntity> queryList(Map<String, Object> map);
	
	int queryTotal(Map<String, Object> map);
	
	boolean save(WxUserEntity wxUser);
	
	void update(WxUserEntity wxUser);

	void updateMem(WxUserEntity wxUser, WxUserEntity oldUser);
	
	void delete(Integer id);
	
	void deleteBatch(Integer[] ids);

	WxUserEntity queryObjectbyHdcardMbrId(String hdcardMbrId);

	List<WxUserEntity> findUserList(Map<String, Object> map);
}
