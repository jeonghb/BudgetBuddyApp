package com.sandol.app.vo;

public class UserDepartmentPositionVO {
	private int departmentId;
	private String departmentName;
	private int departmentActivationStatus;
	private int positionId;
	private String positionName;
	private int positionActivationStatus;
	
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
	public int getDepartmentActivationStatus() {
		return departmentActivationStatus;
	}
	public void setDepartmentActivationStatus(int departmentActivationStatus) {
		this.departmentActivationStatus = departmentActivationStatus;
	}
	public int getPositionId() {
		return positionId;
	}
	public void setPositionId(int positionId) {
		this.positionId = positionId;
	}
	public String getPositionName() {
		return positionName;
	}
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	public int getPositionActivationStatus() {
		return positionActivationStatus;
	}
	public void setPositionActivationStatus(int positionActivationStatus) {
		this.positionActivationStatus = positionActivationStatus;
	}
}
