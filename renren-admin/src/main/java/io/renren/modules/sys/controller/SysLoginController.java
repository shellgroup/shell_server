/**
 * Copyright 2018 人人开源 http://www.renren.io
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License. You may obtain a copy of
 * the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 * License for the specific language governing permissions and limitations under
 * the License.
 */

package io.renren.modules.sys.controller;


import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import io.renren.common.utils.R;
import io.renren.modules.sys.shiro.ShiroUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Map;

/**
 * 登录相关
 *
 * @author chenshun
 * @email sunlightcs@gmail.com
 * @date 2016年11月10日 下午1:15:31
 */
@Controller
public class SysLoginController {
	@Autowired
	private Producer producer;

	@RequestMapping("captcha.jpg")
	public void captcha(HttpServletResponse response)throws IOException {
        response.setHeader("Cache-Control", "no-store, no-cache");
        response.setContentType("image/jpeg");
		//生成文字验证码
		String text = producer.createText();
		System.out.println(text+"   _____________");
        //生成图片验证码
        BufferedImage image = producer.createImage(text);
        //保存到shiro session
        ShiroUtils.setSessionAttribute(Constants.KAPTCHA_SESSION_KEY, text);

        ServletOutputStream out = response.getOutputStream();
        ImageIO.write(image, "jpg", out);
	}

	/**
	 * 登录
	 */
	@ResponseBody
	@RequestMapping(value = "/sys/login", method = RequestMethod.POST)
	public R login(@RequestBody Map<String, String> map) {
//	public R login(String username,String password,String captcha) {
		R r = new R();
		String username = map.get("userName");
		String password = map.get("password");
		String captcha = map.get("captcha");
		String type = map.get("type");

		String kaptcha = ShiroUtils.getKaptcha(Constants.KAPTCHA_SESSION_KEY);
		if(!captcha.equalsIgnoreCase(kaptcha)){
			r.put("code",500);
			r.put("status","error");
			r.put("msg","验证码不正确");
			r.put("type", type);
			return r;
		}

		try{
			Subject subject = ShiroUtils.getSubject();
			UsernamePasswordToken token = new UsernamePasswordToken(username, password);
			subject.login(token);
		}catch (UnknownAccountException e) {
			r.put("code",500);
			r.put("status","error");
			r.put("msg","账号或密码不存在");
			r.put("type", type);
			return r;
		}catch (IncorrectCredentialsException e) {
			r.put("code",500);
			r.put("status","error");
			r.put("msg","账号或密码不正确");
			r.put("type", type);
			return r;
		}catch (LockedAccountException e) {
			r.put("code",500);
			r.put("status","error");
			r.put("msg","账号已被锁定,请联系管理员");
			r.put("type", type);
			return r;
		}catch (AuthenticationException e) {
			r.put("code",500);
			r.put("status","error");
			r.put("msg","账户验证失败");
			r.put("type", type);
			return r;
		}


		r.put("code",0);
		r.put("msg", "success");
		r.put("status", "ok");
		/*
		* 前台使用
		* */
		r.put("currentAuthority", "admin");
		r.put("type", type);
		return r;
	}

	/**
	 * 退出
	 */
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public void logout() {
		ShiroUtils.logout();
	}

}
