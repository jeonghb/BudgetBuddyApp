package com.sandol.app.dao;

import java.util.ArrayList;
import java.util.List;

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
	public List<PositionRequestVO> getPositionRequestList(String _userId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getPositionRequestList", _userId);
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
			tmp.insert("com.sandol.mapper.app.positionAdd", _positionVO);
			for (PositionAuthVO positionAuthVO : _positionVO.getPositionAuthList()) {
				// position_auth 테이블 저장
				tmp.insert("com.sandol.mapper.app.positionAuthSave", positionAuthVO);
			}
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
			// 직책별 권한 값을 가져오기 위해 전체 권한 List 조회
			List<PositionAuthVO> positionAuthList = tmp.selectList("com.sandol.mapper.app.getPositionAuthList");
			
			// 각 직책별로
			for (PositionVO position : positionList) {
				List<PositionAuthVO> tempList = new ArrayList<>();
				
				// 권한 List 중에 직책이 일치하면 직책별 권한 List에 추가
				for (PositionAuthVO positionAuth : positionAuthList) {
					if (positionAuth.getPositionId() == position.getPositionId()) {
						tempList.add(positionAuth);
					}
				}
				
				position.setPositionAuthList(tempList);
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
