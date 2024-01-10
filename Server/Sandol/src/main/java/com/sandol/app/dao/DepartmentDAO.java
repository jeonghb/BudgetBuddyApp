package com.sandol.app.dao;

import java.util.List;
import java.util.Map;

import com.sandol.app.vo.DepartmentMemberVO;
import com.sandol.app.vo.DepartmentRequestVO;
import com.sandol.app.vo.DepartmentVO;
import com.sandol.app.vo.UserDepartmentVO;

public interface DepartmentDAO {
	
	public List<DepartmentVO> getDepartmentList(Map<String, Object> _map);
	
	public boolean departmentAdd(Map<String, Object> _department);
	
	public boolean departmentUpdate(DepartmentVO _departmentVO);
	
	public boolean departmentRequest(UserDepartmentVO _userDepartmentVO);
	
	public List<DepartmentVO> getRequestPositilityDepartmentList(String _userId);
	
	public List<DepartmentRequestVO> getDepartmentRequestList(Map<String, Object> _map);
	
	public boolean departmentRequestFinish(DepartmentRequestVO _departmentRequestVO);
	
	public List<DepartmentMemberVO> getDepartmentMemberList(Map<String, Object> _map);
	
	public boolean departmentLeave(UserDepartmentVO _userDepartmentVO);
}
