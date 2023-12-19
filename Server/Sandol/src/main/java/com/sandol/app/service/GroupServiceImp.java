package com.sandol.app.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.GroupDAO;
import com.sandol.app.vo.GroupMemberVO;
import com.sandol.app.vo.GroupVO;

@Service
public class GroupServiceImp implements GroupService {
	
	@Inject
	GroupDAO dao;

	@Override
	public GroupVO groupAdd(GroupVO _groupVO) {
		return dao.groupAdd(_groupVO);
	}
	
	@Override
	public List<GroupVO> getLoginUserGroupList(String _userId) {
		return dao.getLoginUserGroupList(_userId);
	}

	@Override
	public List<GroupVO> getGroupList(String _searchText) {
		return dao.getGroupList(_searchText);
	}
	
	@Override
	public GroupVO groupRegist(Map<String, String> _userData) {
		return dao.groupRegist(_userData);
	}
	
	@Override
	public boolean groupManagerChange(Map<String, String> _changeUser) {
		return dao.groupManagerChange(_changeUser);
	}
	
	@Override
	public boolean groupExit(GroupVO _group) {
		return dao.groupExit(_group);
	}
	
	@Override
	public boolean groupDelete(GroupVO _group) {
		return dao.groupDelete(_group);
	}
	
	@Override
	public List<GroupMemberVO> getGroupMemberList(Map<String, Object> _searchText) {
		return dao.getGroupMemberList(_searchText);
	}
	
	@Override
	public boolean groupManagerUpdate(Map<String, Object> _data) {
		return dao.groupManagerUpdate(_data);
	}
}
