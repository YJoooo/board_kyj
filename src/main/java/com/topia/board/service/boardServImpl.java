package com.topia.board.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.topia.board.dao.boardDao;
import com.topia.board.entity.Board;

@Service
public class boardServImpl implements boardServ{
	@Autowired(required=false)
	private boardDao dao;
	
	@Override
	public List<Board> getBoardList(HashMap<String, Object> reqMap) {
		// TODO Auto-generated method stub
		return dao.getBoardList(reqMap);
	}
	@Override
	public void boardInsert(Board board) {
		dao.boardInsert(board);
	}
	@Override
	public Board boardDetail(int boardno) {
		return dao.boardDetail(boardno);
	}
	@Override
	public void boardUpdate(Board board) {
		dao.boardUpdate(board);
	}
	@Override
	public void boardDelete(int boardno) {
		dao.boardDelete(boardno);
	}
	
	@Override
	public int boardListCnt(HashMap<String, Object> reqMap) {
        return dao.boardListCnt(reqMap);
	}
 
}
