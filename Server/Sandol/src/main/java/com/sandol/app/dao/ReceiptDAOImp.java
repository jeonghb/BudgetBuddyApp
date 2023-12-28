package com.sandol.app.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.ReceiptVO;

@Repository
public class ReceiptDAOImp implements ReceiptDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public boolean requestReceipt(ReceiptVO _receiptVO) {
		try {
			int requestId = tmp.insert("com.sandol.mapper.app.requestReceipt", _receiptVO);
			
			if (requestId > 0) {
				_receiptVO.setRequestId(requestId);
			}
			else return false;
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public List<ReceiptVO> getReceiptApprovalList(Map<String, Object> _user) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getReceiptApprovalList", _user);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public List<ReceiptVO> getReceiptRequestList(String _userId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getReceiptRequestList", _userId);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public boolean changeSubmissionStatus(ReceiptVO _receiptVO) {
		try {
			int result = tmp.update("com.sandol.mapper.app.changeSubmissionStatus", _receiptVO);
			
			if (result == 1) return true;
			else return false;
		} catch (NullPointerException e) {
			return false;
		}
	}
}
