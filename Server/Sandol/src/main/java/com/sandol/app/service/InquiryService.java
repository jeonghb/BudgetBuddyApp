package com.sandol.app.service;

import java.util.List;

import com.sandol.app.vo.InquiryVO;

public interface InquiryService {

	public boolean inquiryRequest(InquiryVO _inquiryVO);
	
	public List<InquiryVO> getInquiryList(String _userId);
}
