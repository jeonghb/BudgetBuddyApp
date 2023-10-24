package com.sandol.app.dao;

import com.sandol.app.vo.MonthCalculateVO;

public interface MonthCalculateDAO {
	
	public boolean getMonthCalculateStatus(MonthCalculateVO _monthCalculateVO);
	
	public MonthCalculateVO getMonthCalculateData(MonthCalculateVO _monthCalculateVO);
	
	public boolean monthCalculateAdd(MonthCalculateVO _monthCalculateVO);
	
	public boolean monthCalculateUpdate(MonthCalculateVO _monthCalculateVO);
}
