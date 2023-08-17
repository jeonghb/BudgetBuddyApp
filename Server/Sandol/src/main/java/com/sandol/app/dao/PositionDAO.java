package com.sandol.app.dao;

import java.util.List;

import com.sandol.app.vo.PositionRequestVO;
import com.sandol.app.vo.PositionVO;
import com.sandol.app.vo.UserPositionVO;

public interface PositionDAO {
	
	public List<PositionVO> getDepartmentPositionList(int _departmentId);
	
	public List<PositionVO> getRequestPossibilityDepartmentPositionList(String _userId);
	
	public boolean positionRequest(PositionRequestVO _positionRequestVO);
	
	public List<PositionRequestVO> getPositionRequestList(String _userId);
	
	public boolean positionRequestFinish(PositionRequestVO _positionRequestVO);
	
	public boolean positionLeave(UserPositionVO _userPositionVO);
	
	public boolean positionAdd(PositionVO _positionVO);
	
	public List<PositionVO> getPositionList();
	
	public boolean positionUpdate(PositionVO _positionVO);
}
