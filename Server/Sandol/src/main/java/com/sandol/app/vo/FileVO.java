package com.sandol.app.vo;

public class FileVO {
	private String relationKey;
	private int seq;
	private String fileName;
	private String filePath;
	
	public String getRelationKey() {
		return relationKey;
	}
	public void setRelationKey(String relationKey) {
		this.relationKey = relationKey;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public void setData(BillVO billVO, int _seq) {
//		setRelationKey(billVO.getRequestId());
//		setSeq(_seq);
//		setFileName(billVO.getFileList()[_seq].);
	}
}
