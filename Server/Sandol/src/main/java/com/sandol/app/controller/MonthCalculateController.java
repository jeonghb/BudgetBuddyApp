package com.sandol.app.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sandol.app.service.MonthCalculateService;
import com.sandol.app.vo.MonthCalculateVO;

@Controller
public class MonthCalculateController {
	
	@Autowired
	MonthCalculateService monthCalculateService;
	
	@RequestMapping(value = "/getMonthCalculateStatus", method = RequestMethod.POST)
	@ResponseBody
	public boolean getMonthCalculateStatus(@RequestBody MonthCalculateVO _monthCalculateVO) {
		return monthCalculateService.getMonthCalculateStatus(_monthCalculateVO);
	}
	
	@RequestMapping(value = "/getMonthCalculateData", method = RequestMethod.POST)
	@ResponseBody
	public MonthCalculateVO getMonthCalculateData(@RequestBody MonthCalculateVO _monthCalculateVO) {
		return monthCalculateService.getMonthCalculateData(_monthCalculateVO);
	}
	
	@RequestMapping(value = "/monthCalculateAdd", method = RequestMethod.POST)
	@ResponseBody
	public boolean monthCalculateAdd(@RequestBody MonthCalculateVO _monthCalculateVO) {
		return monthCalculateService.monthCalculateAdd(_monthCalculateVO);
	}
	
	@RequestMapping(value = "/monthCalculateUpdate", method = RequestMethod.POST)
	@ResponseBody
	public boolean monthCalculateUpdate(@RequestBody Map<String, Object> _map) {
		return monthCalculateService.monthCalculateUpdate(_map);
	}
}
