package com.sandol.app.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.PositionRequestVO;
import com.sandol.app.vo.PositionVO;
import com.sandol.app.vo.UserPositionVO;

@Repository
public class PositionDAOImp implements PositionDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public List<PositionVO> getDepartmentPositionList(int _departmentId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getDepartmentPositionList", _departmentId);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public List<PositionVO> getRequestPossibilityDepartmentPositionList(String _userId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getRequestPossibilityDepartmentPositionList", _userId);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public boolean positionRequest(PositionRequestVO _positionRequestVO) {
		try {
			tmp.insert("com.sandol.mapper.app.positionRequest", _positionRequestVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public List<PositionRequestVO> getPositionRequestList(String _userId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getPositionRequestList", _userId);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public boolean positionRequestFinish(PositionRequestVO _positionRequestVO) {
		try {
			tmp.insert("com.sandol.mapper.app.positionRequestFinish", _positionRequestVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public boolean positionLeave(UserPositionVO _userPositionVO) {
		try {
			tmp.insert("com.sandol.mapper.app.positionLeave", _userPositionVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
}
