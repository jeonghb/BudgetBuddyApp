package com.sandol.app.dao;

import java.util.List;
import java.util.Map;

import com.sandol.app.vo.UserDepartmentPositionVO;
import com.sandol.app.vo.UserVO;

public interface UserDAO {
	
	public boolean getUserCheck(UserVO _userVO);
	
	public int getUserInfo(String _id);
	
	public boolean setUserRegist(UserVO _userVO);
	
	public UserVO login(UserVO _userVO);
	
	public boolean userPasswordFind(UserVO _userVO);
	
	public boolean userPasswordUpdate(UserVO _userVO);
	
	public boolean userInfoUpdate(UserVO _userVO);
	
	public List<UserDepartmentPositionVO> getLoginUserDepartmentPositionList(Map<String, Object> _user);
	
	public boolean userWithdraw(Map<String, Object> _map);
}
