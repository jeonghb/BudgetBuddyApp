package com.sandol.app.vo;

public class BudgetYearVO {
	private int departmentId;
	private String departmentName;
	private int year;
	private int budgetAmount;
	
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
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getBudgetAmount() {
		return budgetAmount;
	}
	public void setBudgetAmount(int budgetAmount) {
		this.budgetAmount = budgetAmount;
	}
}
