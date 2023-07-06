package com.sandol.app.dao;

import java.util.List;

import com.sandol.app.vo.DepartmentVO;
import com.sandol.app.vo.UserDepartmentVO;

public interface DepartmentDAO {
	
	public List<DepartmentVO> getDepartmentList();
	
	public boolean setDepartment(DepartmentVO departmentVO);
	
	public boolean departmentRequest(UserDepartmentVO userDepartmentVO);
}
