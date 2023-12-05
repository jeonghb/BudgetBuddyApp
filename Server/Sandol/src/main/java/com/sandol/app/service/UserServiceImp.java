package com.sandol.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.UserDAO;
import com.sandol.app.vo.UserDepartmentPositionVO;
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
	public boolean getUserInfo(String _id) {
		return dao.getUserInfo(_id);
	}

	@Override
	public boolean setUserRegist(UserVO _userVO) {
		return dao.setUserRegist(_userVO);
	}
	
	@Override
	public UserVO login(UserVO _userVO) {
		return dao.login(_userVO);
	}
	
	@Override
	public boolean userPasswordFind(UserVO _userVO) {
		return dao.userPasswordFind(_userVO);
	}
	
	@Override
	public boolean userPasswordUpdate(UserVO _userVO) {
		return dao.userPasswordUpdate(_userVO);
	}
	
	@Override
	public boolean userInfoUpdate(UserVO _userVO) {
		return dao.userInfoUpdate(_userVO);
	}
	
	@Override
	public List<UserDepartmentPositionVO> getLoginUserDepartmentPositionList(String _userId) {
		return dao.getLoginUserDepartmentPositionList(_userId);
	}
}
