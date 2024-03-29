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
import com.sandol.app.vo.BudgetVO;
import com.sandol.app.vo.BudgetYearVO;

@Controller
public class BudgetController {
	
	@Autowired
	BudgetService budgetService;
	
	@RequestMapping(value = "/getBudgetTypeList", method = RequestMethod.POST)
	@ResponseBody
	public List<BudgetTypeVO> getBudgetTypeList(@RequestBody Map<String, Object> _map) {
		return budgetService.getBudgetTypeList(_map);
	}
	
	@RequestMapping(value = "/budgetTypeAdd", method = RequestMethod.POST)
	@ResponseBody
	public boolean budgetTypeAdd(@RequestBody BudgetTypeVO _budgetTypeVO) {
		return budgetService.budgetTypeAdd(_budgetTypeVO);
	}
	
	@RequestMapping(value = "/getBudgetYearList", method = RequestMethod.POST)
	@ResponseBody
	public List<BudgetYearVO> getBudgetYearList(@RequestBody Map<String, Object> _map) {
		return budgetService.getBudgetYearList(_map);
	}
	
	@RequestMapping(value = "/setBudgetYearAmount", method = RequestMethod.POST)
	@ResponseBody
	public boolean setBudgetYearAmount(@RequestBody BudgetYearVO _budgetYearVO) {
		return budgetService.setBudgetYearAmount(_budgetYearVO);
	}
	
	@RequestMapping(value = "/budgetAdd", method = RequestMethod.POST)
	@ResponseBody
	public boolean budgetAdd(@RequestBody BudgetVO _budgetVO) {
		return budgetService.budgetAdd(_budgetVO);
	}
	
	@RequestMapping(value = "/getBudgetList", method = RequestMethod.POST)
	@ResponseBody
	public List<BudgetVO> getBudgetList(@RequestBody Map<String, Object> _map) {
		return budgetService.getBudgetList(_map);
	}
	
	@RequestMapping(value = "/budgetUpdate", method = RequestMethod.POST)
	@ResponseBody
	public boolean budgetUpdate(@RequestBody BudgetVO _budgetVO) {
		return budgetService.budgetUpdate(_budgetVO);
	}
	
	@RequestMapping(value = "/budgetRemove", method = RequestMethod.POST)
	@ResponseBody
	public boolean budgetRemove(@RequestBody Map<String, Object> _map) {
		return budgetService.budgetRemove(_map);
	}
	
	@RequestMapping(value = "/budgetTypeActivationStatusSave", method = RequestMethod.POST)
	@ResponseBody
	public boolean budgetTypeActivationStatusSave(@RequestBody BudgetTypeVO _budgetTypeVO) {
		return budgetService.budgetTypeActivationStatusSave(_budgetTypeVO);
	}
}
