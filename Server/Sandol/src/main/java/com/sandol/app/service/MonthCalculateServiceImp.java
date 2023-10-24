package com.sandol.app.service;

import javax.inject.Inject;
import org.springframework.stereotype.Service;

import com.sandol.app.dao.MonthCalculateDAO;
import com.sandol.app.vo.MonthCalculateVO;

@Service
public class MonthCalculateServiceImp implements MonthCalculateService {
	
	@Inject
	MonthCalculateDAO dao;

	@Override
	public boolean getMonthCalculateStatus(MonthCalculateVO _monthCalculateVO) {
		return dao.getMonthCalculateStatus(_monthCalculateVO);
	}

	@Override
	public MonthCalculateVO getMonthCalculateData(MonthCalculateVO _monthCalculateVO) {
		return dao.getMonthCalculateData(_monthCalculateVO);
	}

	@Override
	public boolean monthCalculateAdd(MonthCalculateVO _monthCalculateVO) {
		return dao.monthCalculateAdd(_monthCalculateVO);
	}

	@Override
	public boolean monthCalculateUpdate(MonthCalculateVO _monthCalculateVO) {
		return dao.monthCalculateUpdate(_monthCalculateVO);
	}
}
