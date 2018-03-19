<%@ page language="java" contentType="text/html; charset=GB18030"
	pageEncoding="GB18030"%>
<%@ page import="com.mysql.jdbc.Driver"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("gbk");
%>
<jsp:useBean id="query" scope="application" class="职有我.dbManagement" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>职有我 | 首页</title>
<link rel="icon" href="icons/2.jpg" type="image/x-icon" />
<script type="text/javascript">
	var prevVal = "100";
	function $(id) {
		return document.getElementById(id);
	}
	function saveSel() {
		prevVal = $("province").options[$("province").selectedIndex].value;
	}
	window.load = saveSel;
	function change() {
		if (prevVal != null) {
			document.getElementById(prevVal).style.display = "none";
			document.getElementById(prevVal).value = "";
		}
		saveSel();
		document.getElementById(prevVal).style.display = "";
		document.getElementById("city").value = "";
	}
</script>
<script type="text/javascript">
	var valed = "100j";
	function $(id) {
		return document.getElementById(id);
	}
	window.onload = save;
	function save() {
		valed = $("jobtype").options[$("jobtype").selectedIndex].value;
	}
	function changeJ() {
		if (valed != null) {
			document.getElementById(valed).style.display = "none";
			document.getElementById(valed).value = "";
		}
		save();
		document.getElementById(valed).style.display = "";
		document.getElementById("job").value = "";
	}
