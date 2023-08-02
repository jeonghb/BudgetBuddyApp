package com.sandol.app.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.UserDepartmentPositionVO;
import com.sandol.app.vo.UserVO;

@Repository
public class UserDAOImp implements UserDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public String getUserCheck(UserVO _userVO) {
		try {
			return tmp.selectOne("com.sandol.mapper.app.userCheck", _userVO);
		}catch (NullPointerException e) {
			return "";
		}
	}
	
	@Override
	public String getUserInfo(String _id) {		
		try {
			return tmp.selectOne("com.sandol.mapper.app.selectUserInfo", _id);
		} catch (NullPointerException e) {
			return "-1";
		}
	}
	
	@Override
	public boolean setUserRegist(UserVO _userVO) {
		try {
			tmp.insert("com.sandol.mapper.app.insertUserInfo", _userVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}

	@Override
	public UserVO login(UserVO _userVO) {
		UserVO newVO = null;
		
		try {
			newVO = tmp.selectOne("com.sandol.mapper.app.login", _userVO);
			if (newVO.getUserName() != null) {
				_userVO.setLogInIsSuccess(true);
				_userVO.LogInUpdate(newVO);
			}
			else {
				_userVO.setLogInIsSuccess(false);
			}
		} catch (NullPointerException e) {
			return _userVO;
		}
		
		return _userVO;
	}
	
	@Override
	public boolean userPasswordFind(UserVO _userVO) {
		String result = "";
		
		try {
			result = tmp.selectOne("com.sandol.mapper.app.userPasswordFind", _userVO);
			
			if (result.equals("0")) {
				return false;
			}
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public boolean userPasswordUpdate(UserVO _userVO) {
		int result = 0;
		
		try {
			result = tmp.update("com.sandol.mapper.app.userPasswordUpdate", _userVO);
			
			if (result == 0) {
				return false;
			}
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public boolean userInfoUpdate(UserVO _userVO) {
		int result = 0;
		
		try {
			result = tmp.update("com.sandol.mapper.app.userInfoUpdate", _userVO);
			
			if (result == 0) {
				return false;
			}
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public List<UserDepartmentPositionVO> getLoginUserDepartmentPositionList(String _userId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getLoginUserDepartmentPositionList", _userId);
		}catch (NullPointerException e) {
			return null;
		}
	}
}
