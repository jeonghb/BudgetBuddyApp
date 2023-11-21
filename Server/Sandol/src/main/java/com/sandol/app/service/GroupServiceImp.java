package com.sandol.app.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.GroupDAO;
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
}
