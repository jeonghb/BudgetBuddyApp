package com.sandol.app.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ReceiptVO {
	private int requestId;
	private String requestUserId;
	private String title;
	private int requestAmount;
	private String paymentDatetime;
	private String memo;
	private int approvalRequestDepartmentId;
	private String approvalRequestDepartmentName;
	private List<MultipartFile> fileList;
	private String accountNumber;
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
	public String getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
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
}
