<%@include file="./model/Course.jsp" %>
<%@page import="java.util.*" %> 
<%
	/**
	 * Get all course list from the database
	 */
	Vector<Course> courses = new Course().get();
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
			<form class="border pt-2 mb-3" action="./controller/InsertCourse.jsp" method="POST">
				<div class="container-fluid">
					
					<div class="form-group">
						<label class="font-weight-bold">Course Code</label>
						<input type="text" name="course_code" class="form-control">
					</div>

					<div class="form-group">
						<label class="font-weight-bold">Course Name</label>
						<input type="text" name="course_name" class="form-control">
					</div>
					
					<div class="form-group">
						<label class="font-weight-bold">Course Credit</label>
						<input type="number" name="course_credit" class="form-control">
					</div>
					
					<div class="form-group">
						<button class="btn btn-primary form-control">Insert New Course</button>
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
			<table class="table table-bordered text-center table-sm">
				<thead>
					<tr>
						<th>Course Code</th>
						<th>Course Name</th>
						<th>Course Credit</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
				<%
					/**
					 * Loop all course and show to the view page
					 */
					for (Course c : courses) {
				%>
					<tr>
						<!-- Show the course code -->
						<td width="20%"><%= c.getCode() %></td>

						<!-- Show the course name -->
						<td><%= c.getName() %></td>
						
						<!-- Show the course credit -->
						<td width="15%"><%= c.getCredit() %></td>
						
						<td class="col-action" width="18%">
							<form class="d-inline-block" action="./update.jsp">
								<!-- Hide the course id to this form so that know which course will be update -->
								<input type="hidden" name="id" value="<%= c.getId() %>">
								<button class="btn btn-sm btn-primary btn-action">Update</button>
							</form>
						
							<form class="d-inline-block" action="./controller/DeleteCourse.jsp" method="POST">
								<!-- Hide the course id to this form so that know which course will be delete -->
								<input type="hidden" name="id" value="<%= c.getId() %>">
								<button class="btn btn-sm btn-danger btn-action">Delete</button>
							</form>
						</td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
			<h4>
				<span class="p-2 badge badge-info text-white">Total Data: <%= courses.size() %>  Data(s)</span>
			</h4>
		</div>
	</div>
</body>
</html>
