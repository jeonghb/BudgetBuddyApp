package com.sandol.app.dao;

import java.util.Map;

import com.sandol.app.vo.MonthCalculateVO;

public interface MonthCalculateDAO {
	
	public boolean getMonthCalculateStatus(MonthCalculateVO _monthCalculateVO);
	
	public MonthCalculateVO getMonthCalculateData(MonthCalculateVO _monthCalculateVO);
	
	public boolean monthCalculateAdd(MonthCalculateVO _monthCalculateVO);
	
	public boolean monthCalculateUpdate(Map<String, Object> _map);
}
