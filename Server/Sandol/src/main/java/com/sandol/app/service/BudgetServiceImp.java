package com.sandol.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.BudgetDAO;
import com.sandol.app.vo.BudgetTypeVO;


@Service
public class BudgetServiceImp implements BudgetService {
	
	@Inject
	BudgetDAO dao;
	
	@Override
	public List<BudgetTypeVO> getBudgetTypeList(String _userId) {
		return dao.getBudgetTypeList(_userId);
	}

	@Override
	public boolean budgetTypeAdd(BudgetTypeVO _budgetTypeVO) {
		return dao.budgetTypeAdd(_budgetTypeVO);
	}
}
