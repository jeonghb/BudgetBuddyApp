package com.sandol.app.vo;

public class PositionAuthVO {
	private int positionId;
	private String authId;
	private String authName;
	private boolean use;
	
	public int getPositionId() {
		return positionId;
	}
	public void setPositionId(int positionId) {
		this.positionId = positionId;
	}
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getAuthName() {
		return authName;
	}
	public void setAuthName(String authName) {
		this.authName = authName;
	}
	public boolean getUse() {
		return use;
	}
	public void setUse(boolean use) {
		this.use = use;
	}
}
