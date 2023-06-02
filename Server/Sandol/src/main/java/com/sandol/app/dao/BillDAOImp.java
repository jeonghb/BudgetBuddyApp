package com.sandol.app.dao;

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
			int requestId = tmp.insert("com.sandol.mapper.app.requestBill", billVO);
			
			if (requestId > 0) {
				billVO.setRequestId(requestId);
			}
			else return false;
		}catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
}