</script>
</head>
<body>
	<div
		style="position: absolute; z-index: -1; top: 0; width: 100%; height: 100%;">
		<img src="icons/bg1.jpg" width="100%" height="100%" /> <img
			src="icons/bg2.jpg" width="100%" height="100%" />
	</div>
	<div
		style="text-align: right; position: fixed; z-index: 1; position: fixed; top: 0; width: 100%; height: 10%;">
		<%
			if (request.getAttribute("email") == null || request.getAttribute("email").equals("nulll")) {
		%>
		<form action="userLogin.jsp" method="post">
			<input type="submit" name="用户登陆" value="用户登陆"
				style="border: none; color: white; font-size: 20px; background: rgba(0, 0, 0, 0.5); width: 130px; height: 30">&nbsp;&nbsp;&nbsp;&nbsp;
		</form>
		<form action="companyLogin.jsp" method="post">
			<br> <input type="submit" name="企业入口" value="企业入口"
				style="border: none; color: white; font-size: 20px; background: rgba(0, 0, 0, 0.5); width: 130px; height: 30">&nbsp;&nbsp;&nbsp;&nbsp;
		</form>
		<%
			} else {
		%>
		<form action="goUserHome.jsp" method="post">
			<input type="hidden" name="email"
				value="<%=request.getAttribute("email")%>"> <input
				type="submit" value="个人中心"
				style="border: none; color: white; font-size: 20px; background: rgba(0, 0, 0, 0.5); width: 130px; height: 30">
		</form>
		<form action="logout.jsp" method="post">
			<input type="submit" value="注  销"
				style="border: none; color: white; font-size: 20px; background: rgba(0, 0, 0, 0.5); width: 130px; height: 30">
		</form>
		<form action="companyLogin.jsp" method="post">
			<input type="submit" value="企业入口"
				style="border: none; color: white; font-size: 20px; background: rgba(0, 0, 0, 0.5); width: 130px; height: 30">
		</form>
		<%
			}
		%>
	</div>
	<form action="select.jsp" method="post">
		<input type="hidden" name="email" id="email"
			value="<%=request.getAttribute("email")%>"> <strong><p
				align="center"
				style="font-size: 80px; font-family: YouYuan; color: white">职有我</p></strong>
		<p align="center"
			style="font-size: 40px; font-family: Times New Roman; color: white">JOB
			SEARCHING JUST GOT SO EASY</p>
		<table align="center" cellspacing="0" style="background: white">
			<tr height="20">
				<td width="180" align="right"><p style="font-size: 25px">省/直辖市：</p></td>
				<td><select name="province" id="province" onchange="change()"
					style="width: 130px; font-size: 20px">
						<%
							query.getConnection();
							query.setSqlSelect("select * from province");
							ResultSet rst1 = query.select();
							String[] pid = new String[35];
							int i = 0;
							while (rst1.next()) {
						%>
						<option value=<%=rst1.getString(2)%>><%=rst1.getString(1)%>
						</option>
						<%
							pid[i] = rst1.getString(2);
								i++;
							}
						%>
				</select></td>
				<td style="width: 100; font-size: 25px">城 市：</td>
				<td>
					<%
						i = 0;
						while (i < pid.length) {
							query.setSqlSelect("select * from city where pId='" + pid[i] + "'");
							rst1 = query.select();
							if (i == 0) {
					%> <select id="<%=pid[i]%>" style="width: 130px; font-size: 20px"
					onchange="document.getElementById('city').value=document.getElementById('<%=pid[i]%>').value">
						<option></option>
						<%
							while (rst1.next()) {
						%>
						<option value=<%=rst1.getString(1)%>><%=rst1.getString(3)%>
						</option>
						<%
							}
						%>
				</select> <%
 	i++;
 		} else {
 %> <select id="<%=pid[i]%>"
					style="display: none; font-size: 20px; width: 130px"
					onchange="document.getElementById('city').value=document.getElementById('<%=pid[i]%>').value">
						<option></option>
						<%
							while (rst1.next()) {
						%>
						<option value=<%=rst1.getString(1)%>><%=rst1.getString(3)%>
						</option>
						<%
							}
						%>
				</select> <%
 	i++;
 		}
 	}
 %> <input type="hidden" name="city" id="city" value="">
				</td>
				<td style="font-size: 25px">行 业：</td>
				<td><select name="jobtype" id="jobtype"
					style="width: 130px; font-size: 20px" onchange="changeJ()">
						<%
							query.setSqlSelect("select * from jobType");
							rst1 = query.select();
							int k = 0;
							StringBuffer[] jId = new StringBuffer[10];
							while (rst1.next()) {
								jId[k] = new StringBuffer(rst1.getString(1) + "j");
								k++;
						%>
						<option value=<%=rst1.getString(1)%>j><%=rst1.getString(2)%></option>
						<%
							}
						%>
				</select></td>
				<td style="font-size: 25px">工作：</td>
				<td>
					<%
						k = 0;
						while (k < jId.length) {
							query.setSqlSelect("select * from job where typeId='" + jId[k].toString().substring(0, 3) + "'");
							rst1 = query.select();
							if (k == 0) {
					%> <select id="<%=jId[k].toString()%>"
					style="width: 130px; font-size: 20px"
					onchange="document.getElementById('job').value=document.getElementById('<%=jId[k].toString()%>').value">
						<option></option>
						<%
							while (rst1.next()) {
						%>
						<option value='<%=rst1.getString(1)%>'><%=rst1.getString(3)%>
						</option>
						<%
							}
						%>
				</select> <%
 	k++;
 		} else {
 %> <select id="<%=jId[k].toString()%>"
					style="display: none; width: 130px; font-size: 20px"
					onchange="document.getElementById('job').value=document.getElementById('<%=jId[k].toString()%>').value">
						<option></option>
						<%
							while (rst1.next()) {
						%>
						<option value='<%=rst1.getString(1)%>'><%=rst1.getString(3)%>
						</option>
						<%
							}
						%>
				</select> <%
 	k++;

 		}
 	}
 %> <input type="hidden" name="job" id="job" value="">
				</td>
				<td align="left" width="130"><input type="hidden" name="email"
					id="email" value="<%=request.getAttribute("email")%>"> <strong><input
						type="submit" value="Search"
						style="font-size: 25px; color: white; border: none; width: 100px; background: #6666ff"></strong>
				</td>
		</table>
	</form>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<p align="center"
		style="font-size: 40px; font-family: Times New Roman; color: white">这些企业都在火热招聘中</p>

	<form>
		<table align="left" cellspacing="0">
			<tr align="center">
				<td width="100"></td>
				<%
					query.getConnection();
					query.setSqlSelect("SELECT  email,bName FROM positionsposted GROUP BY email");
					ResultSet rst = query.select();
					int j = 0;
					while (rst.next()) {
						if (j >= 8) {
							break;
						}
						j++;
						out.print("<td><a href='comInfoReadOnly.jsp?bEmail=" + rst.getString(1) + "&cEmail="
								+ request.getAttribute("email") + "'><img src='Logo/" + rst.getString(1) + ".jpg' title='"
								+ rst.getString(2) + "' width='100' height='100'></a></td>");
					}
					out.print("<td><a href='searchCom.jsp?email=" + request.getAttribute("email")
							+ "'><img src='icons/viewmore.png' width='100' height='100' ></a></td>");
				%>
			</tr>
		</table>
		<br>
	</form>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<HR style="FILTER: alpha(opacity = 100, finishopacity = 0, style = 3)"
		width="80%" color="white" SIZE=0.01>
	<p align="center" style="color: white">职有我-国内领先的招聘平台</p>

</body>
</html>