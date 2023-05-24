package com.sandol.app.dao;

import java.util.List;

import com.sandol.app.vo.DepartmentVO;

public interface DepartmentDAO {
	
	public List<DepartmentVO> getDepartmentList();
	
	public boolean setDepartment(DepartmentVO departmentVO);
}
