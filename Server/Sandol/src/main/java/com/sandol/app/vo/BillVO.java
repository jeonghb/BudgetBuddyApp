package com.sandol.app.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class BillVO {
	private int requestUserId;
	private int requestAmount;
	private Date paymentDatetime;
	private String memo;
	private int approvalRequestDepartmentId; 
	private List<MultipartFile> fileList;
	
	public int getRequestUserId() {
		return requestUserId;
	}
	public void setRequestUserId(int requestUserId) {
		this.requestUserId = requestUserId;
	}
	public int getRequestAmount() {
		return requestAmount;
	}
	public void setRequestAmount(int requestAmount) {
		this.requestAmount = requestAmount;
	}
	public Date getPaymentDatetime() {
		return paymentDatetime;
	}
	public void setPaymentDatetime(Date paymentDatetime) {
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
	public List<MultipartFile> getFileList() {
		return fileList;
	}
	public void setFileList(List<MultipartFile> fileList) {
		this.fileList = fileList;
	}
}
