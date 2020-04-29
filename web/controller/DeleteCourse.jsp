<%@include file="../model/Course.jsp" %>
<%@page import="java.sql.*, java.util.*" %>

<%
    Integer id = 0;
    try {
        /*
         * Get course id that will delete
         */
        id = Integer.parseInt(request.getParameter("id"));
        
        /*
         * Delete the data from the database
         */
        new Course().delete(id);
    } catch (Exception e) {
        e.printStackTrace();
    }

    response.sendRedirect("../index.jsp");
%>
