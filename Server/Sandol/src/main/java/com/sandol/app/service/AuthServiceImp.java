package com.sandol.app.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.AuthDAO;
import com.sandol.app.vo.AuthVO;
import com.sandol.app.vo.PositionAuthVO;

@Service
public class AuthServiceImp implements AuthService {
	
	@Inject
	AuthDAO dao;
	
	@Override
	public List<AuthVO> getPositionAuthList(Map<String, Object> _map) {
		return dao.getPositionAuthList(_map);
	}
	
	@Override
	public List<PositionAuthVO> getUserAuthList(Map<String, Object> _map) {
		return dao.getUserAuthList(_map);
	}
	
	@Override
	public List<AuthVO> getGroupMasterAuthList(Map<String, Object> _map) {
		return dao.getGroupMasterAuthList(_map);
	}
}
