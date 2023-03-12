package com.sandol.app.vo;

public class UserRegistVO {
	private boolean registCheck;
	private String id;
	private String pw;
	private String name;
	private String email;
	private String phoneNumber;
	private String birthDay;
	private String sex;
	private boolean LogInIsSuccess;
	
	public boolean isRegistCheck() {
		return registCheck;
	}
	public void setRegistCheck(boolean registCheck) {
		this.registCheck = registCheck;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getBirthDay() {
		return birthDay;
	}
	public void setBirthDay(String birthDay) {
		this.birthDay = birthDay;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public boolean isLogInIsSuccess() {
		return LogInIsSuccess;
	}
	public void setLogInIsSuccess(boolean logInIsSuccess) {
		LogInIsSuccess = logInIsSuccess;
	}
	public void LogInUpdate(UserRegistVO newVO) {
		this.name = newVO.getName();
		this.email = newVO.getEmail();
		this.phoneNumber = newVO.getPhoneNumber();
		this.birthDay = newVO.getBirthDay();
		this.sex = newVO.getSex();
	}
}
