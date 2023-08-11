package com.sandol.app.service;
import java.util.List;

import com.sandol.app.vo.PositionRequestVO;
import com.sandol.app.vo.PositionVO;
import com.sandol.app.vo.UserPositionVO;

public interface PositionService {

	public List<PositionVO> getDepartmentPositionList(int _departmentId);
	
	public List<PositionVO> getRequestPossibilityDepartmentPositionList(String _userId);
	
	public boolean positionRequest(PositionRequestVO _positionRequestVO);
	
	public List<PositionRequestVO> getPositionRequestList(String _userId);
	
	public boolean positionRequestFinish(PositionRequestVO _positionRequestVO);
	
	public boolean positionLeave(UserPositionVO _userPositionVO);
}