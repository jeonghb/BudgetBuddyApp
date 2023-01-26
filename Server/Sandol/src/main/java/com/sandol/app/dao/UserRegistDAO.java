package com.sandol.app.dao;

import com.sandol.app.vo.UserRegistVO;

public interface UserRegistDAO {
	
	public String getUserCheck(UserRegistVO userRegistVO);
	
	public String getUserInfo(String id);
	
	public boolean setUserRegist(UserRegistVO userRegistVO);
}
