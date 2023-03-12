package com.sandol.app.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.UserRegistDAO;
import com.sandol.app.vo.UserRegistVO;

@Service
public class UserRegistServiceImp implements UserRegistService {
	
	@Inject
	UserRegistDAO dao;

	@Override
	public String getUserCheck(UserRegistVO userRegistVO) {
		return dao.getUserCheck(userRegistVO);
	}
	
	@Override
	public String getUserInfo(String id) {
		return dao.getUserInfo(id);
	}

	@Override
	public boolean setUserRegist(UserRegistVO userRegistVO) {
		return dao.setUserRegist(userRegistVO);
	}
	
	@Override
	public UserRegistVO LogIn(UserRegistVO userRegistVO) {
		return dao.LogIn(userRegistVO);
	}
}
