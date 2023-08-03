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
import com.sandol.app.vo.PositionVO;

@Controller
public class PositionController {
	
	@Autowired
	PositionService positionService;
	
	@RequestMapping(value = "/getDepartmentPositionList", method = RequestMethod.POST)
	@ResponseBody
	public List<PositionVO> getDepartmentPositionList(@RequestBody Map<String, Integer> departmentId) {
		return positionService.getDepartmentPositionList(departmentId.get("departmentId"));
	}
}
