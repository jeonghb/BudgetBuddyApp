package com.sandol.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sandol.app.service.ReportService;
import com.sandol.app.vo.ReportVO;

@Controller
public class ReportController {
	
	@Autowired
	ReportService reportService;
	
	@RequestMapping(value = "/reportAdd", method = RequestMethod.POST)
	@ResponseBody
	public boolean reportAdd(@RequestBody ReportVO _reportVO) {
		return reportService.reportAdd(_reportVO);
	}
}
