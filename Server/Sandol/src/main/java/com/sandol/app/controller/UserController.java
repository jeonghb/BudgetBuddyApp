package com.sandol.app.controller;

import java.util.List;
import java.util.Map;

//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sandol.app.service.UserService;
import com.sandol.app.vo.UserDepartmentPositionVO;
import com.sandol.app.vo.UserVO;

@Controller
public class UserController {
//	private static final Logger logger = LoggerFactory.getLogger(UserRegistController.class);
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/userRegist", method = RequestMethod.POST)
	@ResponseBody
	public boolean userRegist(@RequestBody UserVO _userVO) {
		
		boolean result = userService.getUserInfo(_userVO.getUserId());
		
		if (result) {
			userService.setUserRegist(_userVO);
			
			return true;
		}
		else {
			return false;
		}
	}
	
	@RequestMapping(value = "/userCheck", method = RequestMethod.POST)
	@ResponseBody
	public String userCheck(@RequestBody UserVO _userVO) {
		return userService.getUserCheck(_userVO);
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public UserVO userLogin(@RequestBody UserVO _userVO) {
		return userService.login(_userVO);
	}
	
	@RequestMapping(value = "/userPasswordFind", method = RequestMethod.POST)
	@ResponseBody
	public boolean userPasswordFind(@RequestBody UserVO _userVO) {
		return userService.userPasswordFind(_userVO);
	}
	
	@RequestMapping(value = "/userPasswordUpdate", method = RequestMethod.POST)
	@ResponseBody
	public boolean userPasswordUpdate(@RequestBody UserVO _userVO) {
		return userService.userPasswordUpdate(_userVO);
	}
	
	@RequestMapping(value = "/userInfoUpdate", method = RequestMethod.POST)
	@ResponseBody
	public boolean userInfoUpdate(@RequestBody UserVO _userVO) {
		return userService.userInfoUpdate(_userVO);
	}
	
	@RequestMapping(value = "/getLoginUserDepartmentPositionList", method = RequestMethod.POST)
	@ResponseBody
	public List<UserDepartmentPositionVO> getLoginUserDepartmentPositionList(@RequestBody Map<String, String> _userId) {
		return userService.getLoginUserDepartmentPositionList(_userId.get("userId"));
	}
}
