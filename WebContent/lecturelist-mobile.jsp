<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script	src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<style type="text/css">

table {
font-family: "빙그레체","맑은 고딕";
font-size:10px;
-webkit-overflow-scrolling: touch; !important;
overflow-y:hidden;	}		/* added custom font-family  */

table.one {									 
margin-bottom: 3em;	
border-collapse:collapse;	}	

td {							/* removed the border from the table data rows  */
text-align: center;     
width: 10em;					
padding: 1em;
border-radius:5px !important; 		}		

th {							  /* removed the border from the table heading row  */
text-align: center;					
padding: 1em;
background-color: #e8503a;	     /* added a red background color to the heading cells  */
color: white;
border-radius:5px !important;		}

tr {
height: 1em;	}

table tr:nth-child(even) {
       background-color: #eee;		}

table tr:nth-child(odd) {		     /* added all odd rows a #fff color  */
background-color:#fff;		}

.ui-select .ui-li-has-count.ui-btn-icon-right {
	padding-right:0ex;
}

.clear {
	text-shadow:#f9f9f9 !important;
	background-color: #f9f9f9 !important;
    border-color: #f9f9f9 !important;
    color: #333;
    text-shadow: 0 1px 0 #f9f9f9 !important;
}

.clear tr:nth-child(even) {
	background-color: #f9f9f9;
}

.clear tr:nth-child(odd) {
	background-color:#f9f9f9;
}

.clear tr {
	padding:0em;
}

.clear tr td {
	padding:0em;
    font-size: 1.5em;
    font-weight: bold;
}

</style>
<script type="text/javascript">
$('select').change(function() {
	var str = "";
	$('.ui-btn ui-btn-icon-right ui-checkbox-on:after').each(function() {
		str += "<input type='hidden' name='type' value='" + $(this).text() + "'>";
		$('div[name=type]').text(str);
	})
	$('select option:selected').each(function() {
		$('input[name=type]]').prop('checked', this.checked);
	})
}).trigger('change');
</script>
<title>Insert title here</title>
</head>
<body style="font-family:'빙그레체'">
	<sql:query var="rs" dataSource="jdbc/mysql">
		select * from lecture_list
	</sql:query>
	<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/test";
	String[] type = request.getParameterValues("select-1"); 
	String[] grades = request.getParameterValues("select-2");
	pageContext.setAttribute("type", type);
	pageContext.setAttribute("grades", grades);
	%>
	<center>
							<%
								int i = 0;
							%>
							<c:forTokens var="type"
								items="전공필수,전공선택,교양필수,교양선택,학과(부)기초,교직,자유선택,일반선택,공통기초,전공,계열기초"
								delims=",">
								<input type="checkbox" name="type"
										value="${type }"> ${type }
								<%
									i++;
								%>
							</c:forTokens>
		<form name="form" method="post" action="lecturelist-mobile.jsp">
			<table class="clear">
				<tbody><tr>
					<td style="width:11%">이수구분</td>
					<td style="width:70%">
						<div class="ui-select">
							<a href="#select-1-listbox" role="button" id="select-1-button" aria-haspopup="true" class="ui-btn ui-icon-carat-d ui-btn-icon-right ui-corner-all ui-shadow ui-li-has-count" data-rel="popup">
								<span>전체</span>
								<span class="ui-li-count ui-body-inherit" style="display: none;">1</span>
							</a>
							<select name="type" id="select-1" data-native-menu="false" multiple="multiple" tabindex="-1">
								<option selected="" value="전체">전체</option>
								<option value="교양필수">교양필수</option>
								<option value="교양선택">교양선택</option>
								<option value="학과(부)기초">학과(부)기초</option>
								<option value="전공필수">전공필수</option>
								<option value="전공선택">전공선택</option>
								<option value="교직">교직</option>
								<option value="자유선택">자유선택</option>
								<option value="일반선택">일반선택</option>
								<option value="공통기초">공통기초</option>
								<option value="전공">전공</option>
								<option value="계열기초">계열기초</option>
							</select><div style="display: none;" id="select-1-listbox-placeholder"><!-- placeholder for select-1-listbox --></div></div>
						</td>
						<td style="width:6%">전체</td>
						<td><div class=" ui-checkbox"><input type="checkbox" id="allCheck-1"></div></td>
					</tr>
					<tr>
					<td>학점</td>
					<td>
						<div class="ui-select"><a href="#select-2-listbox" role="button" id="select-2-button" aria-haspopup="true" class="ui-btn ui-icon-carat-d ui-btn-icon-right ui-corner-all ui-shadow ui-li-has-count" data-rel="popup"><span>전체</span><span class="ui-li-count ui-body-inherit" style="display: none;">1</span></a><select name="grades" id="select-2" data-native-menu="false" multiple="multiple" tabindex="-1">
							<option selected="" value="전체">전체</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
						</select><div style="display: none;" id="select-2-listbox-placeholder"><!-- placeholder for select-2-listbox --></div></div></td>
					<td>전체</td>
					<td><div class=" ui-checkbox"><input type="checkbox" id="allCheck-2"></div></td>
				</tr>
			</tbody></table>
			<table class="clear">
				<tr>
					<td style="width:11%">이수구분</td>
					<td style="width:70%">
						<select name="type" id="select-1" data-native-menu="false" multiple="multiple">
							<option selected value="전체">전체</option>
							<option value="교양필수">교양필수</option>
							<option value="교양선택">교양선택</option>
							<option value="학과(부)기초">학과(부)기초</option>
							<option value="전공필수">전공필수</option>
							<option value="전공선택">전공선택</option>
							<option value="교직">교직</option>
							<option value="자유선택">자유선택</option>
							<option value="일반선택">일반선택</option>
							<option value="공통기초">공통기초</option>
							<option value="전공">전공</option>
							<option value="계열기초">계열기초</option>
						</select>
					</td>
					<td style="width:6%">전체</td>
					<td><input type="checkbox" id="allCheck-1"></td>
				</tr>
				<tr>
					<td>학점</td>
					<td>
						<select name="grades" id="select-2" data-native-menu="false" multiple="multiple">
							<option selected value="전체">전체</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
						</select></td>
					<td>전체</td>
					<td><input type="checkbox" id="allCheck-2"></td>
				</tr>
			</table>
			<input type="submit" value="조회">
			<div name="search"></div>
		</form>
		<script>
		$(function(){
			$("#allCheck-1").click(function(){
				if($("#allCheck-1").prop("checked")) {
					$(".clear tr td div.ui-select").unbind();
				} else {
					$("#select-1").attr("disabled",false);
				}
			})
		})
		</script>
		<hr>
		<table>
			<tr>
				<th style="cellpadding:0px !important;cellspacing:0 !important; width:10px !important">순번</th>
				<th style="width:10px !important;cellpadding:0px !important">학년</th>
				<th style="width:50px">구분</th>
				<th style="width:10px !important;cellpadding:0px !important">과목번호</th>
				<th style="width:150px !important;cellpadding:0px !important">과목명</th>
				<th style="width:10px !important;cellpadding:0px !important">분반</th>
				<th style="width:10px !important;cellpadding:0px !important">학점</th>
				<th style="width:50px !important;cellpadding:0px !important">시간</th>
			</tr>
			<c:forEach var="row" items="${rs.rows }">
				<c:if test="${row.grades eq grades ? 'selected' : ''}">
					<tr style="height:10px !important;cellpadding:0px !important">
						<td style="width:10px !important;cellpadding:0px !important">${row.no }</td>
						<td style="width:10px !important;cellpadding:0px !important">${row.grade }</td>
						<td style="width:50px">${row.type }</td>
						<td style="width:10px !important;cellpadding:0px !important">${row.number }</td>
						<td style="width:10px !important;cellpadding:0px !important">${row.name }</td>
						<td style="width:10px !important;cellpadding:0px !important">${row.classify }</td>
						<td style="width:10px !important;cellpadding:0px !important">${row.grades }|${row.time_theo }|${row.time_prac }</td>
						<td style="width:10px !important;cellpadding:0px !important">${row.lectime }</td>
					</tr>
				</c:if>
			</c:forEach>
		</table>
	</center>
</body>
</html>