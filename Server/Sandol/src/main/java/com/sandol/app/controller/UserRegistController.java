package com.sandol.app.controller;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sandol.app.service.UserRegistService;
import com.sandol.app.vo.UserRegistVO;

@Controller
public class UserRegistController {
//	private static final Logger logger = LoggerFactory.getLogger(UserRegistController.class);
	
	@Autowired
	UserRegistService userService;
	
	@RequestMapping(value = "/userRegist", method = RequestMethod.POST)
	@ResponseBody
	public String userRegist(@RequestBody UserRegistVO vo) {
		
		String result = userService.getUserInfo(vo.getId());
		
		if (result.equals("0")) {
			userService.setUserRegist(vo);
		}
		
		return result;
	}
	
	@RequestMapping(value = "/userCheck", method = RequestMethod.POST)
	@ResponseBody
	public String userCheck(@RequestBody UserRegistVO vo) {
		return userService.getUserCheck(vo);
	}
}
