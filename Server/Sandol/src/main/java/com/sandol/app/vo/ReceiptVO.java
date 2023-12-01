package com.sandol.app.vo;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public class ReceiptVO {
	private int requestId;
	private String requestUserId;
	private String requestUserName;
	private String title;
	private int requestAmount;
	private String paymentDatetime;
	private String memo;
	private int approvalRequestDepartmentId;
	private String approvalRequestDepartmentName;
	private int budgetTypeId;
	private String budgetTypeName;
	private List<MultipartFile> fileList;
	private String bankName;
	private String bankAccountNumber;
	private int submissionStatus;
	private String rejectMessage;

	public int getRequestId() {
		return requestId;
	}
	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getRequestAmount() {
		return requestAmount;
	}
	public void setRequestAmount(int requestAmount) {
		this.requestAmount = requestAmount;
	}
	public String getPaymentDatetime() {
		return paymentDatetime;
	}
	public void setPaymentDatetime(String paymentDatetime) {
		this.paymentDatetime = paymentDatetime;
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
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public int getApprovalRequestDepartmentId() {
		return approvalRequestDepartmentId;
	}
	public void setApprovalRequestDepartmentId(int approvalRequestDepartmentId) {
		this.approvalRequestDepartmentId = approvalRequestDepartmentId;
	}
	public String getApprovalRequestDepartmentName() {
		return approvalRequestDepartmentName;
	}
	public void setApprovalRequestDepartmentName(String approvalRequestDepartmentName) {
		this.approvalRequestDepartmentName = approvalRequestDepartmentName;
	}
	public List<MultipartFile> getFileList() {
		return fileList;
	}
	public void setFileList(List<MultipartFile> fileList) {
		this.fileList = fileList;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankAccountNumber() {
		return bankAccountNumber;
	}
	public void setBankAccountNumber(String bankAccountNumber) {
		this.bankAccountNumber = bankAccountNumber;
	}
	public int getSubmissionStatus() {
		return submissionStatus;
	}
	public void setSubmissionStatus(int submissionStatus) {
		this.submissionStatus = submissionStatus;
	}
	public String getRejectMessage() {
		return rejectMessage;
	}
	public void setRejectMessage(String rejectMessage) {
		this.rejectMessage = rejectMessage;
	}
	
	public void setData(Map<String, Object> dataMap) {
		this.requestId = dataMap.containsKey("requestId") ? (int)(dataMap.get("requestId")) : 0;
		this.requestUserId = dataMap.containsKey("requestUserId") ? dataMap.get("requestUserId").toString() : "";
		this.requestUserName = dataMap.containsKey("requestUserName") ? dataMap.get("requestUserName").toString() : "";
		this.title = dataMap.containsKey("title") ? dataMap.get("title").toString() : "";
		this.requestAmount = dataMap.containsKey("requestAmount") ? (int)dataMap.get("requestAmount") : 0;
		this.paymentDatetime = dataMap.containsKey("paymentDatetime") ? dataMap.get("paymentDatetime").toString() : "";
		this.memo = dataMap.containsKey("memo") ? dataMap.get("memo").toString() : "";
		this.approvalRequestDepartmentId = dataMap.containsKey("approvalRequestDepartmentId") ? (int)(dataMap.get("approvalRequestDepartmentId")) : 0;
		this.approvalRequestDepartmentName = dataMap.containsKey("approvalRequestDepartmentName") ? dataMap.get("approvalRequestDepartmentName").toString() : "";
		this.budgetTypeId = dataMap.containsKey("budgetTypeId") ? (int)(dataMap.get("budgetTypeId")) : 0;
		this.budgetTypeName = dataMap.containsKey("budgetTypeName") ? dataMap.get("budgetTypeName").toString() : "";
		this.bankName = dataMap.containsKey("bankName") ? dataMap.get("bankName").toString() : "";
		this.bankAccountNumber = dataMap.containsKey("bankAccountNumber") ? dataMap.get("bankAccountNumber").toString() : "";
		this.submissionStatus = dataMap.containsKey("submissionStatus") ? (int)(dataMap.get("submissionStatus")) : 0;
	}
}
