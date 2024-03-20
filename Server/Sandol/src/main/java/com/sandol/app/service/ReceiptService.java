package com.sandol.app.service;

import java.util.List;
import java.util.Map;

import com.sandol.app.vo.ReceiptVO;

public interface ReceiptService {
	
	public boolean requestReceipt(ReceiptVO _receiptVO);
	
	public List<ReceiptVO> getReceiptApprovalList(Map<String, Object> _user);
	
	public List<ReceiptVO> getReceiptRequestList(Map<String, Object> _map);
	
	public boolean changeSubmissionStatus(ReceiptVO _receiptVO);
	
	public boolean receiptRemove(Map<String, Object> _map);
}
