   <%@ page language="java" contentType="text/html; charset=UTF-8"
       pageEncoding="UTF-8"%>
   <%@ page import="my.model.*,my.dao.*,java.sql.*,java.util.*,my.util.*" %>    
   <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   <html>
   <head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   <title>Insert title here</title>
   </head>
   <body>
   <%
      request.setCharacterEncoding("utf-8");
      String memberId = request.getParameter("memberId");
      String password = request.getParameter("password");
      String name = request.getParameter("name");
      String phone_first = request.getParameter("phone_first");
      String phone_middle = request.getParameter("phone_middle");
      String phone_last = request.getParameter("phone_last");
      String phone = phone_first+"-"+phone_middle+"-"+phone_last;
      String sms = request.getParameter("sms");
      
      if(sms == null) {
         %>
         <script>
            alert("회원가입 정보를 입력해주세요.");
            history.go(-1); // 다시 로그인 창으로
         </script>
         <%
      }
      else{
         Connection conn = ConnectionProvider.getConnection();
         boolean check=true;
         try{
            MemberDao dao=new MemberDao();
            check=dao.checkMemberId(conn, memberId);
         } catch (Exception e) {}
         
         if(check) {
      %>
      <script>
         alert("중복된 아이디가 있습니다.");
         history.go(-1); // 다시 로그인 창으로
      </script>
      <%
         }
         else {
            Connection conn2 = ConnectionProvider.getConnection();
            try {
               MemberDao dao = new MemberDao(); 
               Member member = new Member(memberId, password, name, phone, sms , 0);
               dao.insert(conn2, member);
            } catch(SQLException e){}
            %>
            <script>
               alert("회원가입이 완료되었습니다.");
               location="main.jsp"
            </script>
            <%
         }
      }
      
   
   %>
   </body>
   </html>