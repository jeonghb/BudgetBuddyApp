package com.sandol.app.dao;

import java.util.List;

import com.sandol.app.vo.AuthVO;
import com.sandol.app.vo.PositionAuthVO;

public interface AuthDAO {
	
	public List<AuthVO> getAuthList();
	
	public List<PositionAuthVO> getUserAuthList(String _userId);
}
