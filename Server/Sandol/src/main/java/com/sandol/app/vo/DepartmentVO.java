package com.sandol.app.vo;

public class DepartmentVO {
	private int departmentId;
	private String departmentName;
	private boolean departmentActivationStatus;
	
	public int getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public boolean isDepartmentActivationStatus() {
		return departmentActivationStatus;
	}
	public void setDepartmentActivationStatus(boolean departmentActivationStatus) {
		this.departmentActivationStatus = departmentActivationStatus;
	}
}
