package com.sandol.app.dao;

import java.util.List;
import java.util.Map;

import com.sandol.app.vo.GroupMemberVO;
import com.sandol.app.vo.GroupVO;

public interface GroupDAO {
	
	public GroupVO groupAdd(GroupVO _groupVO);
	
	public List<GroupVO> getLoginUserGroupList(String _userId);
	
	public List<GroupVO> getGroupList(String _searchText);
	
	public GroupVO groupRegist(Map<String, String> _userData);
	
	public boolean groupManagerChange(Map<String, String> _changeUser);
	
	public boolean groupExit(GroupVO _group);
	
	public boolean groupDelete(GroupVO _group);
	
	public List<GroupMemberVO> getGroupMemberList(Map<String, Object> _searchText);
	
	public boolean groupManagerUpdate(Map<String, Object> _data);
}
