package com.githrd.jennie.controller.board;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.githrd.jennie.controller.*;

public class BoardList implements BlpInter {

	@Override
	public String exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String view = "/board/boardList";
		return view;
	}

}