package com.sandol.app.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.UserRegistVO;

@Repository
public class UserRegistDAOImp implements UserRegistDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public String getUserCheck(UserRegistVO userRegistVO) {
		try {
			return tmp.selectOne("com.sandol.mapper.app.selectUserCheck", userRegistVO);
		}catch (NullPointerException e) {
			return "-1";
		}
	}
	
	@Override
	public String getUserInfo(String id) {		
		try {
			return tmp.selectOne("com.sandol.mapper.app.selectUserInfo", id);
		} catch (NullPointerException e) {
			return "-1";
		}
	}
	
	@Override
	public boolean setUserRegist(UserRegistVO userRegistVO) {
		try {
			tmp.insert("com.sandol.mapper.app.insertUserInfo", userRegistVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}

	@Override
	public UserRegistVO LogIn(UserRegistVO userRegistVO) {
		UserRegistVO newVO = null;
		
		try {
			newVO = tmp.selectOne("com.sandol.mapper.app.LogIn", userRegistVO);
			if (newVO.getName() != null) {
				userRegistVO.setLogInIsSuccess(true);
				userRegistVO.LogInUpdate(newVO);
			}
			else {
				userRegistVO.setLogInIsSuccess(false);
			}
		} catch (NullPointerException e) {
			return userRegistVO;
		}
		
		return userRegistVO;
	}
}
