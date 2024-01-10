package com.sandol.app.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.PositionAuthVO;
import com.sandol.app.vo.PositionRequestVO;
import com.sandol.app.vo.PositionVO;
import com.sandol.app.vo.UserPositionVO;

@Repository
public class PositionDAOImp implements PositionDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	// 특정 유저가 신청 가능한 직책 List 조회
	@Override
	public List<PositionVO> getRequestPossibilityDepartmentPositionList(String _userId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getRequestPossibilityDepartmentPositionList", _userId);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	// 직책 신청
	@Override
	public boolean positionRequest(PositionRequestVO _positionRequestVO) {
		try {
			tmp.insert("com.sandol.mapper.app.positionRequest", _positionRequestVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	// 특정 유저가 소속된 부서들의 직책 신청 List
	@Override
	public List<PositionRequestVO> getPositionRequestList(Map<String, Object> _map) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getPositionRequestList", _map);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	// 직책 신청에 관한 내용을 반려, 승인 처리
	@Override
	public boolean positionRequestFinish(PositionRequestVO _positionRequestVO) {
		try {
			tmp.insert("com.sandol.mapper.app.positionRequestFinish", _positionRequestVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	// 직책 탈퇴
	@Override
	public boolean positionLeave(UserPositionVO _userPositionVO) {
		try {
			tmp.insert("com.sandol.mapper.app.positionLeave", _userPositionVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	// 직책 추가
	@Override
	public boolean positionAdd(PositionVO _positionVO) {
		try {
			// 직책 추가하고
			_positionVO.setPositionId(tmp.selectOne("com.sandol.mapper.app.positionAdd", _positionVO));
			if (_positionVO.getPositionId() < 0) return false;
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	// 직책 전체 List 조회
	@Override
	public List<PositionVO> getPositionList() {
		try {
			// 직책 목록 먼저 조회 하고
			List<PositionVO> positionList = tmp.selectList("com.sandol.mapper.app.getPositionList");
			
			// 각 직책별로
			for (PositionVO position : positionList) {
				position.setPositionAuthList( tmp.selectList("com.sandol.mapper.app.getPositionAuthList", position.getPositionId()));
			}
			
			return positionList;
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	// 직책 정보 업데이트
	@Override
	public boolean positionUpdate(PositionVO _positionVO) {
		try {
			// position 테이블 먼저 저장하고
			tmp.update("com.sandol.mapper.app.positionUpdate", _positionVO);
			
			for (PositionAuthVO positionAuthVO : _positionVO.getPositionAuthList()) {
				// position_auth 테이블 저장
				tmp.insert("com.sandol.mapper.app.positionAuthSave", positionAuthVO);
			}
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
}
