package com.sandol.app.vo;

public class MonthCalculateVO {
	private int departmentId;
	private String yearMonth;
	private int yearBudgetAmount;
	private int yearAccumulateAmount;
	private int monthAmount;
	private String regUserId;
	private String regUserName;
	private String modUserId;
	private String modUserName;
	private boolean isDBData;
	
	public int getDepartmentId() {
		return departmentId;
	}
	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}
	public String getYearMonth() {
		return yearMonth;
	}
	public void setYearMonth(String yearMonth) {
		this.yearMonth = yearMonth;
	}
	public int getYearBudgetAmount() {
		return yearBudgetAmount;
	}
	public void setYearBudgetAmount(int yearBudgetAmount) {
		this.yearBudgetAmount = yearBudgetAmount;
	}
	public int getYearAccumulateAmount() {
		return yearAccumulateAmount;
	}
	public void setYearAccumulateAmount(int yearAccumulateAmount) {
		this.yearAccumulateAmount = yearAccumulateAmount;
	}
	public int getMonthAmount() {
		return monthAmount;
	}
	public void setMonthAmount(int monthAmount) {
		this.monthAmount = monthAmount;
	}
	public String getRegUserId() {
		return regUserId;
	}
	public void setRegUserId(String regUserId) {
		this.regUserId = regUserId;
	}
	public String getRegUserName() {
		return regUserName;
	}
	public void setRegUserName(String regUserName) {
		this.regUserName = regUserName;
	}
	public String getModUserId() {
		return modUserId;
	}
	public void setModUserId(String modUserId) {
		this.modUserId = modUserId;
	}
	public String getModUserName() {
		return modUserName;
	}
	public void setModUserName(String modUserName) {
		this.modUserName = modUserName;
	}
	public boolean isDBData() {
		return isDBData;
	}
	public void setDBData(boolean isDBData) {
		this.isDBData = isDBData;
	}
}
