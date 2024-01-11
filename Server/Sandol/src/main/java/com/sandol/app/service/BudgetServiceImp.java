package com.sandol.app.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import com.sandol.app.dao.BudgetDAO;
import com.sandol.app.vo.BudgetTypeVO;
import com.sandol.app.vo.BudgetVO;
import com.sandol.app.vo.BudgetYearVO;


@Service
public class BudgetServiceImp implements BudgetService {
	
	@Inject
	BudgetDAO dao;
	
	@Override
	public List<BudgetTypeVO> getBudgetTypeList(Map<String, Object> _map) {
		return dao.getBudgetTypeList(_map);
	}

	@Override
	public boolean budgetTypeAdd(BudgetTypeVO _budgetTypeVO) {
		return dao.budgetTypeAdd(_budgetTypeVO);
	}
	
	@Override
	public List<BudgetYearVO> getBudgetYearList(String _userId) {
		return dao.getBudgetYearList(_userId);
	}
	
	@Override
	public boolean setBudgetYearAmount(BudgetYearVO _budgetYearVO) {
		return dao.setBudgetYearAmount(_budgetYearVO);
	}
	
	@Override
	public boolean budgetAdd(BudgetVO _budgetVO) {
		return dao.budgetAdd(_budgetVO);
	}
	
	@Override
	public List<BudgetVO> getBudgetList(Map<String, Object> _map) {
		return dao.getBudgetList(_map);
	}
	
	@Override
	public boolean budgetUpdate(BudgetVO _budgetVO) {
		return dao.budgetUpdate(_budgetVO);
	}
	
	@Override
	public boolean budgetDelete(int _id) {
		return dao.budgetDelete(_id);
	}
	
	@Override
	public boolean budgetTypeActivationStatusSave(BudgetTypeVO _budgetTypeVO) {
		return dao.budgetTypeActivationStatusSave(_budgetTypeVO);
	}
}
