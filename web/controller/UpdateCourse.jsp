<%@include file="../model/Course.jsp" %>
<%@page import="java.sql.*, java.util.*" %>

<%
    /*
     * Get all value from the input form
     */
    String code = request.getParameter("course_code").toUpperCase(),
        name = request.getParameter("course_name").toUpperCase();
    Integer id = 0,
        credit = 0;
    try {
        id = Integer.parseInt(request.getParameter("id"));
        credit = Integer.parseInt(request.getParameter("course_credit"));
    } catch (Exception e) {
        e.printStackTrace();
    }

    /*
     * Validate the id already corrent
     */
    if (id <= 0) {
        response.sendRedirect("../index.jsp");
        return;
    }

    /*
     * Validate the input data already correct
     */
    if (code.isEmpty() || name.isEmpty() || credit <= 0) {
        response.sendRedirect("../update.jsp?id=" + id + "&status=danger&message=All Field Must be Filled");
        return;
    }

    /*
     * Get data from the database base on current id
     */
    Course course = new Course().find(id);
    
    /*
     * Check the input course code already exists on the database or does not but if the course code from current id not change is allowed
     */
    if (course.exists("code", code) != null && course.exists("code", code).getId() != id) {
        response.sendRedirect("../update.jsp?id=" + id + "&status=danger&message=Course Code Already Taken");
        return;    
    }
    
    /*
     * Set a new value from course object with input data
     */
    course.setCode(code);
    course.setName(name);
    course.setCredit(credit);

    /*
     * Update data to the database
     */
    course.update();

    response.sendRedirect("../update.jsp?id=" + id + "&status=success&message=Successfully Update Course");
%>
