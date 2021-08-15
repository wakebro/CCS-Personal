package com.hgs;

import java.io.IOException;
//import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hgs.user.service.*;

@WebServlet("*.do")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doRequest(request, response);
	}

	protected void doRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		//PrintWriter out = response.getWriter();
		
		String uri = request.getRequestURI();
		System.out.println("URI 패턴 : " + uri);
		
		UService uService = null;
		String url = "";
		// 로그인
		if(uri.equals("/ccs/login_proc.do")) {
			uService = new LoginService();
			uService.execute(request, response);
			url = "main.jsp";
		} 
		// 회원가입 창
		else if (uri.equals("/ccs/join.do")) {
			uService = new JoinService();
			uService.execute(request, response);
			url = "join.jsp";
		}
		// 회원가입
		else if (uri.equals("/ccs/join_proc.do")) {
			uService = new JoinProcService();
			uService.execute(request, response);
			url = "login.jsp";
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}

}
