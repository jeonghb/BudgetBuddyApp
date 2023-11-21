package com.sandol.app.vo;

public class GroupVO {
	private String userId;
	private int groupId;
	private String groupName;
	private String groupIntroduceMemo;
	private int groupUserCount;
	private boolean groupMaster;
	private boolean groupStatus;
	private boolean isSuccess; // 프로시저 성공여부
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getGroupId() {
		return groupId;
	}
	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getGroupIntroduceMemo() {
		return groupIntroduceMemo;
	}
	public void setGroupIntroduceMemo(String groupIntroduceMemo) {
		this.groupIntroduceMemo = groupIntroduceMemo;
	}
	public int getGroupUserCount() {
		return groupUserCount;
	}
	public void setGroupUserCount(int groupUserCount) {
		this.groupUserCount = groupUserCount;
	}
	public boolean getGroupMaster() {
		return groupMaster;
	}
	public void setGroupMaster(boolean groupMaster) {
		this.groupMaster = groupMaster;
	}
	public boolean isGroupStatus() {
		return groupStatus;
	}
	public void setGroupStatus(boolean groupStatus) {
		this.groupStatus = groupStatus;
	}
	public boolean isSuccess() {
		return isSuccess;
	}
	public void setSuccess(boolean isSuccess) {
		this.isSuccess = isSuccess;
	}
}
