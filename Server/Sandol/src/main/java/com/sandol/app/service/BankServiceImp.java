package com.sandol.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.BankDAO;
import com.sandol.app.vo.BankVO;

@Service
public class BankServiceImp implements BankService {
	
	@Inject
	BankDAO dao;

	@Override
	public List<BankVO> getBankList() {
		return dao.getBankList();
	}
}
