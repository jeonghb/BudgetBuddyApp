package com.sandol.app.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.BillVO;

@Repository
public class BillDAOImp implements BillDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public boolean requestBill(BillVO billVO) {
		try {
			tmp.insert("com.sandol.mapper.app.requestBill", billVO);
		}catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
}
