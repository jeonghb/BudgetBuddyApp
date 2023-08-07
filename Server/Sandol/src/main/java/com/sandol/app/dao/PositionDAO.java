package com.sandol.app.dao;

import java.util.List;

import com.sandol.app.vo.PositionRequestVO;
import com.sandol.app.vo.PositionVO;

public interface PositionDAO {
	
	public List<PositionVO> getDepartmentPositionList(int departmentId);
	
	public boolean positionRequest(PositionRequestVO _positionRequestVO);
}
