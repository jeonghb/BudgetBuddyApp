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
	
	@RequestMapping(value = "/getPositionAuthList", method = RequestMethod.POST)
	@ResponseBody
	public List<AuthVO> getPositionAuthList(@RequestBody Map<String, Object> _map) {
		return authService.getPositionAuthList(_map);
	}
	
	@RequestMapping(value = "/getUserAuthList", method = RequestMethod.POST)
	@ResponseBody
	public List<PositionAuthVO> getUserAuthList(@RequestBody Map<String, Object> _map) {
		return authService.getUserAuthList(_map);
	}
	
	@RequestMapping(value = "/getGroupMasterAuthList", method = RequestMethod.POST)
	@ResponseBody
	public List<AuthVO> getGroupMasterAuthList(@RequestBody Map<String, Object> _map) {
		return authService.getGroupMasterAuthList(_map);
	}
}
