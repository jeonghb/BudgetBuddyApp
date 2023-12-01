package com.sandol.app.dao;

import java.util.List;
import java.util.Map;

import com.sandol.app.vo.GroupVO;

public interface GroupDAO {
	
	public GroupVO groupAdd(GroupVO _groupVO);
	
	public List<GroupVO> getLoginUserGroupList(String _userId);
	
	public List<GroupVO> getGroupList(String _searchText);
	
	public boolean groupManagerChange(Map<String, String> _changeUser);
	
	public boolean groupExit(Map<String, String> _user);
}
