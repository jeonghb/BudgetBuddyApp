package com.sandol.app.service;

import java.util.List;
import java.util.Map;

import com.sandol.app.vo.AuthVO;
import com.sandol.app.vo.PositionAuthVO;

public interface AuthService {
	
	public List<AuthVO> getPositionAuthList(Map<String, Object> _map);
	
	public List<PositionAuthVO> getUserAuthList(Map<String, Object> _map);
	
	public List<AuthVO> getGroupMasterAuthList(Map<String, Object> _map);
}
