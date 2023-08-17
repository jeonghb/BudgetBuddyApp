package com.sandol.app.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import com.sandol.app.dao.PositionDAO;
import com.sandol.app.vo.PositionRequestVO;
import com.sandol.app.vo.PositionVO;
import com.sandol.app.vo.UserPositionVO;

@Service
public class PositionServiceImp implements PositionService {
	
	@Inject
	PositionDAO dao;
	
	@Override
	public List<PositionVO> getDepartmentPositionList(int _departmentId) {
		return dao.getDepartmentPositionList(_departmentId);
	}
	
	@Override
	public List<PositionVO> getRequestPossibilityDepartmentPositionList(String _userId) {
		return dao.getRequestPossibilityDepartmentPositionList(_userId);
	}
	
	@Override
	public boolean positionRequest(PositionRequestVO _positionRequestVO) {
		return dao.positionRequest(_positionRequestVO);
	}
	
	@Override
	public List<PositionRequestVO> getPositionRequestList(String _userId) {
		return dao.getPositionRequestList(_userId);
	}
	
	@Override
	public boolean positionRequestFinish(PositionRequestVO _positionRequestVO) {
		return dao.positionRequestFinish(_positionRequestVO);
	}
	
	@Override
	public boolean positionLeave(UserPositionVO _userPositionVO) {
		return dao.positionLeave(_userPositionVO);
	}
	
	@Override
	public boolean positionAdd(PositionVO _positionVO) {
		return dao.positionAdd(_positionVO);
	}
	
	@Override
	public List<PositionVO> getPositionList() {
		return dao.getPositionList();
	}
	
	@Override
	public boolean positionUpdate(PositionVO _positionVO) {
		return dao.positionUpdate(_positionVO);
	}
}
