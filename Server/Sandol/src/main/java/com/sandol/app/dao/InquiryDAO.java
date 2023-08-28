package com.sandol.app.dao;

import java.util.List;

import com.sandol.app.vo.InquiryVO;

public interface InquiryDAO {
	
	public boolean inquiryRequest(InquiryVO _inquiryVO);
	
	public List<InquiryVO> getInquiryList(String _userId);
}
