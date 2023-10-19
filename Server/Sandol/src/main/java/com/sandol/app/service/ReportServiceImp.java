package com.sandol.app.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.ReportDAO;
import com.sandol.app.vo.ReportVO;

@Service
public class ReportServiceImp implements ReportService {
	
	@Inject
	ReportDAO dao;

	@Override
	public boolean reportAdd(ReportVO _reportVO) {
		return dao.reportAdd(_reportVO);
	}
}
