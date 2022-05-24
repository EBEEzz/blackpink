package com.githrd.jennie.controller.board;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.githrd.jennie.controller.*;
import com.githrd.jennie.dao.*;
import com.githrd.jennie.util.*;
import com.githrd.jennie.vo.*;

public class BoardList implements BlpInter {

	@Override
	public String exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String view = "/board/boardList";
		
		int nowPage = 1;
		String spage = req.getParameter("nowPage");
		if(spage != null) {
			nowPage = Integer.parseInt(spage);
		}
		
		BoardDao bDao = new BoardDao();
		int total = bDao.getTotalCount();
		
		PageUtil page = new PageUtil(nowPage, total);
		
		ArrayList<BoardVO> list = bDao.getBoardList(page);
		
		req.setAttribute("LIST", list);
		req.setAttribute("PAGE", page);
		
		return view;
	}

}