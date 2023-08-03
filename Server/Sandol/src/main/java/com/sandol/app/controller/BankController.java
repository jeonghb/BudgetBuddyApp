package com.sandol.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sandol.app.service.BankService;
import com.sandol.app.vo.BankVO;

@Controller
public class BankController {
	
	@Autowired
	BankService bankService;
	
	@RequestMapping(value = "/getBankList", method = RequestMethod.GET)
	@ResponseBody
	public List<BankVO> getBankList() {
		return bankService.getBankList();
	}
}
