package com.sandol.app.service;

import java.util.List;

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
	public List<ReceiptVO> getReceiptApprovalList(String _userId) {
		return dao.getReceiptApprovalList(_userId);
	}
	
	@Override
	public List<ReceiptVO> getReceiptRequestList(String _userId) {
		return dao.getReceiptRequestList(_userId);
	}
	
	@Override
	public boolean changeSubmissionStatus(ReceiptVO _receiptVO) {
		return dao.changeSubmissionStatus(_receiptVO);
	}
}
