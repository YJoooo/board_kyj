package com.topia.board.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.topia.board.entity.User;

public interface userServ {
	public List<User> getUserList(HashMap<String, Object> reqMap);
	public void userInsert(User user);
	public User userDetail(String userId);
	public void userUpdate(User user);
	public void userDelete(String userId);
	// 로그인 체크
	public User loginCheck(User user);
	// 아이디 중복검사
	public String checkId(String userId);
	// 비밀번호 변경
	public void userPassUpdate(User user);
	public int userListCnt(HashMap<String, Object> reqMap);

}
