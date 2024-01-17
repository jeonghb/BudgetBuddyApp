package com.sandol.app.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sandol.app.vo.UserDepartmentPositionVO;
import com.sandol.app.vo.UserVO;

@Repository
public class UserDAOImp implements UserDAO {
	
	@Autowired
	SqlSessionTemplate tmp;
	
	@Override
	public boolean getUserCheck(UserVO _userVO) {
		try {
			int count = tmp.selectOne("com.sandol.mapper.app.userCheck", _userVO);
			// 유저 데이터 조회 시 있으면 불가능 리턴
			if (count > 0) {
				return false;
			}
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public int getUserInfo(String _id) {
		try {
			return tmp.selectOne("com.sandol.mapper.app.selectUserInfo", _id);
		} catch (NullPointerException e) {
			return -1;
		}
	}
	
	@Override
	public boolean setUserRegist(UserVO _userVO) {
		try {
			tmp.insert("com.sandol.mapper.app.insertUserInfo", _userVO);
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}

	@Override
	public UserVO login(UserVO _userVO) {
		try {
			if (!_userVO.getIsAutoLogin()) {
				int failedCount = tmp.selectOne("com.sandol.mapper.app.getUserLoginFaliedLog", _userVO);
				
				if (failedCount >= 5) {
					_userVO.setLogInIsSuccess(false);
					_userVO.setLoginFailedMax(false);
					tmp.insert("com.sandol.mapper.app.loginLog", _userVO);
					return _userVO;
				}
				else {
					_userVO.setLoginFailedMax(true);
				}
			}
			else {
				_userVO.setLoginFailedMax(true);
			}
			
			int loginSuccess = tmp.selectOne("com.sandol.mapper.app.login", _userVO);
			
			if (loginSuccess == 0) {
				_userVO.setLogInIsSuccess(false);
				_userVO.setLoginFailedMax(true);
				tmp.insert("com.sandol.mapper.app.loginLog", _userVO);
				return _userVO;
			}
			
			UserVO newVO = tmp.selectOne("com.sandol.mapper.app.getLoginUserData", _userVO);
			
			if (newVO.getUserName() != null) {
				_userVO.setLogInIsSuccess(true);
				_userVO.LogInUpdate(newVO);
				tmp.insert("com.sandol.mapper.app.loginLog", _userVO);
			}
			else {
				_userVO.setLogInIsSuccess(false);
				_userVO.setLoginFailedMax(false);
				tmp.insert("com.sandol.mapper.app.loginLog", _userVO);
			}
		} catch (NullPointerException e) {
			return _userVO;
		}
		
		return _userVO;
	}
	
	@Override
	public boolean userPasswordFind(UserVO _userVO) {
		String result = "";
		
		try {
			result = tmp.selectOne("com.sandol.mapper.app.userPasswordFind", _userVO);
			
			if (result.equals("0")) {
				return false;
			}
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public boolean userPasswordUpdate(UserVO _userVO) {
		int result = 0;
		
		try {
			result = tmp.update("com.sandol.mapper.app.userPasswordUpdate", _userVO);
			
			if (result == 0) {
				return false;
			}
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public boolean userInfoUpdate(UserVO _userVO) {
		int result = 0;
		
		try {
			result = tmp.update("com.sandol.mapper.app.userInfoUpdate", _userVO);
			
			if (result == 0) {
				return false;
			}
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
	
	@Override
	public List<UserDepartmentPositionVO> getLoginUserDepartmentPositionList(Map<String, Object> _user) {
		try {
			return tmp.selectList("com.sandol.mapper.app.getLoginUserDepartmentPositionList", _user);
		} catch (NullPointerException e) {
			return null;
		}
	}
	
	@Override
	public boolean userWithdraw(Map<String, Object> _map) {
		try {
			int groupCount = tmp.selectOne("com.sandol.mapper.app.getUserGroupCount", _map);
			
			if (groupCount > 0) return false;
			
			if (tmp.update("com.sandol.mapper.app.userWithdraw", _map) == 0) return false;
		} catch (NullPointerException e) {
			return false;
		}
		
		return true;
	}
}
