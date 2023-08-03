package com.sandol.app.service;

import java.util.List;

import com.sandol.app.vo.DepartmentMemberVO;
import com.sandol.app.vo.DepartmentRequestVO;
import com.sandol.app.vo.DepartmentVO;
import com.sandol.app.vo.UserDepartmentVO;

public interface DepartmentService {
	
	public List<DepartmentVO> getDepartmentList();
	
	public boolean setDepartment(DepartmentVO departmentVO);
	
	public boolean departmentRequest(UserDepartmentVO userDepartmentVO);
	
	public List<DepartmentVO> getRequestPositilityDepartmentList(String _userId);
	
	public List<DepartmentRequestVO> getDepartmentRequestList(String _userId);
	
	public boolean departmentRequestFinish(DepartmentRequestVO departmentRequestVO);
	
	public List<DepartmentMemberVO> getDepartmentMemberList(String _userId);
	
	public boolean departmentLeave(UserDepartmentVO userDepartmentVO);
}
