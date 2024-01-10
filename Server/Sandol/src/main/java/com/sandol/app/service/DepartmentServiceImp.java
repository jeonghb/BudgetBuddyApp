package com.sandol.app.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.DepartmentDAO;
import com.sandol.app.vo.DepartmentMemberVO;
import com.sandol.app.vo.DepartmentRequestVO;
import com.sandol.app.vo.DepartmentVO;
import com.sandol.app.vo.UserDepartmentVO;

@Service
public class DepartmentServiceImp implements DepartmentService {
	
	@Inject
	DepartmentDAO dao;

	@Override
	public List<DepartmentVO> getDepartmentList(Map<String, Object> _map) {
		return dao.getDepartmentList(_map);
	}

	@Override
	public boolean departmentAdd(Map<String, Object> _department) {
		return dao.departmentAdd(_department);
	}
	
	@Override
	public boolean departmentUpdate(DepartmentVO _departmentVO) {
		return dao.departmentUpdate(_departmentVO);
	}
	
	@Override
	public boolean departmentRequest(UserDepartmentVO _userDepartmentVO) {
		return dao.departmentRequest(_userDepartmentVO);
	}
	
	@Override
	public List<DepartmentVO> getRequestPositilityDepartmentList(String _userId) {
		return dao.getRequestPositilityDepartmentList(_userId);
	}
	
	@Override
	public List<DepartmentRequestVO> getDepartmentRequestList(Map<String, Object> _map) {
		return dao.getDepartmentRequestList(_map);
	}
	
	@Override
	public boolean departmentRequestFinish(DepartmentRequestVO _departmentRequestVO) {
		return dao.departmentRequestFinish(_departmentRequestVO);
	}
	
	@Override
	public List<DepartmentMemberVO> getDepartmentMemberList(Map<String, Object> _map) {
		return dao.getDepartmentMemberList(_map);
	}
	
	@Override
	public boolean departmentLeave(UserDepartmentVO _userDepartmentVO) {
		return dao.departmentLeave(_userDepartmentVO);
	}
}
