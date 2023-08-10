package com.sandol.app.dao;

import java.util.List;

import com.sandol.app.vo.BudgetTypeVO;

public interface BudgetDAO {
	
	public List<BudgetTypeVO> getBudgetTypeList(String _userId);
	
	public boolean budgetTypeAdd(BudgetTypeVO _budgetTypeVO);
}
