package com.sandol.app.service;

import java.util.List;

import com.sandol.app.vo.UserDepartmentPositionVO;
import com.sandol.app.vo.UserVO;

public interface UserService {
	
	public boolean getUserCheck(UserVO _userVO);
	
	public boolean getUserInfo(String _id);
	
	public boolean setUserRegist(UserVO _userVO);
	
	public UserVO login(UserVO _userVO);
	
	public boolean userPasswordFind(UserVO _userVO);
	
	public boolean userPasswordUpdate(UserVO _userVO);
	
	public boolean userInfoUpdate(UserVO _userVO);
	
	public List<UserDepartmentPositionVO> getLoginUserDepartmentPositionList(String _userId);
}
