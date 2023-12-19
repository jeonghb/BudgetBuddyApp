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
import com.sandol.app.vo.GroupMemberVO;
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
	
	@RequestMapping(value = "/groupRegist", method = RequestMethod.POST)
	@ResponseBody
	public GroupVO groupRegist(@RequestBody Map<String, String> _userData) {
		return groupService.groupRegist(_userData);
	}
	
	@RequestMapping(value = "/groupManagerChange", method = RequestMethod.POST)
	@ResponseBody
	public boolean groupManagerChange(@RequestBody Map<String, String> _changeUser) {
		return groupService.groupManagerChange(_changeUser);
	}
	
	@RequestMapping(value = "/groupExit", method = RequestMethod.POST)
	@ResponseBody
	public boolean groupExit(@RequestBody GroupVO _group) {
		return groupService.groupExit(_group);
	}
	
	@RequestMapping(value = "/groupDelete", method = RequestMethod.POST)
	@ResponseBody
	public boolean groupDelete(@RequestBody GroupVO _group) {
		return groupService.groupDelete(_group);
	}
	
	@RequestMapping(value = "/getGroupMemberList", method = RequestMethod.POST)
	@ResponseBody
	public List<GroupMemberVO> getGroupMemberList(@RequestBody Map<String, Object> _searchText) {
		return groupService.getGroupMemberList(_searchText);
	}
	
	@RequestMapping(value = "/groupManagerUpdate", method = RequestMethod.POST)
	@ResponseBody
	public boolean groupManagerUpdate(@RequestBody Map<String, Object> _data) {
		return groupService.groupManagerUpdate(_data);
	}
}
