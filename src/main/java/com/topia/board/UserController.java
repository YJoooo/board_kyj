package com.topia.board;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.topia.board.entity.Criteria;
import com.topia.board.entity.Paging;
import com.topia.board.entity.User;
import com.topia.board.service.userServ;
import com.topia.board.util.util;

@SessionAttributes("login")
@Controller
public class UserController {
	@Autowired(required=false)
	private userServ service;
	
	// http://localhost:8070/board/userList
	@RequestMapping(value="/userList")
	public String userList(Criteria cri, Model model, 
			@RequestParam(required = false) String userListSearchPeriod, 
			@RequestParam(required = false) String userListSearchWord) {
		
		System.out.println("UserController.java || userList || userListSearchPeriod =======>>>>> " + userListSearchPeriod);
		System.out.println("UserController.java || userList || userListSearchWord =======>>>>> " + userListSearchWord);
		HashMap<String, Object> reqMap = new HashMap<String, Object>();
		
		reqMap.put("userListSearchPeriod", userListSearchPeriod);
		reqMap.put("userListSearchWord", userListSearchWord);
		reqMap.put("cri", cri);
		int userListCnt = service.userListCnt(reqMap);
		
        // 페이징 객체
        Paging paging = new Paging();
        paging.setCri(cri);
        paging.setTotalCount(userListCnt);  
        
		model.addAttribute("userListSearchPeriod", userListSearchPeriod);
		model.addAttribute("userListSearchWord", userListSearchWord);
		model.addAttribute("userList", service.getUserList(reqMap));
		model.addAttribute("paging", paging);
		return "userList";
	}
	@RequestMapping(value="/userInsertPage")
	public String userInsertPage() {
		return "userInsert";
	}
	@ResponseBody
	@RequestMapping(value="/userInsert")
	public Map<String, Object> userInsert(HttpServletRequest request,User user) throws Exception {
		
        Map<String, Object> resultMap = new HashMap<String,Object>(); 
        
        try{
    		util getip = new util();
    		String ip = getip.getUserIp();
    	    user.setUserRegistIp(ip);
    	    service.userInsert(user);           
        }catch(Exception e){
            resultMap.put("message",e.getMessage());
            return resultMap;
        }        
        resultMap.put("message", "회원 정보가 정상적으로 등록되었습니다");
        resultMap.put("success", "ok");
        return resultMap;
        
	}
	@RequestMapping(value="/userDetail")
	public String userDetail(String userId, Model model) {
		model.addAttribute("user", service.userDetail(userId));
		return "userDetail";
	}
	@RequestMapping(value="/userUpdatePage")
	public String userUpdatePage(String userId,Model model) {
		model.addAttribute("user", service.userDetail(userId));
		return "userUpdate";
	}
	@ResponseBody
	@RequestMapping(value="/userUpdate")
	public Map<String, Object> userUpdate(User user) throws Exception {
		Map<String, Object> resultMap = new HashMap<String,Object>(); 
		
        try{
    		util getip = new util();
    		String ip = getip.getUserIp();
    		user.setUserUpdateIp(ip);
    		service.userUpdate(user);
        }catch(Exception e){
            resultMap.put("message",e.getMessage());
            return resultMap;
        }        
        resultMap.put("message", "회원 정보가 정상적으로 수정되었습니다.");
        resultMap.put("success", "ok");
        
        return resultMap;
	}
	@ResponseBody
	@RequestMapping(value="/userDelete")
	public Map<String,Object> userDelete(String userId) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		try {
			service.userDelete(userId);
		}catch(Exception e) {
            resultMap.put("message",e.getMessage());
            return resultMap;
		
			}
			resultMap.put("message", "회원 정보가 정상적으로 삭제되었습니다.");
			resultMap.put("success", "ok");
		return resultMap;
	}
	// 로그인
	// http://localhost:8070/board/userLoginPage
	@RequestMapping(value="/userLoginPage")
	public String userLoginPage() {
		return "userLogin";
	}
	
	//로그인 처리
	@RequestMapping(value="/loginCheck")
	public ModelAndView loginCheck(@ModelAttribute User user,HttpSession session) {
		
		User user2 = service.loginCheck(user);
		ModelAndView mav = new ModelAndView();

		if(user2 != null) {
			session.setAttribute("MEMID", user2.getUserId());
			session.setAttribute("MEMAUTHORITY", user2.getAuthority());
			session.setAttribute("MEMNAME", user2.getUserName());
			mav.setViewName("redirect:/");
			mav.addObject("msg","성공");
		}else {
			mav.addObject("msg","실패");
			mav.setViewName("userLogin");
		}
		return mav;
	}
	//로그아웃 처리
	@RequestMapping(value="/logout")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		//service.logout(session);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/");
		mav.addObject("msg", "로그아웃");
		return mav;
	}
	@ResponseBody
	@RequestMapping(value="/checkId")
	public Map<String,Object> checkId(String userId) {
		Map<String,Object> resultMap = new HashMap<String,Object>();
		String result= service.checkId(userId);
		resultMap.put("result", result);
		return resultMap;
	}
	@ResponseBody
	@RequestMapping(value="/userPassUpdate")
	public Map<String, Object> userPassUpdate(User user) throws Exception {
		Map<String, Object> resultMap = new HashMap<String,Object>(); 
		
        try{
    		service.userPassUpdate(user);
        }catch(Exception e){
            resultMap.put("message",e.getMessage());
            return resultMap;
        }        
        resultMap.put("message", "비밀번호가 정상적으로 수정되었습니다.");
        
        return resultMap;
	}
	@ResponseBody
	@RequestMapping(value = "/deleteUser")
    public Map<String,Object> ajaxTest(HttpServletRequest request) {
            
        String[] ajaxMsg = request.getParameterValues("valueArr");
        //System.out.println("HomeController.java || /deleteUser || ajaxMsg ==========>> " + ajaxMsg);
        
        Map<String,Object> resultMap = new HashMap<String,Object>();
        
        int size = ajaxMsg.length;
        int rtnCnt = 0;
        for(int i=0; i<size; i++) {
        	System.out.println(i + "번째..UserController.java || /deleteUser || ajaxMsg ==========>> " + ajaxMsg[i]);
        	service.userDelete(ajaxMsg[i]);
        	rtnCnt++;
        }
        
        resultMap.put("rtnCnt", rtnCnt);
        
		return resultMap;
    }

	
}
