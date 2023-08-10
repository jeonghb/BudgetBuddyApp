package com.sandol.app.service;

import java.util.List;
import com.sandol.app.vo.BudgetTypeVO;

public interface BudgetService {

	public List<BudgetTypeVO> getBudgetTypeList(String _userId);
	
	public boolean budgetTypeAdd(BudgetTypeVO _budgetTypeVO);
}
