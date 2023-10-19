package com.sandol.app.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.ReportVO;

@Repository
public class ReportDAOImp implements ReportDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public boolean reportAdd(ReportVO _reportVO) {
		try {
			tmp.insert("com.sandol.mapper.app.reportAdd", _reportVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
}