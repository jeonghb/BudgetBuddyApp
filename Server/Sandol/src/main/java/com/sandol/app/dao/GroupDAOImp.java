package com.sandol.app.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.GroupVO;

@Repository
public class GroupDAOImp implements GroupDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public GroupVO groupAdd(GroupVO _groupVO) {
		try {
			GroupVO newGroupVO = new GroupVO();
			tmp.insert("com.sandol.mapper.app.groupAdd", _groupVO);
			
			newGroupVO = tmp.selectOne("com.sandol.mapper.app.getGroupByName", _groupVO);
			
			if (newGroupVO.getGroupId() > 0) {
				newGroupVO.setUserId(_groupVO.getUserId());
				newGroupVO.setGroupName(_groupVO.getGroupName());
				newGroupVO.setGroupIntroduceMemo(_groupVO.getGroupIntroduceMemo());
				newGroupVO.setGroupUserCount(1);
				
				if (tmp.insert("com.sandol.mapper.app.userGroupAdd", newGroupVO) == 0) {
					newGroupVO.setSuccess(false);
					
					return newGroupVO;
				}
				
				newGroupVO.setSuccess(true);
			}
			else {
				newGroupVO.setSuccess(false);
				return _groupVO;
			}
			
			return newGroupVO;
		} catch (NullPointerException e) {
			return null;
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
	public boolean groupManagerChange(Map<String, String> _changeUser) {
		try {
			tmp.update("com.sandol.mapper.app.groupManagerChange", _changeUser);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public boolean groupExit(Map<String, String> _user) {
		try {
			tmp.delete("com.sandol.mapper.app.groupExit", _user);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
}
