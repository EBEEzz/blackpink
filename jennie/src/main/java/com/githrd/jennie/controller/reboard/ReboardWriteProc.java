package com.githrd.jennie.controller.reboard;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.githrd.jennie.controller.*;
import com.githrd.jennie.dao.*;
import com.githrd.jennie.vo.*;

public class ReboardWriteProc implements BlpInter {

	@Override
	public String exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String view = "/whistle/reboard/reboardList.blp";
		req.setAttribute("isRedirect", true);
		
		//할일
		//로그인 체크
		String sid = (String) req.getSession().getAttribute("SID");
		if(sid == null) {
			view = "/whistle/member/login.blp";
			return view;
		}
		
		//파라미터 꺼내기
		String sno = req.getParameter("mno");
		String spage = req.getParameter("nowPage");
		String body = req.getParameter("body");
		
		BoardVO bVO = new BoardVO();
		bVO.setMno(Integer.parseInt(sno));
		bVO.setBody(body);
		
		//데이터베이스 작업
		ReboardDao rDao = new ReboardDao();
		int cnt = rDao.addReboard(bVO);
		
		//결과에 따라서 처리
		if(cnt == 0) {
//			view = "/whistle/reboard/reboardWrite.blp?nowPage=" + spage;	//GET
			
			//POST - forward처리
			req.setAttribute("isRedirect", false);
			req.setAttribute("VIEW", "/whistle/reboard/reboardWrite.blp");
			req.setAttribute("NOWPAGE", spage);
			return "/reboard/redirect";
		}
		
		return view;
	}

}