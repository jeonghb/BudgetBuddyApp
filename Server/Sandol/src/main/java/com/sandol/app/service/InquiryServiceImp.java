package com.sandol.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.InquiryDAO;
import com.sandol.app.vo.InquiryVO;

@Service
public class InquiryServiceImp implements InquiryService {
	
	@Inject
	InquiryDAO dao;

	@Override
	public boolean inquiryRequest(InquiryVO _inquiryVO) {
		return dao.inquiryRequest(_inquiryVO);
	}
	
	@Override
	public List<InquiryVO> getInquiryList(String _userId) {
		return dao.getInquiryList(_userId);
	}
}
