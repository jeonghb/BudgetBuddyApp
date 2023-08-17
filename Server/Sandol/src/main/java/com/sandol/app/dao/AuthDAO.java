package com.sandol.app.dao;

import java.util.List;

import com.sandol.app.vo.AuthVO;

public interface AuthDAO {
	
	public List<AuthVO> getAuthList();
}
