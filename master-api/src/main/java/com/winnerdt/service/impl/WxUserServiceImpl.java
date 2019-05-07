package com.winnerdt.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.winnerdt.dao.WxUserDao;
import com.winnerdt.entity.WxUserEntity;
import com.winnerdt.service.WxUserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;


@Service
public class WxUserServiceImpl extends ServiceImpl<WxUserDao,WxUserEntity> implements WxUserService {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());


	@Autowired
	private WxUserDao wxUserDao;
	
	@Override
	public WxUserEntity queryObject(Integer id){
		return wxUserDao.selectById(id);
	}

	@Override
	public WxUserEntity queryObjectByOpenId(String openid){
		return wxUserDao.queryObjectbyOpenid(openid);
	}

	@Override
	public WxUserEntity queryObjectByMobile(String mobile) {
		return wxUserDao.queryObjectByMobile(mobile);
	}

	@Override
	public List<WxUserEntity> queryList(Map<String, Object> map){
		return wxUserDao.queryList(map);
	}
	
	@Override
	public int queryTotal(Map<String, Object> map){
		return wxUserDao.queryTotal(map);
	}
	
	@Override
	public boolean save(WxUserEntity wxUser){
		wxUser.setCreateDate(new Date());
		wxUser.setUpdateDate(new Date());
		wxUserDao.insert(wxUser);
		return true;
	}
	
	@Override
	public void update(WxUserEntity wxUser){
		wxUser.setUpdateDate(new Date());
		wxUserDao.updateById(wxUser);
	}

	@Override
	public void updateMem(WxUserEntity wxUser, WxUserEntity oldUser){
		/*
		try {
			if (oldUser.getWebid() != null && oldUser.getWebid().length() > 0) {
				GinWaUtil.UpdateMemberInfo(properties.getUrl(), oldUser.getWebid(), wxUser.getName(), wxUser.getPhone());
				wxUser.setWebid(oldUser.getWebid());
			}
			wxUserDao.update(wxUser);
		} catch (Exception e) {
			logger.debug(oldUser.toString());
			logger.debug(wxUser.toString());
			logger.error(e.getMessage());
		}
		*/
	}
	
	@Override
	public void delete(Integer id){
		wxUserDao.deleteById(id);
	}
	
	@Override
	public void deleteBatch(Integer[] ids){
		wxUserDao.deleteBatchIds(Arrays.asList(ids));
	}

	@Override
	public WxUserEntity queryObjectbyHdcardMbrId(String hdcardMbrId) {
		return wxUserDao.queryObjectbyHdcardMbrId(hdcardMbrId);
	}

	@Override
	public List<WxUserEntity> findUserList(Map<String, Object> map) {
		return wxUserDao.findUserList(map);
	}

	@Override
	public void updateByOpenId(Map<String,String> map) {

		WxUserEntity wxUserEntity = new WxUserEntity();
		wxUserEntity.setOpenId(map.get("openId"));
		wxUserEntity.setName(map.get("name"));
		wxUserEntity.setIdCard(map.get("idCard"));
		wxUserEntity.setRegistPhone(map.get("registPhone"));
		wxUserEntity.setUseRegion(map.get("useRegion"));
		wxUserEntity.setInvoiceType(map.get("invoiceType"));
		wxUserEntity.setUpdateDate(new Date());
		wxUserDao.update(wxUserEntity,new UpdateWrapper<WxUserEntity>()
				.set("name",wxUserEntity.getName())
				.set("id_card",wxUserEntity.getIdCard())
				.set("regist_phone",wxUserEntity.getRegistPhone())
				.set("use_region",wxUserEntity.getUseRegion())
				.set("invoice_type",wxUserEntity.getInvoiceType())
				.set("is_regist",1)
				.set("update_date",new Date())
				.eq("open_id",wxUserEntity.getOpenId()));
	}

	@Override
	public boolean isExitRegistPhone(String registPhone) {
		List<WxUserEntity> wxUserEntityList = wxUserDao.selectList(new QueryWrapper<WxUserEntity>()
				.eq("regist_phone",registPhone));
		if(wxUserEntityList.size() > 0){
			return true;
		}
		return false;
	}

	@Override
	public boolean isExitRegistIdCard(String idCard) {
		List<WxUserEntity> wxUserEntityList = wxUserDao.selectList(new QueryWrapper<WxUserEntity>()
				.eq("id_card",idCard));
		if(wxUserEntityList.size() > 0){
			return true;
		}
		return false;
	}

}
