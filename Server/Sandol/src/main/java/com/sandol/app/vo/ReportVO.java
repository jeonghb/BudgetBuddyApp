package com.sandol.app.vo;

public class ReportVO {
	private int id;
	private int type;
	private int typeId;
	private String content;
	private String reportUserId;
	private String reportUserName;
	private String reportDatetime;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getTypeId() {
		return typeId;
	}
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReportUserId() {
		return reportUserId;
	}
	public void setReportUserId(String reportUserId) {
		this.reportUserId = reportUserId;
	}
	public String getReportUserName() {
		return reportUserName;
	}
	public void setReposrtUserName(String reportUserName) {
		this.reportUserName = reportUserName;
	}
	public String getReportDatetime() {
		return reportDatetime;
	}
	public void setReportDatetime(String reportDatetime) {
		this.reportDatetime = reportDatetime;
	}
}
