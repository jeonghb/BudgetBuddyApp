package com.sandol.app.service;

import java.util.List;

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
	public List<DepartmentVO> getDepartmentList() {
		return dao.getDepartmentList();
	}

	@Override
	public boolean departmentAdd(DepartmentVO _departmentVO) {
		return dao.departmentAdd(_departmentVO);
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
	public List<DepartmentRequestVO> getDepartmentRequestList(String _userId) {
		return dao.getDepartmentRequestList(_userId);
	}
	
	@Override
	public boolean departmentRequestFinish(DepartmentRequestVO _departmentRequestVO) {
		return dao.departmentRequestFinish(_departmentRequestVO);
	}
	
	@Override
	public List<DepartmentMemberVO> getDepartmentMemberList(String _userId) {
		return dao.getDepartmentMemberList(_userId);
	}
	
	@Override
	public boolean departmentLeave(UserDepartmentVO _userDepartmentVO) {
		return dao.departmentLeave(_userDepartmentVO);
	}
}
