<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" type="image/x-icon" href="magnifier_black.png" />
<script src="test.css"></script>
<style type="text/css">

@font-face {
	font-family: '빙그레체';
	src: url(fonts/Binggrae.ttf) format('truetype');
	src: url(fonts/Binggrae.eot) format('opentype');
	src: url(fonts/Binggrae.woff) format('woff'); 
}

@font-face {
	font-famliy: '나눔바른고딕OTF';
	src: url(fonts/NanumBarunGothic.ttf) format('truetype');
	src: url(fonts/NanumBarunGothic.eot) format('opentype');
	src: url(fonts/NanumBarunGothic.woff) format('woff');
}

.menubar {
	border: none;
	border: 0px;
	margin: 0px;
	padding: 0px;
	font-family: "나눔바른고딕OTF";
	font-size: 19px;
}

.menubar ul {
	background: #3498DB;
	height: 50px;
	list-style: none;
	margin: 0;
	padding: 0;
}

.menubar li {
	float: left;
	padding: 0px;
}

.menubar li a {
	background: #3498DB;
	color: #eee;
	display: block;
	font-weight: normal;
	line-height: 50px;
	margin: 0px;
	padding: 0px 25px;
	text-align: center;
	text-decoration: none;
}

.menubar li a:hover, .menubar ul li:hover a {
	background: #2980B9;
	color: #fff;
	text-decoration: none;
}

.menubar li ul {
	background: #3498DB;
	display: none; /* 드랍메뉴 숨기기 */
	height: auto;
	padding: 0px;
	margin: 0px;
	border: 0px;
	position: absolute;
	width: 160px;
	z-index: 200;
}

.menubar li:hover ul {
	display: block; /* 마우스 올리면 드랍메뉴 보이기 */
}

.menubar li li {
	background: #3498DB;
	display: block;
	float: none;
	margin: 0px;
	padding: 0px;
	width: 160px;
}

.menubar li:hover li a {
	background: none;
}

.menubar li ul a {
	display: block;
	height: 50px;
	font-size: 15px;
	font-style: normal;
	margin: 0px;
	padding: 0px 10px 0px 15px;
	text-align: left;
}

.menubar li ul a:hover, .menubar li ul li:hover a {
	background: #2980B9;
	border: 0px;
	color: #ffffff;
	text-decoration: none;
}

.menubar p {
	clear: left;
}

input[type=checkbox] {
	width: 25px;
	height: 25px;
	position: relative;
	top: -1px;
	vertical-align: middle;
}

input[type=text] {
	width: 150px;
	height: 25px;
	color: #444;
	position: relative;
	font-family: Binggrae, 빙그레체;
	font-weight: bold;
	border: 1px solid;
	border-radius: 2px;
	top: -1px;
	vertical-align: middle;
}
</style>
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.type_all').click(function() {
			$('input[name=type]').prop('checked', this.checked);
		});
		$('input[name=type]').click(function() {
			if ($('.type_all').prop('checked'))
				$('.type_all').prop('checked', this.checked);
		})
		$('.grade_all').click(function() {
			$('input[name=grade]').prop('checked', this.checked);
		})
		$('input[name=grade]').click(function() {
			if ($('.grade_all').prop('checked'))
				$('.grade_all').prop('checked', this.checked);
		})
		$('.grades_all').click(function() {
			$('input[name=grades]').prop('checked', this.checked);
		})
		$('input[name=grades]').click(function() {
			if ($('.grades_all').prop('checked'))
				$('.grades_all').prop('checked', this.checked);
		})
		$('.time_all').click(function() {
			$('input[name=time]').prop('checked', this.checked);
		})
		$('input[name=time]').click(function() {
			if ($('.time_all').prop('checked'))
				$('.time_all').prop('checked', this.checked);
		})
		$('.lectime_Exactly').click(function() {
			if ($('.lectime_AllPart').prop('checked')) $('.lectime_AllPart').prop('checked', false);
			if (!$('.lectime_Exactly').prop('checked')) $('.lectime_Exactly').prop('checked', true);
			if ($('.lectime_Part').prop('checked')) $('.lectime_Part').prop('checked', false);
		})
		$('.lectime_AllPart').click(function() {
			if (!$('.lectime_AllPart').prop('checked')) $('.lectime_AllPart').prop('checked', true);
			if ($('.lectime_Exactly').prop('checked')) $('.lectime_Exactly').prop('checked', false);
			if ($('.lectime_Part').prop('checked')) $('.lectime_Part').prop('checked', false);
		})
		$('.lectime_Part').click(function() {
			if ($('.lectime_Exactly').prop('checked')) $('.lectime_Exactly').prop('checked', false);
			if ($('.lectime_AllPart').prop('checked')) $('.lectime_AllPart').prop('checked', false);
			if (!$('.lectime_Part').prop('checked')) $('.lectime_Part').prop('checked', true);
		})
		$('.lectime_all').click(function() {
			if($('.lectime_all').prop('checked')) {
				$('input[name=lectime]').prop('disabled', true);
				$('input[name=lecSearch]').prop('disabled', true);
			}
			else {
				$('input[name=lectime]').prop('disabled', false);
				$('input[name=lecSearch]').prop('disabled', false);
			}
		})
	});
	
	function iframeAutoResize(obj) {
	    if(obj.contentDocument){
	        obj.height = obj.contentDocument.body.offsetHeight + 40;
	    } else {
	        obj.height = obj.contentWindow.document.body.scrollHeight;
	    }
	}
