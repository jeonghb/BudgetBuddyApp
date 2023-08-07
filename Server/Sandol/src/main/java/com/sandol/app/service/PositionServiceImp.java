package com.sandol.app.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import com.sandol.app.dao.PositionDAO;
import com.sandol.app.vo.PositionRequestVO;
import com.sandol.app.vo.PositionVO;

@Service
public class PositionServiceImp implements PositionService {
	
	@Inject
	PositionDAO dao;
	
	@Override
	public List<PositionVO> getDepartmentPositionList(int departmentId) {
		return dao.getDepartmentPositionList(departmentId);
	}
	
	@Override
	public boolean positionRequest(PositionRequestVO _positionRequestVO) {
		return dao.positionRequest(_positionRequestVO);
	}
}
