package com.hgs.approve.service;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hgs.approve.model.ApproveDAO;
import com.hgs.user.model.UserVO;

public class AdminApproveConfirmService implements AService{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
HttpSession session = request.getSession();
		if(session.getAttribute("userInfo") == null) {
			try {
				session.invalidate();
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
				rd.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else {
			String a_no = request.getParameter("a_no");
			String a_status = request.getParameter("a_status");
			String a_reason = request.getParameter("a_reason");
			UserVO userInfo = (UserVO)session.getAttribute("userInfo");
			
			ApproveDAO dao = ApproveDAO.getInstance();
			dao.confirmApprove(a_no, a_status, a_reason, userInfo.getName());
			
		}
	}
}
