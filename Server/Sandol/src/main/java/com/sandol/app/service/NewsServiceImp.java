package com.sandol.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.NewsDAO;
import com.sandol.app.vo.NewsVO;

@Service
public class NewsServiceImp implements NewsService {
	
	@Inject
	NewsDAO dao;

	@Override
	public boolean newsAdd(NewsVO _newsVO) {
		return dao.newsAdd(_newsVO);
	}
	
	@Override
	public boolean newsEdit(NewsVO _newsVO) {
		return dao.newsEdit(_newsVO);
	}
	
	@Override
	public boolean newsDelete(NewsVO _newsVO) {
		return dao.newsDelete(_newsVO);
	}

	@Override
	public NewsVO getNewsData(int _id) {
		return dao.getNewsData(_id);
	}
	
	@Override
	public List<NewsVO> getNewsTopList(List<Integer> _departmentIdList) {
		return dao.getNewsTopList(_departmentIdList);
	}
	
	@Override
	public List<NewsVO> getNewsList(List<Integer> _departmentIdList) {
		return dao.getNewsList(_departmentIdList);
	}
}
