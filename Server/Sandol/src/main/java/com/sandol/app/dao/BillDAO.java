package com.sandol.app.dao;

import java.util.List;

import com.sandol.app.vo.BillVO;

public interface BillDAO {
	
	public boolean requestBill(BillVO billVO);
}
