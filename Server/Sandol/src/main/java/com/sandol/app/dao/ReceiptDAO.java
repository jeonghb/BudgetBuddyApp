package com.sandol.app.dao;

import java.util.List;

import com.sandol.app.vo.ReceiptVO;

public interface ReceiptDAO {
	
	public boolean requestReceipt(ReceiptVO _receiptVO);
	
	public List<ReceiptVO> getReceiptApprovalList(String _userId);
	
	public List<ReceiptVO> getReceiptRequestList(String _userId);
	
	public boolean changeSubmissionStatus(ReceiptVO _receiptVO);
}
