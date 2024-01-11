package com.sandol.app.vo;

public class BudgetTypeVO {
	private int departmentId;
	private String departmentName;
	private int budgetTypeId;
	private String budgetTypeName;
	private boolean activationStatus;
	
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
	public int getBudgetTypeId() {
		return budgetTypeId;
	}
	public void setBudgetId(int budgetTypeId) {
		this.budgetTypeId = budgetTypeId;
	}
	public String getBudgetTypeName() {
		return budgetTypeName;
	}
	public void setBudgetTypeName(String budgetTypeName) {
		this.budgetTypeName = budgetTypeName;
	}
	public boolean getActivationStatus() {
		return activationStatus;
	}
	public void setActivationStatus(boolean activationStatus) {
		this.activationStatus = activationStatus;
	}
}
