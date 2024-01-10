package com.sandol.app.service;
import java.util.List;
import java.util.Map;

import com.sandol.app.vo.PositionRequestVO;
import com.sandol.app.vo.PositionVO;
import com.sandol.app.vo.UserPositionVO;

public interface PositionService {
	
	public List<PositionVO> getRequestPossibilityDepartmentPositionList(String _userId);
	
	public boolean positionRequest(PositionRequestVO _positionRequestVO);
	
	public List<PositionRequestVO> getPositionRequestList(Map<String, Object> _map);
	
	public boolean positionRequestFinish(PositionRequestVO _positionRequestVO);
	
	public boolean positionLeave(UserPositionVO _userPositionVO);
	
	public boolean positionAdd(PositionVO _positionVO);
	
	public List<PositionVO> getPositionList();
	
	public boolean positionUpdate(PositionVO _positionVO);
}
