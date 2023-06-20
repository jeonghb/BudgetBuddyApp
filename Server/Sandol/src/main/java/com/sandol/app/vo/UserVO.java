package com.sandol.app.vo;

public class UserVO {
	private boolean registCheck;
	private String userId;
	private String userPassword;
	private String userName;
	private String userEmail;
	private String userPhoneNumber;
	private String userBirthday;
	private String userSex;
	private boolean logInIsSuccess;
	
	public boolean isRegistCheck() {
		return registCheck;
	}
	public void setRegistCheck(boolean registCheck) {
		this.registCheck = registCheck;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserPhoneNumber() {
		return userPhoneNumber;
	}
	public void setUserPhoneNumber(String userPhoneNumber) {
		this.userPhoneNumber = userPhoneNumber;
	}
	public String getUserBirthday() {
		return userBirthday;
	}
	public void setUserBirthday(String userBirthday) {
		this.userBirthday = userBirthday;
	}
	public String getUserSex() {
		return userSex;
	}
	public void setUserSex(String userSex) {
		this.userSex = userSex;
	}
	public boolean isLogInIsSuccess() {
		return logInIsSuccess;
	}
	public void setLogInIsSuccess(boolean logInIsSuccess) {
		this.logInIsSuccess = logInIsSuccess;
	}
	
	public void LogInUpdate(UserVO newVO) {
		setUserName(newVO.getUserName());
		setUserEmail(newVO.getUserEmail());
		setUserPhoneNumber(newVO.getUserPhoneNumber());
		setUserBirthday(newVO.getUserBirthday());
		setUserSex(newVO.getUserSex());
	}
}