</script>
<title>수강 신청 도우미</title>
</head>
<body style="background-color: #2C3E50">
	<div
		style="max-width: 1000px; padding: 10px; margin: 0 auto; background-color: #ECF0F1">
		<form name="form" id="form" method="post" action="lecturelist.jsp">
			<div class="menubar">
				<ul>
					<li><a style="font-weight:bold">이수구분</a>
						<ul>
							<li><a><input type="checkbox" class="type_all">
									전체</a></li>
							<%
								int i = 0;
							%>
							<c:forTokens var="type"
								items="전공필수,전공선택,교양필수,교양선택,학과(부)기초,교직,자유선택,일반선택,공통기초,전공,계열기초"
								delims=",">
								<li><a><input type="checkbox" name="type"
										value="${type }"> ${type }</a></li>
								<%
									i++;
								%>
							</c:forTokens>
						</ul></li>
					<li><a style="font-weight:bold">학년</a>
						<ul>
							<li><a><input type="checkbox" class="grade_all">
									전체</a></li>
							<li><a><input type="checkbox" name="grade" value="0">
									구분없음</a></li>
							<li><a><input type="checkbox" name="grade" value="1">
									1</a></li>
							<li><a><input type="checkbox" name="grade" value="2">
									2</a></li>
							<li><a><input type="checkbox" name="grade" value="3">
									3</a></li>
							<li><a><input type="checkbox" name="grade" value="4">
									4</a></li>
						</ul></li>
					<li><a style="font-weight:bold">학점</a>
						<ul>
							<li><a><input type="checkbox" class="grades_all">
									전체</a></li>
							<li><a><input type="checkbox" name="grades" value="1">
									1</a></li>
							<li><a><input type="checkbox" name="grades" value="2">
									2</a></li>
							<li><a><input type="checkbox" name="grades" value="3">
									3</a></li>
						</ul></li>
					<li><a style="font-weight:bold">강의시간</a>
						<ul>
							<li><a><input type="checkbox" class="time_all">
									전체</a></li>
							<c:forEach var="num" begin="1" end="6">
								<li><a><input type="checkbox" name="time"
										value="${num }"> ${num }</a></li>
							</c:forEach>
						</ul></li>
					<li class="aa"><a style="font-weight:bold">강의시간표</a>
						<ul>
							<li style="width: 230px; height: 100px; margin: 0px"><a style="height: 100px; line-height: 20px">
								<table>
									<tr>
										<td width="50px">검색<br>방식</td>
										<td rowspan="3">
											<input type="checkbox" style="width:20px;" name="lecSearch" value="exactly" class="lectime_Exactly" checked="checked"> 정확하게<br>
											<input type="checkbox" style="width:20px;" name="lecSearch" value="allpart" class="lectime_AllPart"> 전부 포함<br>
											<input type="checkbox" style="width:20px;" name="lecSearch" value="part" class="lectime_Part"> 일부 포함
										</td>
									</tr>
								</table></a>
							</li>
							<li style="width: 230px; height: 482px">
								<a	style="line-height: 20px; height: 482px">
									<input type="checkbox" class="lectime_all" style="width:20px"> 전체
									<table style="text-align: center">
										<tr>
											<td></td>
											<td>월</td>
											<td>화</td>
											<td>수</td>
											<td>목</td>
											<td>금</td>
											<td>토</td>
										</tr>
										<c:forEach var="num" begin="0" end="13">
											<tr>
												<td>${num }</td>
												<c:forTokens var="day" items="mon,tue,wed,thu,fri,sat"
													delims=",">
													<td><input type="checkbox" name="lectime"
														value="${day }${num }" style="width: 20px; height: 20px"></td>
												</c:forTokens>
											</tr>
										</c:forEach>
									</table>
							</a></li>
						</ul></li>
					<li><a style="font-weight:bold">강의명<input type="text" name="name" onkeypress="if(event.keyCode==13) {document.getElementById('arrow').style.visibility='hidden';document.form.target='list';document.form.submit();}" style="margin-left: 10px; padding-left:21px; background-image: url(magnifier.png); background-repeat: no-repeat; background-position: left 4px center; background-size: 15px"></a></li>
					<li style="position: relative; float: right"><a href="javascript:{}" style="width: 50px; height: 50px; background-color: #2387ca" onmouseover="this.style.backgroundColor='#1276b9'" onmouseout="this.style.backgroundColor='#2387ca'" onclick="document.getElementById('arrow').style.visibility='hidden';document.form.target='list';document.form.submit();">조회</a></li>
				</ul>
			</div>
			<img src="arrow.png" id="arrow" style="position: absolute; right: calc(50% - 200px); top: 76px">
			<iframe src="lecturelist.jsp" style="width: 100%; 	min-height: 100%; border: 0" name="list" id="list" onLoad="iframeAutoResize(this)"></iframe>
		</form>
	</div>
</body>
</html>