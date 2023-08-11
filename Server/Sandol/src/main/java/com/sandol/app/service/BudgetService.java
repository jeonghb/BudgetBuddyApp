package com.sandol.app.service;

import java.util.List;

import com.sandol.app.vo.BudgetTypeVO;
import com.sandol.app.vo.BudgetYearVO;

public interface BudgetService {

	public List<BudgetTypeVO> getBudgetTypeList(String _userId);
	
	public boolean budgetTypeAdd(BudgetTypeVO _budgetTypeVO);
	
	public List<BudgetYearVO> getBudgetYearList(String _userId);
	
	public boolean setBudgetYearAmount(BudgetYearVO _budgetYearVO);
}
