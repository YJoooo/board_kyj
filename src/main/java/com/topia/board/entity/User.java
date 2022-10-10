package com.topia.board.entity;

import java.sql.Date;

public class User {
	private Integer cnt;
	private String userId;
	private String userPass;
	private String userName;
	private String authority;
	private String email;
	private String telephone;
	private String gender;
	private String address;
	private Date userRegistDate;
	private Date userUpdateDate;
	private String UserRegistIp;
	private String UserUpdateIp;
	private String userListSearchPeriod;
	private String userListSearchWord;
	private String authorityUpdate;
	
	
	public String getAuthorityUpdate() {
		return authorityUpdate;
	}
	public void setAuthorityUpdate(String authorityUpdate) {
		this.authorityUpdate = authorityUpdate;
	}
	public String getUserListSearchPeriod() {
		return userListSearchPeriod;
	}
	public void setUserListSearchPeriod(String userListSearchPeriod) {
		this.userListSearchPeriod = userListSearchPeriod;
	}
	public String getUserListSearchWord() {
		return userListSearchWord;
	}
	public void setUserListSearchWord(String userListSearchWord) {
		this.userListSearchWord = userListSearchWord;
	}
	public Integer getCnt() {
		return cnt;
	}
	public void setCnt(Integer cnt) {
		this.cnt = cnt;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getUserRegistDate() {
		return userRegistDate;
	}
	public void setUserRegistDate(Date userRegistDate) {
		this.userRegistDate = userRegistDate;
	}
	public Date getUserUpdateDate() {
		return userUpdateDate;
	}
	public void setUserUpdateDate(Date userUpdateDate) {
		this.userUpdateDate = userUpdateDate;
	}
	public String getUserRegistIp() {
		return UserRegistIp;
	}
	public void setUserRegistIp(String userRegistIp) {
		UserRegistIp = userRegistIp;
	}
	public String getUserUpdateIp() {
		return UserUpdateIp;
	}
	public void setUserUpdateIp(String userUpdateIp) {
		UserUpdateIp = userUpdateIp;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPass() {
		return userPass;
	}
	public void setUserPass(String userPass) {
		this.userPass = userPass;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
}
