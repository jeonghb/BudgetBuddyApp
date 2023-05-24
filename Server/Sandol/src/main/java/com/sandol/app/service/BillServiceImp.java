package com.sandol.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.BillDAO;
import com.sandol.app.vo.BillVO;

@Service
public class BillServiceImp implements BillService {
	
	@Inject
	BillDAO dao;

	@Override
	public boolean requestBill(BillVO billVO) {
		return dao.requestBill(billVO);
	}
}
