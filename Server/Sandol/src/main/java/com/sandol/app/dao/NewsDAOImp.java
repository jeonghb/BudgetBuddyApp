package com.sandol.app.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.NewsVO;

@Repository
public class NewsDAOImp implements NewsDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public boolean newsAdd(NewsVO _newsVO) {
		try {
			tmp.insert("com.sandol.mapper.app.newsAdd", _newsVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public boolean newsEdit(NewsVO _newsVO) {
		try {
			tmp.update("com.sandol.mapper.app.newsEdit", _newsVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public boolean newsDelete(NewsVO _newsVO) {
		try {
			tmp.update("com.sandol.mapper.app.newsDelete", _newsVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public NewsVO getNewsData(int _id) {
		return tmp.selectOne("com.sandol.mapper.app.getNewsData", _id);
	}
	
	@Override
	public List<NewsVO> getNewsTopList(List<Integer> _departmentIdList) {
		List<NewsVO> newsList = new ArrayList<NewsVO>();
		
		for (int departmentId : _departmentIdList) {
			newsList.addAll(tmp.selectList("com.sandol.mapper.app.getNewsTopList", departmentId));
		}
		
		Collections.sort(newsList, (a, b) -> b.getRegDatetime().compareTo(a.getRegDatetime()));
		
		return newsList.stream().limit(3).collect(Collectors.toList());
	}
}
