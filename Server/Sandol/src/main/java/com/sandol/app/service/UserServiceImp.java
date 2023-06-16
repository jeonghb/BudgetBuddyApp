package com.sandol.app.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.UserDAO;
import com.sandol.app.vo.UserVO;

@Service
public class UserServiceImp implements UserService {
	
	@Inject
	UserDAO dao;

	@Override
	public String getUserCheck(UserVO _userVO) {
		return dao.getUserCheck(_userVO);
	}
	
	@Override
	public String getUserInfo(String _id) {
		return dao.getUserInfo(_id);
	}

	@Override
	public boolean setUserRegist(UserVO _userVO) {
		return dao.setUserRegist(_userVO);
	}
	
	@Override
	public UserVO LogIn(UserVO _userVO) {
		return dao.LogIn(_userVO);
	}
}
