package com.sandol.app.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.AuthVO;
import com.sandol.app.vo.PositionAuthVO;

@Repository
public class AuthDAOImp implements AuthDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public List<AuthVO> getPositionAuthList(Map<String, Object> _map) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getPositionAuthList", _map);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public List<PositionAuthVO> getUserAuthList(Map<String, Object> _user) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getUserAuthList", _user);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public List<AuthVO> getGroupMasterAuthList(Map<String, Object> _map) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getGroupMasterAuthList", _map);
		} catch (NullPointerException e) {
			return null;
		}
	}
}
