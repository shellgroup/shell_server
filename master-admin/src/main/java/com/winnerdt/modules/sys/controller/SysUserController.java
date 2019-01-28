package com.winnerdt.modules.sys.controller;


import com.alibaba.fastjson.JSONObject;
import com.winnerdt.common.annotation.SysLog;
import com.winnerdt.common.utils.PageUtils;
import com.winnerdt.common.utils.R;
import com.winnerdt.common.validator.Assert;
import com.winnerdt.common.validator.ValidatorUtils;
import com.winnerdt.common.validator.group.AddGroup;
import com.winnerdt.common.validator.group.UpdateGroup;
import com.winnerdt.modules.sys.entity.SysDeptEntity;
import com.winnerdt.modules.sys.entity.SysUserEntity;
import com.winnerdt.modules.sys.service.SysDeptService;
import com.winnerdt.modules.sys.service.SysUserRoleService;
import com.winnerdt.modules.sys.service.SysUserService;
import com.winnerdt.modules.sys.shiro.ShiroUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 系统用户
 *
 * @author chenshun
 * @email sunlightcs@gmail.com
 * @date 2016年10月31日 上午10:40:10
 */
@RestController
@RequestMapping("/sys/user")
public class SysUserController extends AbstractController {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private SysUserService sysUserService;
	@Autowired
	private SysUserRoleService sysUserRoleService;
	@Autowired
	private SysDeptService sysDeptService;

	/**
	 * 所有用户列表
	 */
	@RequestMapping("/list")
	@RequiresPermissions("sys:user:list")
	public R list(@RequestParam Map<String, Object> params){
		PageUtils page = sysUserService.queryPage(params);

		return R.ok().put("list", page.getList()).put("pagination",page.getPagination());
	}

	/**
	 * 获取登录的用户信息
	 */
	@RequestMapping("/info")
	public R info(){
		SysUserEntity sysUserEntity = getUser();
		SysDeptEntity sysDeptEntity = sysDeptService.getById(sysUserEntity.getDeptId());
		sysUserEntity.setDeptName(sysDeptEntity.getName());
		return R.ok().put("user", sysUserEntity);
	}

	/**
	 * 修改登录用户密码
	 */
	@SysLog("修改密码")
	@RequestMapping("/password")
	public R password(String password, String newPassword){
		Assert.isBlank(newPassword, "新密码不为能空");

		//原密码
		password = ShiroUtils.sha256(password, getUser().getSalt());
		//新密码
		newPassword = ShiroUtils.sha256(newPassword, getUser().getSalt());

		//更新密码
		boolean flag = sysUserService.updatePassword(getUserId(), password, newPassword);
		if(!flag){
			return R.error("原密码不正确");
		}

		return R.ok();
	}

	/**
	 * 用户信息
	 */
	@RequestMapping("/info/{userId}")
	@RequiresPermissions("sys:user:info")
	public R info(@PathVariable("userId") Long userId){
		SysUserEntity user = sysUserService.getById(userId);

		//获取用户所属的角色列表
		List<Long> roleIdList = sysUserRoleService.queryRoleIdList(userId);
		user.setRoleIdList(roleIdList);

		//获取用户部门名称
		SysDeptEntity sysDeptEntity = sysDeptService.getById(user.getDeptId());
		user.setDeptName(sysDeptEntity.getName());

		return R.ok().put("user", user);
	}

	/**
	 * 保存用户
	 */
	@SysLog("保存用户")
	@RequestMapping("/save")
	@RequiresPermissions("sys:user:save")
	public R save(@RequestBody SysUserEntity user){
		ValidatorUtils.validateEntity(user, AddGroup.class);

		try{
			sysUserService.save(user);
			return R.ok();
		}catch (Exception e){
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String now = sdf.format(date);
			logger.error("新增用户异常，异常时间："+now+":::异常数据："+user.toString()+":::异常原因："+e.toString());
			return R.error("网络错误，添加失败！");
		}
	}

	/**
	 * 修改用户
	 */
	@SysLog("修改用户")
	@RequestMapping("/update")
	@RequiresPermissions("sys:user:update")
	public R update(@RequestBody SysUserEntity user){
		ValidatorUtils.validateEntity(user, UpdateGroup.class);


		try{
			sysUserService.update(user);
			return R.ok();
		}catch (Exception e){
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String now = sdf.format(date);
			logger.error("更新用户异常，异常时间："+now+":::异常数据："+user.toString()+":::异常原因："+e.toString());
			return R.error("网络错误，更新失败！");
		}

	}

	/**
	 * 删除用户
	 */
	@SysLog("删除用户")
	@RequestMapping("/delete")
	@RequiresPermissions("sys:user:delete")
	public R delete(@RequestBody Long[] userIds){
		if(ArrayUtils.contains(userIds, 1L)){
			return R.error("系统管理员不能删除");
		}

		if(ArrayUtils.contains(userIds, getUserId())){
			return R.error("当前用户不能删除");
		}
        try{
            sysUserService.removeByIds(Arrays.asList(userIds));
			return R.ok();
        }catch (Exception e){
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String now = sdf.format(date);
            logger.error("用户删除异常，异常时间："+now+":::异常数据："+ JSONObject.toJSONString(userIds)+":::异常原因："+e.toString());
			return R.error("网络错误，删除失败！");
        }
	}

	/*
	* 通过用户名查询用户是否已经存在
	*
	* */
	@RequestMapping("isExistByUserName")
    public boolean isExistByUserName(@RequestBody Map<String,String> map){
	    if(sysUserService.isExistByUserName(map.get("userName"))){
			System.out.println("*********************************存在一个或者多个**************************************");
		}else {
			System.out.println("***********************************不存在**********************************************");
		}
        return sysUserService.isExistByUserName(map.get("userName"));
    }
}
