package com.sandol.app.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.sandol.app.vo.MonthCalculateVO;

@Repository
public class MonthCalculateDAOImp implements MonthCalculateDAO {
	
	@Autowired
	SqlSessionTemplate tmp;

	@Override
	public boolean getMonthCalculateStatus(MonthCalculateVO _monthCalculateVO) {
		try {
			int count = tmp.selectOne("com.sandol.mapper.app.getMonthCalculateStatus", _monthCalculateVO);
			return count == 0 ? false : true;
		} catch (NullPointerException e) {
			return false;
		}
	}

	@Override
	public MonthCalculateVO getMonthCalculateData(MonthCalculateVO _monthCalculateVO) {
		try {
			MonthCalculateVO newVO = new MonthCalculateVO();
			newVO = tmp.selectOne("com.sandol.mapper.app.getMonthCalculateData", _monthCalculateVO);
			
			if (newVO == null) {
				_monthCalculateVO.setIsSuccess(false);
				return _monthCalculateVO;
			}
			
			_monthCalculateVO = newVO;
					
			// 조회 연도 예산 조회 프로시저 호출
			_monthCalculateVO.setYearBudgetAmount(tmp.selectOne("com.sandol.mapper.app.getBudgetYearAmount", _monthCalculateVO));
			// 조회 연도 누적 사용금액 프로시저 호출
			_monthCalculateVO.setYearAccumulateAmount(tmp.selectOne("com.sandol.mapper.app.getYearAccumulateAmount", _monthCalculateVO));
			// 조회 월 추가된 예산 총 금액
			_monthCalculateVO.setMonthBudgetAmount(tmp.selectOne("com.sandol.mapper.app.getMonthBudgetAmount", _monthCalculateVO));
			// 조회 월 결재된 영수증 전체 사용금액 조회
			_monthCalculateVO.setMonthReceiptAmount(tmp.selectOne("com.sandol.mapper.app.getMonthReceiptAmount", _monthCalculateVO));
			
			_monthCalculateVO.setIsSuccess(true);
		} catch (NullPointerException e) {
			_monthCalculateVO.setIsSuccess(false);
			return _monthCalculateVO;
		}
		
		return _monthCalculateVO;
	}

	@Override
	public boolean monthCalculateAdd(MonthCalculateVO _monthCalculateVO) {
		try {
			tmp.insert("com.sandol.mapper.app.monthCalculateAdd", _monthCalculateVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}

	@Override
	public boolean monthCalculateUpdate(MonthCalculateVO _monthCalculateVO) {
		try {
			tmp.insert("com.sandol.mapper.app.monthCalculateUpdate", _monthCalculateVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
}
