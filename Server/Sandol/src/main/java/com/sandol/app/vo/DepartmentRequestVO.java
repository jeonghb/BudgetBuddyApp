package com.sandol.app.vo;

public class DepartmentRequestVO {
	private String requestUserId;
	private String requestUserName;
	private String requestUserBirthday;
	private String requestUserSex;
	private int requestDepartmentId;
	private String requestDepartmentName;
	private String requestDatetime;
	private String approvalUserId;
	private String approvalUserName;
	private int approvalStatus;
	
	public String getRequestUserId() {
		return requestUserId;
	}
	public void setRequestUserId(String requestUserId) {
		this.requestUserId = requestUserId;
	}
	public String getRequestUserName() {
		return requestUserName;
	}
	public void setRequestUserName(String requestUserName) {
		this.requestUserName = requestUserName;
	}
	public String getRequestUserBirthday() {
		return requestUserBirthday;
	}
	public void setRequestUserBirthday(String requestUserBirthday) {
		this.requestUserBirthday = requestUserBirthday;
	}
	public String getRequestUserSex() {
		return requestUserSex;
	}
	public void setRequestUserSex(String requestUserSex) {
		this.requestUserSex = requestUserSex;
	}
	public int getRequestDepartmentId() {
		return requestDepartmentId;
	}
	public void setRequestDepartmentId(int requestDepartmentId) {
		this.requestDepartmentId = requestDepartmentId;
	}
	public String getRequestDepartmentName() {
		return requestDepartmentName;
	}
	public void setRequestDepartmentName(String requestDepartmentName) {
		this.requestDepartmentName = requestDepartmentName;
	}
	public String getRequestDatetime() {
		return requestDatetime;
	}
	public void setRequestDatetime(String requestDatetime) {
		this.requestDatetime = requestDatetime;
	}
	public String getApprovalUserId() {
		return approvalUserId;
	}
	public void setApprovalUserId(String approvalUserId) {
		this.approvalUserId = approvalUserId;
	}
	public String getApprovalUserName() {
		return approvalUserName;
	}
	public void setApprovalUserName(String approvalUserName) {
		this.approvalUserName = approvalUserName;
	}
	public int getApprovalStatus() {
		return approvalStatus;
	}
	public void setApprovalStatus(int approvalStatus) {
		this.approvalStatus = approvalStatus;
	}
}
