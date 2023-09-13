package com.sandol.app.service;

import java.util.List;

import com.sandol.app.vo.ReceiptVO;

public interface ReceiptService {
	
	public boolean requestReceipt(ReceiptVO _receiptVO);
	
	public List<ReceiptVO> getReceiptApprovalList(String _userId);
	
	public List<ReceiptVO> getReceiptRequestList(String _userId);
	
	public boolean changeSubmissionStatus(ReceiptVO _receiptVO);
}
