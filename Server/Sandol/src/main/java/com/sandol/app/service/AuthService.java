package com.sandol.app.service;

import java.util.List;

import com.sandol.app.vo.AuthVO;
import com.sandol.app.vo.PositionAuthVO;

public interface AuthService {
	
	public List<AuthVO> getAuthList();
	
	public List<PositionAuthVO> getUserAuthList(String _userId);
}
