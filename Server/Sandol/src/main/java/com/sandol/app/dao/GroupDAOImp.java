package com.sandol.app.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.GroupMemberVO;
import com.sandol.app.vo.GroupVO;

@Repository
public class GroupDAOImp implements GroupDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public GroupVO groupAdd(GroupVO _groupVO) {
		GroupVO newGroupVO = new GroupVO();
		try {
			newGroupVO.setGroupId(tmp.selectOne("com.sandol.mapper.app.getGroupByName", _groupVO.getGroupName()));
			
			if (newGroupVO.getGroupId() > 0) {
				newGroupVO.setSuccess(false);
				return _groupVO;
			}
			else {
				if (tmp.insert("com.sandol.mapper.app.groupAdd", _groupVO) == 0)
				{
					newGroupVO.setSuccess(false);
					return newGroupVO;
				}
				
				newGroupVO.setGroupId(tmp.selectOne("com.sandol.mapper.app.getGroupByName", _groupVO.getGroupName()));
				newGroupVO.setUserId(_groupVO.getUserId());
				newGroupVO.setGroupName(_groupVO.getGroupName());
				newGroupVO.setGroupIntroduceMemo(_groupVO.getGroupIntroduceMemo());
				newGroupVO.setGroupUserCount(1);
				
				if (tmp.insert("com.sandol.mapper.app.userGroupAdd", newGroupVO) == 0) {
					newGroupVO.setSuccess(false);
					return newGroupVO;
				}
				
				newGroupVO.setSuccess(true);
				return newGroupVO;
			}
		} catch (NullPointerException e) {
			newGroupVO.setSuccess(false);
			return newGroupVO;
		}
	}
	
	@Override
	public List<GroupVO> getLoginUserGroupList(String _userId) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getLoginUserGroupList", _userId);
		} catch (NullPointerException e) {
			return null;
		}
	}

	@Override
	public List<GroupVO> getGroupList(String _searchText) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getGroupList", _searchText);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public GroupVO groupRegist(Map<String, String> _userData) {
		try {
			if (tmp.insert("com.sandol.mapper.app.groupRegist", _userData) == 0) {
				return null;
			}
			
			return tmp.selectOne("com.sandol.mapper.app.getGroup", _userData);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public boolean groupManagerChange(Map<String, String> _changeUser) {
		try {
			tmp.update("com.sandol.mapper.app.groupManagerChange", _changeUser);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public boolean groupExit(GroupVO _group) {
		try {
			int isMaster = tmp.selectOne("com.sandol.mapper.app.groupMasterCheck", _group); 
			
			if (isMaster == 1) return false;
			
			tmp.delete("com.sandol.mapper.app.groupExit", _group);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public boolean groupDelete(GroupVO _group) {
		try {
			int isMaster = tmp.selectOne("com.sandol.mapper.app.groupMasterCheck", _group); 
			if (isMaster != 1) return false;
			
			tmp.delete("com.sandol.mapper.app.groupDelete", _group);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public List<GroupMemberVO> getGroupMemberList(Map<String, Object> _searchText) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getGroupMemberList", _searchText);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public boolean groupManagerUpdate(Map<String, Object> _data) {
		try {
			if (tmp.update("com.sandol.mapper.app.groupManagerUpdate", _data) != 2) return false;
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
}
