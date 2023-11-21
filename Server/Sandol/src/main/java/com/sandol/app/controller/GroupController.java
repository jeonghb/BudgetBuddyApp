package com.sandol.app.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sandol.app.service.GroupService;
import com.sandol.app.vo.GroupVO;

@Controller
public class GroupController {
	
	@Autowired
	GroupService groupService;
	
	@RequestMapping(value = "/groupAdd", method = RequestMethod.POST)
	@ResponseBody
	public GroupVO groupAdd(@RequestBody GroupVO _groupVO) {
		return groupService.groupAdd(_groupVO);
	}
	
	@RequestMapping(value = "/getLoginUserGroupList", method = RequestMethod.POST)
	@ResponseBody
	public List<GroupVO> getLoginUserGroupList(@RequestBody Map<String, String> _userId) {
		return groupService.getLoginUserGroupList(_userId.get("userId"));
	}
	
	@RequestMapping(value = "/getGroupList", method = RequestMethod.POST)
	@ResponseBody
	public List<GroupVO> getGroupList(@RequestBody Map<String, String> _searchText) {
		return groupService.getGroupList(_searchText.get("searchText"));
	}
	
}
