package com.sandol.app.vo;

import java.util.List;

public class MonthCalculateVO {
	private int departmentId;
	private String departmentName;
	private String yearMonth;
	private int yearBudgetAmount;
	private int yearAccumulateAmount;
	private int monthBudgetAmount;
	private int monthReceiptAmount;
	private String regUserId;
	private String regUserName;
	private String modUserId;
	private String modUserName;
	private boolean isDBData;
	private boolean isSuccess;
	private List<ReceiptVO> receiptList;
	private List<BudgetVO> budgetList;
	
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
	public int getMonthBudgetAmount() {
		return monthBudgetAmount;
	}
	public void setMonthBudgetAmount(int monthBudgetAmount) {
		this.monthBudgetAmount = monthBudgetAmount;
	}
	public int getMonthReceiptAmount() {
		return monthReceiptAmount;
	}
	public void setMonthReceiptAmount(int monthReceiptAmount) {
		this.monthReceiptAmount = monthReceiptAmount;
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
	public boolean getIsSuccess() {
		return isSuccess;
	}
	public void setIsSuccess(boolean isSuccess) {
		this.isSuccess = isSuccess;
	}
	public List<ReceiptVO> getReceiptList() {
		return receiptList;
	}
	public void setReceiptList(List<ReceiptVO> receiptList) {
		this.receiptList = receiptList;
	}
	public List<BudgetVO> getBudgetList() {
		return budgetList;
	}
	public void setBudgetList(List<BudgetVO> budgetList) {
		this.budgetList = budgetList;
	}
}
