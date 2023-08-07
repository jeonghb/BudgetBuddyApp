package com.sandol.app.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.PositionRequestVO;
import com.sandol.app.vo.PositionVO;

@Repository
public class PositionDAOImp implements PositionDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public List<PositionVO> getDepartmentPositionList(int departmentId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getDepartmentPositionList", departmentId);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public boolean positionRequest(PositionRequestVO _positionRequestVO) {
		try {
			tmp.insert("com.sandol.mapper.app.positionRequest", _positionRequestVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
}
