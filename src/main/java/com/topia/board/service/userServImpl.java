package com.topia.board.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.topia.board.dao.userDao;
import com.topia.board.entity.User;
@Service
public class userServImpl implements userServ{
	@Autowired(required=false)
	private userDao dao;
	
	@Override
	public List<User> getUserList(HashMap<String, Object> reqMap){
		return dao.getUserList(reqMap);
	}
	@Override
	public void userInsert(User user) {
		dao.userInsert(user);
	}
	@Override
	public User userDetail(String userId) {
		return dao.userDetail(userId);
	}
	@Override
	public void userUpdate(User user) {
		dao.userUpdate(user);
	}
	@Override
	public void userDelete(String userId) {
		dao.userDelete(userId);
	}
	@Override
	public User loginCheck(User user) {
		
		return dao.loginCheck(user);
	}
	@Override
	public String checkId(String userId) {
		return dao.checkId(userId);
	}
	@Override
	public void userPassUpdate(User user) {
		dao.userPassUpdate(user);
	}
	@Override
	public int userListCnt(HashMap<String, Object> reqMap) {
        return dao.userListCnt(reqMap);
	}


}
