<%@include file="./model/Course.jsp" %>
<%@page import="java.sql.*, java.util.*" %>

<%
    Integer id = null;
    try {
        /*
         * The course id which will update from query string id
         */
        id = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {
        e.printStackTrace();
    }

    /*
     * Check the id is valid or not
     */
    if (id == null || id <= 0) {
        response.sendRedirect("./index.jsp");
        return;
    }

    /*
     * Get data from the database base on current id
     */
    Course course = new Course().find(id);
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Manage Course</title>
    <link rel="stylesheet" href="./css/app.css">
    <link rel="stylesheet" href="./css/style.css">
</head>
<body>
    <div class="container-fluid m-0 row p-3">
        <div class="col-md-4">
            <form class="border pt-2 mb-3" action="./controller/UpdateCourse.jsp" method="POST">
				<div class="container-fluid">
                    <!-- Hide the course id to this form so that know which course will be update -->
					<input type="hidden" name="id" value="<%= id %>">
                    
                    <div class="form-group">
                        <label class="font-weight-bold">Course Code</label>
                        <!-- Show current course code -->
                        <input type="text" name="course_code" class="form-control" value="<%= course.getCode()%>">
                    </div>
                    
                    <div class="form-group">
                        <label class="font-weight-bold">Course Name</label>
                        <!-- Show current course name -->
                        <input type="text" name="course_name" class="form-control" value="<%= course.getName()%>">
                    </div>

                    <div class="form-group">
                        <label class="font-weight-bold">Course Credit</label>
                        <!-- Show current course credit -->
                        <input type="number" name="course_credit" class="form-control" value="<%= course.getCredit()%>">
                    </div>
					
                    <div class="form-group">
						<button class="btn btn-primary form-control">Update Course</button>
					</div>
					<%
                        /**
						 * Show error message or success message when submiting a form
						 */
						String status = request.getParameter("status"),
							message = request.getParameter("message");
						if (status != null) {
					%>
						<div class="m-2 text-center text-<%= status %>">
							<strong><%= message %></strong>
						</div>
					<%
						}
					%>
				</div>
			</form>
        </div>
        <div class="col-md-8">
            <a href="./index.jsp">
                <button class="btn btn-info text-white">Return to Home Menu</button>
            </a>
        </div>
    </div>
</body>
</html>
