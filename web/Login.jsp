<%-- 
    Document   : Login
    Created on : 04/05/2018, 17:28:00
    Author     : Luan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String msg="";
   //logando direto
   
   if (request.getMethod().equals("POST")) 
   {
       if (request.getParameter("txtLogin").equals("admin") && request.getParameter("txtSenha").equals("123")) 
       {
           session.setAttribute("administrador", request.getParameter("txtLogin"));
           msg = "Login Realizado com Sucesso";
           //vai para a pagina inicial
           response.sendRedirect("home/");
           return;
       }
       else
       {
           msg = "Login/Senha incorretos";
       }
           
   }
 %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Livraria</title>
    </head>
    <body>
        <h3>Login</h3>
        <%=msg%>
        <form action="#" method="POST">
            <label>Login: </label>
            <input type="text" name="txtLogin"/>
            <br/>
            <label>Senha: </label>
            <input type="password" name="txtSenha"/>
            <br/>
            <button type="submit">OK</button>
        </form>
    </body>
</html>
