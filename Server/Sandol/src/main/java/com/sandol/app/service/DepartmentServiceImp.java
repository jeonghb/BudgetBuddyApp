package com.sandol.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.DepartmentDAO;
import com.sandol.app.vo.DepartmentVO;

@Service
public class DepartmentServiceImp implements DepartmentService {
	
	@Inject
	DepartmentDAO dao;

	@Override
	public List<DepartmentVO> getDepartmentList() {
		return dao.getDepartmentList();
	}

	@Override
	public boolean setDepartment(DepartmentVO departmentVO) {
		return dao.setDepartment(departmentVO);
	}
}
