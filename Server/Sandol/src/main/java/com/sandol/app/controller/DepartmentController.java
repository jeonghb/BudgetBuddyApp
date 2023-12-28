package com.sandol.app.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sandol.app.service.DepartmentService;
import com.sandol.app.vo.DepartmentMemberVO;
import com.sandol.app.vo.DepartmentRequestVO;
import com.sandol.app.vo.DepartmentVO;
import com.sandol.app.vo.UserDepartmentVO;

@Controller
public class DepartmentController {
	
	@Autowired
	DepartmentService departmentService;
	
	@RequestMapping(value = "/getDepartmentList", method = RequestMethod.GET)
	@ResponseBody
	public List<DepartmentVO> getDepartmentList() {
		return departmentService.getDepartmentList();
	}
	
	@RequestMapping(value = "/departmentAdd", method = RequestMethod.POST)
	@ResponseBody
	public Boolean departmentAdd(@RequestBody Map<String, Object> _department) {
		return departmentService.departmentAdd(_department);
	}
	
	@RequestMapping(value = "/departmentUpdate", method = RequestMethod.POST)
	@ResponseBody
	public boolean departmentUpdate(@RequestBody DepartmentVO _departmentVO) {
		return departmentService.departmentUpdate(_departmentVO);
	}
	
	@RequestMapping(value = "/departmentRequest", method = RequestMethod.POST)
	@ResponseBody
	public boolean departmentRequest(@RequestBody UserDepartmentVO _userDepartmentVO) {
		return departmentService.departmentRequest(_userDepartmentVO);
	}
	
	@RequestMapping(value = "/getRequestPositilityDepartmentList", method = RequestMethod.POST)
	@ResponseBody
	public List<DepartmentVO> getRequestPositilityDepartmentList(@RequestBody Map<String, String> _userId) {
		return departmentService.getRequestPositilityDepartmentList(_userId.get("userId"));
	}
	
	@RequestMapping(value = "/getDepartmentRequestList", method = RequestMethod.POST)
	@ResponseBody
	public List<DepartmentRequestVO> getDepartmentRequestList(@RequestBody Map<String, String> _userId) {
		return departmentService.getDepartmentRequestList(_userId.get("userId"));
	}
	
	@RequestMapping(value = "/departmentRequestFinish", method = RequestMethod.POST)
	@ResponseBody
	public boolean departmentRequestFinish(@RequestBody DepartmentRequestVO _departmentRequestVO) {
		return departmentService.departmentRequestFinish(_departmentRequestVO);
	}
	
	@RequestMapping(value = "/getDepartmentMemberList", method = RequestMethod.POST)
	@ResponseBody
	public List<DepartmentMemberVO> getDepartmentMemberList(@RequestBody Map<String, String> _userId) {
		return departmentService.getDepartmentMemberList(_userId.get("userId"));
	}
	
	@RequestMapping(value = "/departmentLeave", method = RequestMethod.POST)
	@ResponseBody
	public boolean departmentLeave(@RequestBody UserDepartmentVO _userDepartmentVO) {
		return departmentService.departmentLeave(_userDepartmentVO);
	}
}
