package com.sandol.app.dao;

import java.util.List;
import java.util.Map;

import com.sandol.app.vo.ReceiptVO;

public interface ReceiptDAO {
	
	public boolean requestReceipt(ReceiptVO _receiptVO);
	
	public List<ReceiptVO> getRequestReceiptList(Map<String, Object> _requestMap);
	
	public boolean changeSubmissionStatus(ReceiptVO _receiptVO);
}
