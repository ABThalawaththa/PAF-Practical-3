<%@page import="com.Item"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<link rel="stylesheet" href="views/bootstrap.min.css">

<%
	//update
if (request.getParameter("update_itemID") != null) {
	Item itemObj = new Item();
	session.setAttribute("is_in_update_mode", request.getParameter("update_itemID"));
}

//setting data
String itemCode;
String itemName;
String itemPrice;
String itemDesc;
if (String.valueOf(session.getAttribute("is_in_update_mode")) == ""
		|| session.getAttribute("is_in_update_mode") == null) {
	itemCode = "";
	itemName = "";
	itemPrice = "";
	itemDesc = "";
} else {
	Item itemObj = new Item();
	System.out.println(session.getAttribute("is_in_update_mode"));
	String temp[] = itemObj
	.readSingleItems(Integer.parseInt(String.valueOf(session.getAttribute("is_in_update_mode"))));
	itemCode = temp[0];
	itemName = temp[1];
	itemPrice = temp[2];
	itemDesc = temp[3];
}
//insert when click save button
//update
if (request.getParameter("itemCode") != null && (session.getAttribute("is_in_update_mode") != null)) {
	Item itemObj = new Item();
	String stsMsg = itemObj.updateItem(Integer.parseInt(String.valueOf(session.getAttribute("is_in_update_mode"))),
	request.getParameter("itemCode"), request.getParameter("itemName"), request.getParameter("itemPrice"),
	request.getParameter("itemDesc"));
	itemCode = "";
	itemName = "";
	itemPrice = "";
	itemDesc = "";

	session.setAttribute("is_in_update_mode", "");
	session.setAttribute("statusMsg", stsMsg);
} else if (request.getParameter("itemCode") != null) {
	Item itemObj = new Item();
	String stsMsg = itemObj.insertItem(request.getParameter("itemCode"), request.getParameter("itemName"),
	request.getParameter("itemPrice"), request.getParameter("itemDesc"));
	session.setAttribute("statusMsg", stsMsg);

}
//delete
if (request.getParameter("itemID") != null) {
	Item itemObj = new Item();
	String stsMsg = itemObj.removeItem(Integer.parseInt(request.getParameter("itemID")));
	session.setAttribute("statusMsg", stsMsg);
	itemCode = "";
	itemName = "";
	itemPrice = "";
	itemDesc = "";
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col">
				<h1>Items Management</h1>
				<form method="post" action="items.jsp">
					Item code: <input name="itemCode" type="text"
						value="<%out.print(itemCode);%>" class="form-control"><br>
					Item name: <input name="itemName" type="text"
						value="<%out.print(itemName);%>" class="form-control"><br>
					Item price: <input name="itemPrice" type="text"
						value="<%out.print(itemPrice);%>" class="form-control"><br>
					Item description: <input name="itemDesc" type="text"
						value="<%out.print(itemDesc);%>" class="form-control"><br>
					<input name="btnSubmit" type="submit" value="Save"
						class="btn btn-primary">
				</form>

				<div class="alert alert-success">
					<%
						out.print(session.getAttribute("statusMsg"));
					%>
				</div>

				<%
					Item itemObj = new Item();
				out.print(itemObj.readItems());
				%>
				<br>
			</div>
		</div>

	</div>




</body>
</html>