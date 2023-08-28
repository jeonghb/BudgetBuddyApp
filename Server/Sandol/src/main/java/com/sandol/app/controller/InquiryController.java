package com.sandol.app.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sandol.app.service.InquiryService;
import com.sandol.app.vo.InquiryVO;

@Controller
public class InquiryController {
	
	@Autowired
	InquiryService inquiryService;
	
	@RequestMapping(value = "/inquiryRequest", method = RequestMethod.POST)
	@ResponseBody
	public boolean inquiryRequest(@RequestBody InquiryVO _inquiryVO) {
		return inquiryService.inquiryRequest(_inquiryVO);
	}
	
	@RequestMapping(value = "/getInquiryList", method = RequestMethod.POST)
	@ResponseBody
	public List<InquiryVO> getInquiryList(@RequestBody Map<String, String> _userId) {
		return inquiryService.getInquiryList(_userId.get("userId"));
	}
}
