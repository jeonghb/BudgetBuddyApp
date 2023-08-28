package com.sandol.app.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.DepartmentMemberVO;
import com.sandol.app.vo.DepartmentRequestVO;
import com.sandol.app.vo.DepartmentVO;
import com.sandol.app.vo.UserDepartmentVO;

@Repository
public class DepartmentDAOImp implements DepartmentDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public List<DepartmentVO> getDepartmentList() {
		try {
			return tmp.selectList("com.sandol.mapper.app.getDepartmentList");
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public boolean departmentAdd(DepartmentVO _departmentVO) {
		try {
			int rowCount = tmp.insert("com.sandol.mapper.app.departmentAdd", _departmentVO);
			
			if (rowCount > 0) {
				return true;
			}
			else {
				return false;
			}
		} catch (NullPointerException e) {
			return false;
		}
	}
	
	@Override
	public boolean departmentUpdate(DepartmentVO _departmentVO) {
		try {
			int rowCount = tmp.update("com.sandol.mapper.app.departmentUpdate", _departmentVO);
			
			if (rowCount > 0) {
				return true;
			} else {
				return false;
			}
		} catch (NullPointerException e) {
			return false;
		}
	}
	
	@Override
	public boolean departmentRequest(UserDepartmentVO _userDepartmentVO) {
		try {
			tmp.insert("com.sandol.mapper.app.departmentRequest", _userDepartmentVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public List<DepartmentVO> getRequestPositilityDepartmentList(String _userId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getRequestPositilityDepartmentList", _userId);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public List<DepartmentRequestVO> getDepartmentRequestList(String _userId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getDepartmentRequestList", _userId);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public boolean departmentRequestFinish(DepartmentRequestVO _departmentRequestVO) {
		int returnCount = 0;
		try {
			returnCount = tmp.insert("com.sandol.mapper.app.departmentRequestFinish", _departmentRequestVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		if (returnCount > 1) {
			return true;
		}
		else {
			return false;	
		}
	}
	
	@Override
	public List<DepartmentMemberVO> getDepartmentMemberList(String _userId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getDepartmentMemberList", _userId);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public boolean departmentLeave(UserDepartmentVO _userDepartmentVO) {
		int returnCount = 0;
		try {
			returnCount = tmp.insert("com.sandol.mapper.app.departmentLeave", _userDepartmentVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		if (returnCount > 0) {
			return true;
		}
		else {
			return false;
		}
	}
}
