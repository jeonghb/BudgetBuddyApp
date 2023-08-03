package com.sandol.app.vo;

public class PositionVO {
	private int departmentId;
	private String departmentName;
	private boolean departmentActivationStatus;
	private int positionId;
	private String positionName;
	private int authFlag;
	private boolean positionActivationStatus;
	
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
	public void setDepartmentActivationStatus(Boolean departmentActivationStatus) {
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
	public int getAuthFlag() {
		return authFlag;
	}
	public void setAuthFlag(int authFlag) {
		this.authFlag = authFlag;
	}
	public boolean isPositionActivationStatus() {
		return positionActivationStatus;
	}
	public void setPositionActivationStatus(boolean positionActivationStatus) {
		this.positionActivationStatus = positionActivationStatus;
	}
}
