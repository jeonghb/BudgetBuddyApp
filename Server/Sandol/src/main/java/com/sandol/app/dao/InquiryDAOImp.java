package com.sandol.app.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.InquiryVO;

@Repository
public class InquiryDAOImp implements InquiryDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public boolean inquiryRequest(InquiryVO _inquiryVO) {
		try {
			tmp.insert("com.sandol.mapper.app.inquiryRequest", _inquiryVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public List<InquiryVO> getInquiryList(String _userId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getInquiryList", _userId);
		} catch (NullPointerException e) {
			return null;
		}
	}
}
