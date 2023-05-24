package com.sandol.app.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.DepartmentVO;

@Repository
public class DepartmentDAOImp implements DepartmentDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public List<DepartmentVO> getDepartmentList() {
		try {
			return tmp.selectList("com.sandol.mapper.app.getDepartmentList");
		}catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public boolean setDepartment(DepartmentVO departmentVO) {
		try {
			tmp.insert("com.sandol.mapper.app.insertDepartment", departmentVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
}
