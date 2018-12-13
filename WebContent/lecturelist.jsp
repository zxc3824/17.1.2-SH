<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
@import url(https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css);

@font-face {
	font-family: '빙그레체';
	src: url(fonts/Binggrae.ttf) format('truetype');
	src: url(fonts/Binggrae.eot) format('opentype');
	src: url(fonts/Binggrae.woff) format('woff'); 
}

table.one {
margin-bottom: 3em;
border-collapse:collapse;
}

td {
text-align: center;
width: 10em;
padding: 1em;
}

th {
text-align: center;
padding: 1em;
background-color: #e8503a;
color: white;
}

tr {
height: 1em;
}

table tr:nth-child(even) {
background-color: #eee;
}

table tr:nth-child(odd) {
background-color:#fff;
}
</style>
<title>Insert title here</title>
</head>
<body style="font-family:'빙그레체'">
	<%
	request.setCharacterEncoding("utf-8");
	
	String[] type = request.getParameterValues("type");
	String[] grade = request.getParameterValues("grade");
	String[] grades = request.getParameterValues("grades");
	String[] time = request.getParameterValues("time");
	String[] lectime = request.getParameterValues("lectime");
	String lecSearch = request.getParameter("lecSearch");
	String name = request.getParameter("name");
	String lectime_all = request.getParameter("lectime_all");
	
	String sql = "select * from lecture_list where";
	
	//조건절 추가
	boolean first = true;
	if((type == null || grade == null || grades == null || time == null || (lectime == null && lectime_all == null)) && lecSearch != null) {
		String script = "<script>alert('";
		if(type == null) {script += "이수구분"; first = false;}
		if(grade == null) {if(!first) script += ", "; script += "학년"; first = false;}
		if(grades == null) {if(!first) script += ", "; script += "학점"; first = false;}
		if(time == null) {if(!first) script += ", "; script += "시간"; first = false;}
		if(lectime == null) {if(!first) script += ", "; script += "강의시간표"; first = false;}
		script += "을 정해주세요.');</script>";
		out.println(script);
	} else {
		if(type != null) {
			for(int i = 0; i < type.length; i++) {
				if(first) {
					sql += " (type='" + type[i] + "'";
					first = false;
				} else sql += " or type='" + type[i] + "'";
			}
			sql += ")";
		}
		first = true;
		if(grade != null) {
			for(int i = 0; i < grade.length; i++) {
				if(first) {
					sql += " and (grade='" + grade[i] + "'";
					first = false;
				} else sql += " or grade='" + grade[i] + "'";
			}
			sql += ")";
		}
		first = true;
		if(grades != null) {
			for(int i = 0; i < grades.length; i++) {
				if(first) {
					sql += " and (grades='" + grades[i] + "'";
					first = false;
				} else sql += " or grades='" + grades[i] + "'";
			}
			sql += ")";
		}
		first = true;
		if(time != null) {
			for(int i = 0; i < time.length; i++) {
				if(first) {
					sql += " and (time_theo+time_prac='" + time[i] + "'";
					first = false;
				} else sql += " or time_theo+time_prac='" + time[i] + "'";
			}
			sql += ")";
		}
		first = true;
		if(lectime != null) {
			if(lecSearch.equals("exactly")) {
				ArrayList<String> checkedTime = new ArrayList<String>();
				for(int i = 0; i < lectime.length; i++) {
					if(first) {
						sql += " and (" + lectime[i] + "='Y'";
						first = false;
					} else sql += " and " + lectime[i] + "='Y'";
				}
				String[] day = {"mon", "tue", "wed", "thu", "fri", "sat"};
				boolean checked = false;
				for(int a = 0; a < day.length; a++) {
					for(int b = 0; b < 14; b++) {
						for(int c = 0; c < lectime.length; c++) {
							if((day[a] + b).equals(lectime[c])) {checked = true; break;}
						}
						if(checked) {checked = false; continue;}
						sql += " and " + day[a] + b + " is null";
					}
				}
			}
			if(lecSearch.equals("allpart")) {
				for(int i = 0; i < lectime.length; i++) {
					if(first) {
						sql += " and (" + lectime[i] + "='Y'";
						first = false;
					} else sql += " and " + lectime[i] + "='Y'";
				}
			}
			if(lecSearch.equals("part")) {
				for(int i = 0; i < lectime.length; i++) {
					if(first) {
						sql += " and (" + lectime[i] + "='Y'";
						first = false;
					} else sql += " or " + lectime[i] + "='Y'";
				}
			}
			sql += ")";
		}
		if(name != null && type != null && grade != null && grades != null && time != null) sql += " and name like '%" + name + "%'";
	}
	
	if(sql == "select * from lecture_list where") sql = "select * from lecture_list where grade=-1";
	pageContext.setAttribute("sql", sql);
	%>
	
	
	<sql:query var="result" dataSource="jdbc/mysql">
		<%=sql %>
	</sql:query>
	
	<c:if test="${sql eq 'select * from lecture_list where grade=-1' }">
		<div	style="display: inline-block; text-align: center; font-weight:bold; color:#444; vertical-align:middle; height: 500px; width: 100%">
			<div style="height:155px"></div>
			<h1>12조<br>수강 신청 도우미</h1>
			<h3>20121254 김상한<br>20121261 박모세소망</h3>
		</div>
	</c:if>
	
	<c:if test="${sql ne 'select * from lecture_list where grade=-1' }">
		<br><h2 align="center" style="color:#444">검색 결과</h2><br>
		<table align="center">
			<tr>
				<th style="width:35px">순번</th>
				<th style="width:40px">학년</th>
				<th style="width:80px">구분</th>
				<th style="width:70px">과목번호</th>
				<th style="width:261px">강의명</th>
				<th style="width:50px">분반</th>
				<th style="width:80px">학점/시간</th>
				<th style="width:120px">강의시간</th>
			</tr>
			<c:set var="index" value="1"></c:set>
			<c:forEach var="row" items="${result.rows }">
				<tr>
					<td style="width:35px">${index }</td>
					<td style="width:40px"><c:if test="${row.grade ne '0'}">${row.grade }</c:if></td>
					<td style="width:80px">${row.type }</td>
					<td style="width:70px">${row.number }</td>
					<td style="width:261px">${row.name }</td>
					<td style="width:50px">${row.classify }</td>
					<td style="width:80px">${row.grades }|${row.time_theo }|${row.time_prac }</td>
					<td style="width:120px">${row.lectime }</td>
				</tr>
				<c:set var="index" value="${index + 1 }"></c:set>
			</c:forEach>
		</table>
	</c:if>
</body>
</html>