package com.sandol.app.dao;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.UserRegistVO;

@Repository
public class UserRegistDAOImp implements UserRegistDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
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
}