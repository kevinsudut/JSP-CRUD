<%@include file="../model/Course.jsp" %>
<%@page import="java.sql.*, java.util.*" %>

<%
    /*
     * Get all value from the input form
     */
    String code = request.getParameter("course_code").toUpperCase(),
        name = request.getParameter("course_name").toUpperCase();
    Integer credit = 0;
    try {
        credit = Integer.parseInt(request.getParameter("course_credit"));
    } catch (Exception e) {
        e.printStackTrace();
    }

    /*
     * Validate the input data already correct
     */
    if (code.isEmpty() || name.isEmpty() || credit <= 0) {
        response.sendRedirect("../index.jsp?status=danger&message=All Field Must be Filled");
        return;
    }

    /*
     * Create course object
     */
    Course course = new Course();
    
    /*
     * Check the input course code already exists on the database or not
     */
    if (course.exists("code", code) != null) {
        response.sendRedirect("../index.jsp?status=danger&message=Course Code Already Taken");
        return;    
    }
    
    /*
     * Set value from course object with input data
     */
    course.setCode(code);
    course.setName(name);
    course.setCredit(credit);

    /*
     * Insert data to the database
     */
    course.insert();

    response.sendRedirect("../index.jsp?status=success&message=Successfully Insert a New Course");
%>