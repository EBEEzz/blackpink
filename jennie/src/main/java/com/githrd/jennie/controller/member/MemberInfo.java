package com.githrd.jennie.controller.member;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.githrd.jennie.controller.*;
import com.githrd.jennie.dao.*;
import com.githrd.jennie.vo.*;

public class MemberInfo implements BlpInter {

	@Override
	public String exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String view = "/member/memberInfo";
		String sno = req.getParameter("mno");
		int mno = Integer.parseInt(sno);
		
		// 데이터 조회하고
		MemberDao mDao = new MemberDao();
		MemberVO mVO = mDao.getMnoInfo(mno);
		
		// 데이터 심고
		req.setAttribute("DATA", mVO);
		
		return view;
	}

}