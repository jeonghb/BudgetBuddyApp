package com.sandol.app.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.BudgetTypeVO;

@Repository
public class BudgetDAOImp implements BudgetDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public List<BudgetTypeVO> getBudgetTypeList(String _userId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getBudgetTypeList", _userId);
		}catch (NullPointerException e) {
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
}
