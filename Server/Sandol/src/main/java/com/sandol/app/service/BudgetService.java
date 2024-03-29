package com.sandol.app.service;

import java.util.List;
import java.util.Map;

import com.sandol.app.vo.BudgetTypeVO;
import com.sandol.app.vo.BudgetVO;
import com.sandol.app.vo.BudgetYearVO;

public interface BudgetService {

	public List<BudgetTypeVO> getBudgetTypeList(Map<String, Object> _map);
	
	public boolean budgetTypeAdd(BudgetTypeVO _budgetTypeVO);
	
	public List<BudgetYearVO> getBudgetYearList(Map<String, Object> _map);
	
	public boolean setBudgetYearAmount(BudgetYearVO _budgetYearVO);
	
	public boolean budgetAdd(BudgetVO _budgetVO);
	
	public List<BudgetVO> getBudgetList(Map<String, Object> _map);
	
	public boolean budgetUpdate(BudgetVO _budgetVO);
	
	public boolean budgetRemove(Map<String, Object> _map);
	
	public boolean budgetTypeActivationStatusSave(BudgetTypeVO _budgetTypeVO);
}
