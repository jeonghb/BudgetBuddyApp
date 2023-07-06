package com.sandol.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sandol.app.service.DepartmentService;
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
	public Boolean setDepartment(@RequestBody DepartmentVO vo) {
		return departmentService.setDepartment(vo);
	}
	
	@RequestMapping(value = "/departmentRequest", method = RequestMethod.POST)
	@ResponseBody
	public boolean departmentRequest(@RequestBody UserDepartmentVO vo) {
		return departmentService.departmentRequest(vo);
	}
}
