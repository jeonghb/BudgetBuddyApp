package com.sandol.app.service;

import com.sandol.app.vo.UserVO;

public interface UserService {
	
	public String getUserCheck(UserVO _userVO);
	
	public String getUserInfo(String _id);
	
	public boolean setUserRegist(UserVO _userVO);
	
	public UserVO LogIn(UserVO _userVO);
}
