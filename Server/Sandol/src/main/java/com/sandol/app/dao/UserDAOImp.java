package com.sandol.app.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
			return "-1";
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
	public UserVO LogIn(UserVO _userVO) {
		UserVO newVO = null;
		
		try {
			newVO = tmp.selectOne("com.sandol.mapper.app.logIn", _userVO);
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
}
