package com.sandol.app.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.ReceiptDAO;
import com.sandol.app.vo.ReceiptVO;

@Service
public class ReceiptServiceImp implements ReceiptService {
	
	@Inject
	ReceiptDAO dao;

	@Override
	public boolean requestReceipt(ReceiptVO _receiptVO) {
		return dao.requestReceipt(_receiptVO);
	}
	
	@Override
	public List<ReceiptVO> getRequestReceiptList(Map<String, Object> _requestMap) {
		return dao.getRequestReceiptList(_requestMap);
	}
	
	@Override
	public boolean changeSubmissionStatus(ReceiptVO _receiptVO) {
		return dao.changeSubmissionStatus(_receiptVO);
	}
}
