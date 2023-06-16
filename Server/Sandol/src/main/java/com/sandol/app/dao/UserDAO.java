package com.sandol.app.dao;

import com.sandol.app.vo.UserVO;

public interface UserDAO {
	
	public String getUserCheck(UserVO _userVO);
	
	public String getUserInfo(String _id);
	
	public boolean setUserRegist(UserVO _userVO);
	
	public UserVO LogIn(UserVO _userVO);
}
