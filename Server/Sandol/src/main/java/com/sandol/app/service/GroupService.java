package com.sandol.app.service;

import java.util.List;

import com.sandol.app.vo.GroupVO;

public interface GroupService {
	
	public GroupVO groupAdd(GroupVO _groupVO);
	
	public List<GroupVO> getLoginUserGroupList(String _userId);
	
	public List<GroupVO> getGroupList(String _searchText);
}
