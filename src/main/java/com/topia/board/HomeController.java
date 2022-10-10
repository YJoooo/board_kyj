package com.topia.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.topia.board.entity.Board;
import com.topia.board.entity.Criteria;
import com.topia.board.entity.Paging;
import com.topia.board.service.boardServ;
import com.topia.board.util.util;

/**
 * Handles requests for the application home page.
 */
// http://localhost:8070/board_kyj/
@Controller
public class HomeController {
	@Autowired(required=false)
	private boardServ service;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/")
	public String getBoardList(Criteria cri, Model model,
			@RequestParam(required = false) String userListSearchPeriod, 
			@RequestParam(required = false) String userListSearchWord) {
		
		System.out.println("UserController.java || userList || userListSearchPeriod =======>>>>> " + userListSearchPeriod);
		System.out.println("UserController.java || userList || userListSearchWord =======>>>>> " + userListSearchWord);
        
		HashMap<String, Object> reqMap = new HashMap<String, Object>();
		reqMap.put("userListSearchPeriod", userListSearchPeriod);
		reqMap.put("userListSearchWord", userListSearchWord);
		reqMap.put("cri", cri);
		
		 // 전체 글 개수
        int boardListCnt = service.boardListCnt(reqMap);
        
        // 페이징 객체
        Paging paging = new Paging();
        paging.setCri(cri);
        paging.setTotalCount(boardListCnt);    

		
		model.addAttribute("userListSearchPeriod", userListSearchPeriod);
		model.addAttribute("userListSearchWord", userListSearchWord);

//		String content222 = "토피아";
//		reqMap.put("content", content222);
		
		List<Board> list = service.getBoardList(reqMap);
		
		model.addAttribute("boardList", list);      
        model.addAttribute("list", list);    
        model.addAttribute("paging", paging);  
		return "home";
	}
	// http://localhost:8070/board/goInsert
	
	@RequestMapping(value="/goInsert")
	public String goInsert() {
		return "insertPage";
	}
	
	@ResponseBody
	@RequestMapping(value="/boardInsert")
	public Map<String, Object> boardInsert(HttpServletRequest request,Board board) throws Exception {
		
		System.out.println("HomeController.java || boardInsert || board.getUserId()====> " + board.getUserId());
		System.out.println("HomeController.java || boardInsert || board.getUserName()====> " + board.getUserName());
        Map<String, Object> resultMap = new HashMap<String,Object>(); 
        
        try{
    		util getip = new util();
    		String ip = getip.getUserIp();
    	    board.setRegistIp(ip);
    	    service.boardInsert(board);           
        }catch(Exception e){
            resultMap.put("message",e.getMessage());
            return resultMap;
        }        
        resultMap.put("message", "게시물이 정상적으로 등록되었습니다");
        resultMap.put("success", "ok");
        
        return resultMap;
        
	}
	@RequestMapping(value="/boardDetail")
	public String boardDetail(int boardno, Model model) {
		model.addAttribute("board", service.boardDetail(boardno));
		return "boardDetail";
	}
	@RequestMapping(value="/goUpdate")
	public String goUpdate(int boardno,Model model) {
		model.addAttribute("board", service.boardDetail(boardno));
		return "boardUpdate";
	}
	@ResponseBody
	@RequestMapping(value="/boardUpdate")
	public Map<String, Object> boardUpdate(Board board) throws Exception {
		Map<String, Object> resultMap = new HashMap<String,Object>(); 
		
        try{
    		util getip = new util();
    		String ip = getip.getUserIp();
    		board.setUpdateIp(ip);
    		service.boardUpdate(board);
        }catch(Exception e){
            resultMap.put("message",e.getMessage());
            return resultMap;
        }        
        resultMap.put("message", "게시물이 정상적으로 수정되었습니다.");
        resultMap.put("success", "ok");
        
        return resultMap;
	}
	@ResponseBody
	@RequestMapping(value="/boardDelete")
	public Map<String,Object> boardDelete(int boardno) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		try {
			service.boardDelete(boardno);
		}catch(Exception e) {
            resultMap.put("message",e.getMessage());
            return resultMap;
		
			}
			resultMap.put("message", "게시물이 정상적으로 삭제되었습니다.");
			resultMap.put("success", "ok");
		return resultMap;
	}
	@ResponseBody
	@RequestMapping(value = "/deleteBoard")
    public Map<String,Object> ajaxTest(HttpServletRequest request) {
            
        String[] ajaxMsg = request.getParameterValues("valueArr");
        //System.out.println("HomeController.java || /deleteUser || ajaxMsg ==========>> " + ajaxMsg);
        
        Map<String,Object> resultMap = new HashMap<String,Object>();
        
        int size = ajaxMsg.length;
        int rtnCnt = 0;
        for(int i=0; i<size; i++) {
        	System.out.println(i + "번째..HomeController.java || /deleteUser || ajaxMsg ==========>> " + ajaxMsg[i]);
        	service.boardDelete(Integer.parseInt(ajaxMsg[i]));
        	rtnCnt++;
        }
        
        resultMap.put("rtnCnt", rtnCnt);
        
		return resultMap;
    }
	

}
