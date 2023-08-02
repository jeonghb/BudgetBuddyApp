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
	
	@RequestMapping(value = "/setDepartment", method = RequestMethod.POST)
	@ResponseBody
	public Boolean setDepartment(@RequestBody DepartmentVO departmentVO) {
		return departmentService.setDepartment(departmentVO);
	}
	
	@RequestMapping(value = "/departmentRequest", method = RequestMethod.POST)
	@ResponseBody
	public boolean departmentRequest(@RequestBody UserDepartmentVO userDepartmentVO) {
		return departmentService.departmentRequest(userDepartmentVO);
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
	public boolean departmentRequestFinish(@RequestBody DepartmentRequestVO departmentRequestVO) {
		return departmentService.departmentRequestFinish(departmentRequestVO);
	}
	
	@RequestMapping(value = "/getDepartmentMemberList", method = RequestMethod.POST)
	@ResponseBody
	public List<DepartmentMemberVO> getDepartmentMemberList(@RequestBody Map<String, String> _userId) {
		return departmentService.getDepartmentMemberList(_userId.get("userId"));
	}
}
