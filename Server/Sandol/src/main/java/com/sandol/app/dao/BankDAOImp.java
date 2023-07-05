package com.sandol.app.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.BankVO;

@Repository
public class BankDAOImp implements BankDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public List<BankVO> getBankList() {
		try {
			return tmp.selectList("com.sandol.mapper.app.getBankList");
		}catch (NullPointerException e) {
			return null;
		}
	}
}
