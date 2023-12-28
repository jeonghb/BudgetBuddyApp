package com.sandol.app.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sandol.app.service.PositionService;
import com.sandol.app.vo.PositionRequestVO;
import com.sandol.app.vo.PositionVO;
import com.sandol.app.vo.UserPositionVO;

@Controller
public class PositionController {
	
	@Autowired
	PositionService positionService;
	
	@RequestMapping(value = "/getRequestPossibilityDepartmentPositionList", method = RequestMethod.POST)
	@ResponseBody
	public List<PositionVO> getRequestPossibilityDepartmentPositionList(@RequestBody Map<String, String> userId) {
		return positionService.getRequestPossibilityDepartmentPositionList(userId.get("userId"));
	}
	
	@RequestMapping(value = "/positionRequest", method = RequestMethod.POST)
	@ResponseBody
	public boolean positionRequest(@RequestBody PositionRequestVO _positionRequestVO) {
		return positionService.positionRequest(_positionRequestVO);
	}
	
	@RequestMapping(value = "/getPositionRequestList", method = RequestMethod.POST)
	@ResponseBody
	public List<PositionRequestVO> getPositionRequestList(@RequestBody Map<String, String> _userId) {
		return positionService.getPositionRequestList(_userId.get("userId"));
	}
	
	@RequestMapping(value = "/positionRequestFinish", method = RequestMethod.POST)
	@ResponseBody
	public boolean positionRequestFinish(@RequestBody PositionRequestVO _positionRequestVO) {
		return positionService.positionRequestFinish(_positionRequestVO);
	}
	
	@RequestMapping(value = "/positionLeave", method = RequestMethod.POST)
	@ResponseBody
	public boolean positionLeave(@RequestBody UserPositionVO _userPositionVO) {
		return positionService.positionLeave(_userPositionVO);
	}
	
	@RequestMapping(value = "/positionAdd", method = RequestMethod.POST)
	@ResponseBody
	public boolean positionAdd(@RequestBody PositionVO _positionVO) {
		return positionService.positionAdd(_positionVO);
	}
	
	@RequestMapping(value = "/getPositionList", method = RequestMethod.GET)
	@ResponseBody
	public List<PositionVO> getPositionList() {
		return positionService.getPositionList();
	}
	
	@RequestMapping(value = "/positionUpdate", method = RequestMethod.POST)
	@ResponseBody
	public boolean positionUpdate(@RequestBody PositionVO _positionVO) {
		return positionService.positionUpdate(_positionVO);
	}
}
