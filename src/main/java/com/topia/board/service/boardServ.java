package com.topia.board.service;


import java.util.HashMap;
import java.util.List;

import com.topia.board.entity.Board;

public interface boardServ {
	public List<Board> getBoardList(HashMap<String, Object> reqMap);
	public void boardInsert(Board board);
	public Board boardDetail(int boardno);
	public void boardUpdate(Board board);
	public void boardDelete(int boardno);
	public int boardListCnt(HashMap<String, Object> reqMap);
}
