package com.sandol.app.vo;

public class BudgetVO {
	private int id;
	private int departmentId;
	private int budgetTypeId;
	private String budgetTitle;
	private String budgetMemo;
	private String budgetDate;
	private int budgetAmount;
	
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
	public int getBudgetTypeId() {
		return budgetTypeId;
	}
	public void setBudgetTypeId(int budgetTypeId) {
		this.budgetTypeId = budgetTypeId;
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
}
