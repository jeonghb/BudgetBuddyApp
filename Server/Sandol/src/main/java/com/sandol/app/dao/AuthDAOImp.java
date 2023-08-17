package com.sandol.app.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.AuthVO;

@Repository
public class AuthDAOImp implements AuthDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public List<AuthVO> getAuthList() {
		try {
			return tmp.selectList("com.sandol.mapper.app.getAuthList");
		}catch (NullPointerException e) {
			return null;
		}
	}
}
