package com.sandol.app.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sandol.app.service.AuthService;
import com.sandol.app.vo.AuthVO;
import com.sandol.app.vo.PositionAuthVO;

@Controller
public class AuthController {
	
	@Autowired
	AuthService authService;
	
	@RequestMapping(value = "/getAuthList", method = RequestMethod.GET)
	@ResponseBody
	public List<AuthVO> getAuthList() {
		return authService.getAuthList();
	}
	
	@RequestMapping(value = "/getUserAuthList", method = RequestMethod.POST)
	@ResponseBody
	public List<PositionAuthVO> getUserAuthList(@RequestBody Map<String, String> _userId) {
		return authService.getUserAuthList(_userId.get("userId"));
	}
}
