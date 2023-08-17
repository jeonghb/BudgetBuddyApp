package com.sandol.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.AuthDAO;
import com.sandol.app.vo.AuthVO;

@Service
public class AuthServiceImp implements AuthService {
	
	@Inject
	AuthDAO dao;

	@Override
	public List<AuthVO> getAuthList() {
		return dao.getAuthList();
	}
}
