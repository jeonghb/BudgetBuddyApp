package com.sandol.app.service;

import java.util.List;

import com.sandol.app.vo.DepartmentVO;

public interface DepartmentService {
	
	public List<DepartmentVO> getDepartmentList();
	
	public boolean setDepartment(DepartmentVO departmentVO);
}
