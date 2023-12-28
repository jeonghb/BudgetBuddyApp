package com.sandol.app.service;

import java.util.List;
import java.util.Map;

import com.sandol.app.vo.UserDepartmentPositionVO;
import com.sandol.app.vo.UserVO;

public interface UserService {
	
	public String getUserCheck(UserVO _userVO);
	
	public int getUserInfo(String _id);
	
	public boolean setUserRegist(UserVO _userVO);
	
	public UserVO login(UserVO _userVO);
	
	public boolean userPasswordFind(UserVO _userVO);
	
	public boolean userPasswordUpdate(UserVO _userVO);
	
	public boolean userInfoUpdate(UserVO _userVO);
	
	public List<UserDepartmentPositionVO> getLoginUserDepartmentPositionList(Map<String, Object> _user);
}
