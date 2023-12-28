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
	
	// Ư�� ������ ��û ������ ��å List ��ȸ
	@Override
	public List<PositionVO> getRequestPossibilityDepartmentPositionList(String _userId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getRequestPossibilityDepartmentPositionList", _userId);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	// ��å ��û
	@Override
	public boolean positionRequest(PositionRequestVO _positionRequestVO) {
		try {
			tmp.insert("com.sandol.mapper.app.positionRequest", _positionRequestVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	// Ư�� ������ �Ҽӵ� �μ����� ��å ��û List
	@Override
	public List<PositionRequestVO> getPositionRequestList(String _userId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getPositionRequestList", _userId);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	// ��å ��û�� ���� ������ �ݷ�, ���� ó��
	@Override
	public boolean positionRequestFinish(PositionRequestVO _positionRequestVO) {
		try {
			tmp.insert("com.sandol.mapper.app.positionRequestFinish", _positionRequestVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	// ��å Ż��
	@Override
	public boolean positionLeave(UserPositionVO _userPositionVO) {
		try {
			tmp.insert("com.sandol.mapper.app.positionLeave", _userPositionVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	// ��å �߰�
	@Override
	public boolean positionAdd(PositionVO _positionVO) {
		try {
			// ��å �߰��ϰ�
			tmp.insert("com.sandol.mapper.app.positionAdd", _positionVO);
			for (PositionAuthVO positionAuthVO : _positionVO.getPositionAuthList()) {
				// position_auth ���̺� ����
				tmp.insert("com.sandol.mapper.app.positionAuthSave", positionAuthVO);
			}
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	// ��å ��ü List ��ȸ
	@Override
	public List<PositionVO> getPositionList() {
		try {
			// ��å ��� ���� ��ȸ �ϰ�
			List<PositionVO> positionList = tmp.selectList("com.sandol.mapper.app.getPositionList");
			// ��å�� ���� ���� �������� ���� ��ü ���� List ��ȸ
			List<PositionAuthVO> positionAuthList = tmp.selectList("com.sandol.mapper.app.getPositionAuthList");
			
			// �� ��å����
			for (PositionVO position : positionList) {
				List<PositionAuthVO> tempList = new ArrayList<>();
				
				// ���� List �߿� ��å�� ��ġ�ϸ� ��å�� ���� List�� �߰�
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
	
	// ��å ���� ������Ʈ
	@Override
	public boolean positionUpdate(PositionVO _positionVO) {
		try {
			// position ���̺� ���� �����ϰ�
			tmp.update("com.sandol.mapper.app.positionUpdate", _positionVO);
			
			for (PositionAuthVO positionAuthVO : _positionVO.getPositionAuthList()) {
				// position_auth ���̺� ����
				tmp.insert("com.sandol.mapper.app.positionAuthSave", positionAuthVO);
			}
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
}
