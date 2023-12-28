package com.sandol.app.service;

import java.util.List;
import java.util.Map;

import com.sandol.app.vo.DepartmentMemberVO;
import com.sandol.app.vo.DepartmentRequestVO;
import com.sandol.app.vo.DepartmentVO;
import com.sandol.app.vo.UserDepartmentVO;

public interface DepartmentService {
	
	public List<DepartmentVO> getDepartmentList();
	
	public boolean departmentAdd(Map<String, Object> _department);
	
	public boolean departmentUpdate(DepartmentVO _departmentVO);
	
	public boolean departmentRequest(UserDepartmentVO _userDepartmentVO);
	
	public List<DepartmentVO> getRequestPositilityDepartmentList(String _userId);
	
	public List<DepartmentRequestVO> getDepartmentRequestList(String _userId);
	
	public boolean departmentRequestFinish(DepartmentRequestVO _departmentRequestVO);
	
	public List<DepartmentMemberVO> getDepartmentMemberList(String _userId);
	
	public boolean departmentLeave(UserDepartmentVO _userDepartmentVO);
}
