package com.topia.board.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.topia.board.entity.User;
@Repository
public class userDao {

	@Autowired
	private SqlSessionTemplate tpl;
	@Autowired
	SqlSession sqlSession;
	
	// 회원리스트 조회
	public List<User> getUserList(HashMap<String, Object> reqMap){
		return tpl.selectList("user.getUserList", reqMap);
	};
	
	// 회원 등록
	public void userInsert(User user){
		tpl.insert("user.userInsert", user);
	}
	
	// 회원정보 상세조회
	public User userDetail(String userId) {
		return tpl.selectOne("user.userDetail", userId);
	}
	
	// 회원정보 수정
	public void userUpdate(User user) {
		tpl.update("user.userUpdate", user);
	}
	
	// 회원정보 삭제
	public void userDelete(String userId) {
		tpl.delete("user.userDelete", userId);
	}
	
	// 로그인 체크
	public User loginCheck(User user) {
		
		return sqlSession.selectOne("user.loginCheck",user);
	}
	
	// 아이디 중복 체크
	public String checkId(String userId) {  // 유저가 입력한 값을 매개변수로 한다
		return sqlSession.selectOne("user.checkId",userId);
	}
	
	// 회원 비밀번호 수정
	public void userPassUpdate(User user) {
		tpl.update("user.userPassUpdate", user);
	}
	
	// 전체 회원수 조회
	public int userListCnt(HashMap<String, Object> reqMap) {
		return tpl.selectOne("user.userListCnt",reqMap);
	};


}
