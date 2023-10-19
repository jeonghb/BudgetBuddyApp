package com.sandol.app.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sandol.app.service.NewsService;
import com.sandol.app.vo.NewsVO;

@Controller
public class NewsController {
	
	@Autowired
	NewsService newsService;
	
	@RequestMapping(value = "/newsAdd", method = RequestMethod.POST)
	@ResponseBody
	public boolean newsAdd(@RequestBody NewsVO _newsVO) {
		return newsService.newsAdd(_newsVO);
	}
	
	@RequestMapping(value = "/newsEdit", method = RequestMethod.POST)
	@ResponseBody
	public boolean newsEdit(@RequestBody NewsVO _newsVO) {
		return newsService.newsEdit(_newsVO);
	}
	
	@RequestMapping(value = "/newsDelete", method = RequestMethod.POST)
	@ResponseBody
	public boolean newsDelete(@RequestBody NewsVO _newsVO) {
		return newsService.newsDelete(_newsVO);
	}
	
	@RequestMapping(value = "/getNewsData", method = RequestMethod.POST)
	@ResponseBody
	public NewsVO getNewsData(@RequestBody Map<String, Integer> _id) {
		return newsService.getNewsData(_id.get("id"));
	}
	
	@RequestMapping(value = "/getNewsTopList", method = RequestMethod.POST)
	@ResponseBody
	public List<NewsVO> getNewsTopList(@RequestBody Map<String, List<Integer>> _departmentIdMap) {
		return newsService.getNewsTopList(_departmentIdMap.get("departmentIdList"));
	}
	
	@RequestMapping(value = "/getNewsList", method = RequestMethod.POST)
	@ResponseBody
	public List<NewsVO> getNewsList(@RequestBody Map<String, List<Integer>> _departmentIdMap) {
		return newsService.getNewsList(_departmentIdMap.get("departmentIdList"));
	}
}
