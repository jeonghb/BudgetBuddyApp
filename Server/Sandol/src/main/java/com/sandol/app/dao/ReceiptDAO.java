package com.sandol.app.dao;

import java.util.List;
import java.util.Map;

import com.sandol.app.vo.ReceiptVO;

public interface ReceiptDAO {
	
	public boolean requestReceipt(ReceiptVO _receiptVO);
	
	public List<ReceiptVO> getReceiptApprovalList(Map<String, Object> _user);
	
	public List<ReceiptVO> getReceiptRequestList(String _userId);
	
	public boolean changeSubmissionStatus(ReceiptVO _receiptVO);
}
