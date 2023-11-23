<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!-- SIDEBAR 있음 logo-sm 있음 대부분에 사용-->
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Bookbook</title>
<head>
<!-- bootstrap css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">
<!-- 글꼴 -->
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/maru-buri.css"
	rel="stylesheet">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-gothic.css"
	rel="stylesheet">
<!-- css링크 -->
<link rel="stylesheet" href="/resources/css/base.css" />
<!-- FontAwesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.0/css/all.min.css"
	integrity="sha512-10/jx2EXwxxWqCLX/hHth/vu2KY3jCF70dCQB8TSgNjbCVAC/8vai53GfMDrO2Emgwccf2pJqxct9ehpzG+MTw=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- bootstrap js -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
	integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js"
	integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa"
	crossorigin="anonymous"></script>

<style>
.blank {
	border: 3px solid red;
	width: 140px;
	height: 39px;
}

header {
	justify-content: flex-end;
}

.sign .btn {
	margin-bottom: 5px;
}

.cate {
	background-color: white;
	color: black;
	border: 1px solid #cccccc;
}

#searchIco {
	width: 38px;
	height: 38px;
}

#searching {
	border: none;
}
</style>
</head>
<body>
	<div class=background>
		<header>
			<ul class="navbar-nav sign">
				<sec:authorize access="isAuthenticated()">
					<!-- 로그인 된 상태 -->
					<c:if test="${not empty username}">
						<li class="nav-item">
							<div class="btn-group">
								<button type="button"
									class="btn btn-secondary dropdown-toggle sub"
									data-bs-toggle="dropdown" aria-expanded="false">
									<img class="avatar"
										src="https://api.dicebear.com/7.x/identicon/svg?seed=${user.userid}" />
									${user.userid}
								</button>

								<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
									<li><a class="dropdown-item" href="/security/logout">로그아웃</a></li>
									<li><hr class="dropdown-divider"></li>
									<li><a class="dropdown-item" href="/security/profile">프로필</a></li>
								</ul>
							</div>
						</li>
					</c:if>
				</sec:authorize>
				<sec:authorize access="isAnonymous()">
					<!-- 로그아웃 된 상태 -->

					<li class="nav-item sign">
						<button type="button" class="btn btn-secondary sub"
							onclick="location.href='/security/login'">
							<!-- 코드보기 편하게용 주석 -->
							로그인
						</button>
					</li>
					<li class="nav-item sign">
						<button type="button" class="btn btn-secondary sub"
							onclick="location.href='/security/signup'">
							<!-- 코드보기 편하게용 주석 -->
							회원가입
						</button>
					</li>

				</sec:authorize>
			</ul>
		</header>