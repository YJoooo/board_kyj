package com.topia.board.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.topia.board.entity.Board;

@Repository
public class boardDao {
	
	@Autowired
	private SqlSessionTemplate tpl;
	
	// 게시판 조회
	public List<Board> getBoardList(HashMap<String, Object> reqMap){
		return tpl.selectList("board.getBoardList", reqMap);
	};
	
	// 게시글 등록
	public void boardInsert(Board board){
		tpl.insert("board.boardInsert", board);
	}
	
	// 게시글 상세조회
	public Board boardDetail(int boardno) {
		return tpl.selectOne("board.boardDetail", boardno);
	}
	
	// 게시글 수정
	public void boardUpdate(Board board) {
		tpl.update("board.boardUpdate", board);
	}
	
	// 게시글 삭제
	public void boardDelete(int boardno) {
		tpl.delete("board.boardDelete", boardno);
	}
	
	// 전체 게시글수 조회
	public int boardListCnt(HashMap<String, Object> reqMap) {
		return tpl.selectOne("board.boardListCnt", reqMap);
	};


}
