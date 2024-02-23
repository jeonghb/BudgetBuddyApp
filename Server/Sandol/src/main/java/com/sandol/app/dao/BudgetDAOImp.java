package com.sandol.app.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.sandol.app.vo.BudgetTypeVO;
import com.sandol.app.vo.BudgetVO;
import com.sandol.app.vo.BudgetYearVO;

@Repository
public class BudgetDAOImp implements BudgetDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public List<BudgetTypeVO> getBudgetTypeList(Map<String, Object> _map) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getBudgetTypeList", _map);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public boolean budgetTypeAdd(BudgetTypeVO _budgetTypeVO) {
		try {
			tmp.insert("com.sandol.mapper.app.budgetTypeAdd", _budgetTypeVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public List<BudgetYearVO> getBudgetYearList(Map<String, Object> _map) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getBudgetYearList", _map);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public boolean setBudgetYearAmount(BudgetYearVO _budgetYearVO) {
		try {
			tmp.insert("com.sandol.mapper.app.setBudgetYearAmount", _budgetYearVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public boolean budgetAdd(BudgetVO _budgetVO) {
		try {
			tmp.insert("com.sandol.mapper.app.budgetAdd", _budgetVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public List<BudgetVO> getBudgetList(Map<String, Object> _map) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getBudgetList", _map);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public boolean budgetUpdate(BudgetVO _budgetVO) {
		try {
			tmp.update("com.sandol.mapper.app.budgetUpdate", _budgetVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public boolean budgetRemove(Map<String, Object> _map) {
		try {
			tmp.delete("com.sandol.mapper.app.budgetDelete", _map);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public boolean budgetTypeActivationStatusSave(BudgetTypeVO _budgetTypeVO) {
		try {
			tmp.update("com.sandol.mapper.app.budgetTypeActivationStatusSave", _budgetTypeVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
}
