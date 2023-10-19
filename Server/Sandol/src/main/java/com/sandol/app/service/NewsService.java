package com.sandol.app.service;

import java.util.List;

import com.sandol.app.vo.NewsVO;

public interface NewsService {
	
	public boolean newsAdd(NewsVO _newsVO);
	
	public boolean newsEdit(NewsVO _newsVO);
	
	public boolean newsDelete(NewsVO _newsVO);
	
	public NewsVO getNewsData(int _id);
	
	public List<NewsVO> getNewsTopList(List<Integer> _departmentIdList);
	
	public List<NewsVO> getNewsList(List<Integer> _departmentIdList);
}
