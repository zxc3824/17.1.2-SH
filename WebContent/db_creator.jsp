<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
$(function(){
	$("input[name=submit]").click(function(){
		$.post("db_creator.jsp", $(".form").serialize(), function(data){
			eval("if (upload.file1.value == '') {alert('파일을 업로드해주세요.');	return false;} else if(!checkFileType(upload.file1.value)) {alert('엑셀파일만 업로드 해주세요.'); return false; } document.upload.submit();");
		})
	})
})
function checkForm() {
	if (upload.file1.value == "") {
		alert("파일을 업로드해주세요.");
		return false;
		} 
	else if(!checkFileType(upload.file1.value)) {
		alert("엑셀파일만 업로드 해주세요.");
		return false;
	}
	document.upload.submit();
}
function checkFileType(filePath){
	var fileLen = filePath.length;
	var fileFormat4 = filePath.substring(fileLen - 4);
	var fileFormat5 = filePath.substring(fileLen - 5);
	fileFormat4fileFormat4 = fileFormat4.toLowerCase();
	fileFormat5fileFormat5 = fileFormat5.toLowerCase();
	if (fileFormat4 == ".xls" || fileFormat5 == ".xlsx" || fileFormat5 == ".xlsm" || fileFormat4 == ".xls") return true;
	else return false;
}
</script>
<title>Insert title here</title>
</head>
<body style="text-align:center">
<form class="form" name="upload" method="POST" enctype="multipart/form-data">
<input type="file" name="file1" size="20" accept=".xml, .xlsx, .xlsm, .xls"/>
<a onclick="checkForm();" style="cursor:hand"> [전송] </a>
</form>
<form class="form" name="form" method="post">
<c:set var="now" value="<%=new java.util.Date()%>" />
년도 : 
<select id="year" name="year">
	<fmt:formatDate value="${now}" pattern="yyyy" var="yearStart"/> 
	<c:forEach begin="0" end="8" var="result" step="1">
		<option value="${yearStart - result + 4}" <c:if test="${(yearStart - result + 4) == yearStart}"> selected="selected"</c:if>>${yearStart - result + 4}</option>
	</c:forEach>
</select>&nbsp;
학기 : 
<select name="semester">
	<fmt:formatDate value="${now }" pattern="MM" var="month"/>
	<option value="1" <c:if test="${month <= 6 }"> selected="selected"</c:if>>1</option>
	<option value="2" <c:if test="${month > 6 }"> selected="selected"</c:if>>2</option>
</select>&nbsp;
변환할 DB명 : <input type="text" name="db_name">&nbsp;
<input type="submit" name="submit" value="변환하기">
</form>
<%
String year = request.getParameter("year");
String semester = request.getParameter("semester");
String db_name = request.getParameter("db_name");
if(year != null && semester != null && db_name != null) {
	
}
%>
</body>
</html>