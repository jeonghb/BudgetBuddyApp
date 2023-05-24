package com.sandol.app.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.FileVO;

@Repository
public class FileDAOImp implements FileDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public boolean saveFile(FileVO fileVO) {
		try {
			
		}catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
}
