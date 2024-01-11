package com.sandol.app.dao;

import java.util.List;
import java.util.Map;

import com.sandol.app.vo.BudgetTypeVO;
import com.sandol.app.vo.BudgetVO;
import com.sandol.app.vo.BudgetYearVO;

public interface BudgetDAO {
	
	public List<BudgetTypeVO> getBudgetTypeList(Map<String, Object> _map);
	
	public boolean budgetTypeAdd(BudgetTypeVO _budgetTypeVO);
	
	public List<BudgetYearVO> getBudgetYearList(String _userId);
	
	public boolean setBudgetYearAmount(BudgetYearVO _budgetYearVO);
	
	public boolean budgetAdd(BudgetVO _budgetVO);
	
	public List<BudgetVO> getBudgetList(Map<String, Object> _map);
	
	public boolean budgetUpdate(BudgetVO _budgetVO);
	
	public boolean budgetDelete(int _id);
	
	public boolean budgetTypeActivationStatusSave(BudgetTypeVO _budgetTypeVO);
}
