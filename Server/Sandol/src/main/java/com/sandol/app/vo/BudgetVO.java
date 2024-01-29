package com.sandol.app.vo;

public class BudgetVO {
	private int id;
	private int departmentId;
	private String departmentName;
	private int budgetTypeId;
	private String budgetTypeName;
	private String budgetTitle;
	private String budgetMemo;
	private String budgetDate;
	private int budgetAmount;
	private String userId;
	private String userName;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
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
	public void setBudgetTypeId(int budgetTypeId) {
		this.budgetTypeId = budgetTypeId;
	}
	public String getBudgetTypeName() {
		return budgetTypeName;
	}
	public void setBudgetTypeName(String budgetTypeName) {
		this.budgetTypeName = budgetTypeName;
	}
	public String getBudgetTitle() {
		return budgetTitle;
	}
	public void setBudgetTitle(String budgetTitle) {
		this.budgetTitle = budgetTitle;
	}
	public String getBudgetMemo() {
		return budgetMemo;
	}
	public void setBudgetMemo(String budgetMemo) {
		this.budgetMemo = budgetMemo;
	}
	public String getBudgetDate() {
		return budgetDate;
	}
	public void setBudgetDate(String budgetDate) {
		this.budgetDate = budgetDate;
	}
	public int getBudgetAmount() {
		return budgetAmount;
	}
	public void setBudgetAmount(int budgetAmount) {
		this.budgetAmount = budgetAmount;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
}
