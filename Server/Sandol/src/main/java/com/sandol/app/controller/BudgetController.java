package com.sandol.app.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sandol.app.service.BudgetService;
import com.sandol.app.vo.BudgetTypeVO;
import com.sandol.app.vo.BudgetYearVO;

@Controller
public class BudgetController {
	
	@Autowired
	BudgetService budgetService;
	
	@RequestMapping(value = "/getBudgetTypeList", method = RequestMethod.POST)
	@ResponseBody
	public List<BudgetTypeVO> getBudgetTypeList(@RequestBody Map<String, String> _userId) {
		return budgetService.getBudgetTypeList(_userId.get("userId"));
	}
	
	@RequestMapping(value = "/budgetTypeAdd", method = RequestMethod.POST)
	@ResponseBody
	public boolean budgetTypeAdd(@RequestBody BudgetTypeVO _budgetTypeVO) {
		return budgetService.budgetTypeAdd(_budgetTypeVO);
	}
	
	@RequestMapping(value = "/getBudgetYearList", method = RequestMethod.POST)
	@ResponseBody
	public List<BudgetYearVO> getBudgetYearList(@RequestBody Map<String, String> _userId) {
		return budgetService.getBudgetYearList(_userId.get("userId"));
	}
	
	@RequestMapping(value = "/setBudgetYearAmount", method = RequestMethod.POST)
	@ResponseBody
	public boolean setBudgetYearAmount(@RequestBody BudgetYearVO _budgetYearVO) {
		return budgetService.setBudgetYearAmount(_budgetYearVO);
	}
}
