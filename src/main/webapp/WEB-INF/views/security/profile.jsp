<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<%@ include file="../layouts/header.jsp"%>



    
<sec:authorize access="isAuthenticated()">
	<!-- 사용자 정보 결정 -->
	<c:set var="user"
		value="${sessionScope.userId != null ? sessionScope : auth.principal}" />
	</sec:authorize>

<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />

<script>
	var currentUserId = "${loggedInUserId}";
</script>

<!-- 프로필 정보 섹션 -->
<div class="wrap">
	<div class="greenContainer">
		<!-- 프로필 사진 표시 -->
		<div class="grade">
			<c:choose>
				<c:when test="${not empty sessionScope.naverUser}">
					<img class="avatar"
						src="https://api.dicebear.com/7.x/identicon/svg?seed=${sessionScope.naverUser.id}" />
				</c:when>
				<c:otherwise>
					<img class="avatar"
						src="https://api.dicebear.com/7.x/identicon/svg?seed=${user.userid}" />
				</c:otherwise>
			</c:choose>
		</div>
		<div class="modify">i</div>
	</div>

	<!-- 사용자 정보 표시 -->
	<div class="d-flex my-3 align-items-center">
		<div class="ml-4">
			<c:choose>
				<c:when test="${not empty sessionScope.naverUser}">
					<!-- 네이버 사용자 정보 -->
					<div>ID: ${sessionScope.naverUser.id}</div>
					<div>이름: ${sessionScope.naverUser.name}</div>
					<div>Email: ${sessionScope.naverUser.email}</div>
					<div>성별: ${sessionScope.naverUser.gender}</div>
					<div>생일: ${sessionScope.naverUser.birthday}</div>
				</c:when>
				<c:otherwise>
					<!-- 일반 사용자 정보 -->
					<div>ID: ${user.userid}</div>
					<div>이름 : ${user.username}</div>
					<div>
						가입일:
						<fmt:formatDate value="${user.regDate}" pattern="yyyy-MM-dd HH:mm" />
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>


<div class="listContainer">

	<!-- 사용자 프로필 및 정보 -->
	<div class="user-profile">
		<!-- 프로필 정보 -->

	</div>

	<!-- 팔로우 모달창 표시 버튼 -->
	<button id="showFollowModal" class="btn btn-primary">팔로우 목록 보기</button>

	<!-- 팔로우 모달창 -->
	<link rel="stylesheet" href="/resources/css/modal.css" />
	<div id="followModal" class="modal_wrapper" style="display: none;">
		<div class="modal-content">
			<span class="close" onclick="closeFollowModal()">&times;</span>
			<h2>팔로우</h2>
			<div id="userList">
				<!-- 사용자 목록 표시 -->
			</div>
		</div>
	</div>



	<a href="#" class="item">
		<div class="icon">ii</div>
		<div class="text">책 평가 및 리뷰 확인 기능</div>
		<div class="right"></div>
	</a> <a href="#" class="item">
		<div class="icon">ii</div>
		<div class="text">알림 기능 구현</div>
		<div class="right"></div>
	</a>
	<div class="right"></div>
</div>




</div>

<link href="/resources/css/profile.css" rel="stylesheet" type="text/css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	//팔로우 모달창 표시
	$('#showFollowModal').click(function() {
		$('#followModal').show();
		loadUsers();
	});

	// 모달창 닫기 함수
	function closeFollowModal() {
		$('#followModal').hide();
	}

	

	// 사용자 목록 로드
	function loadUsers() {
		   console.log("Sending AJAX request");
		    $.ajax({
		        url: '/api/usersWithFollowStatus',
		        method: 'GET',
		        success: function(users) {
		            var userList = $('#userList');
		            userList.empty();
		            var table = $('<table>').addClass('table');
		         
		            var tbody = $('<tbody>');

		            users.forEach(function(user) {
		                if (user.userid !== currentUserId) { // 현재 로그인한 사용자 제외
		                	var tr = $('<tr>').append('<td>' + user.userid + '</td>')
		                						.append('<td>' + user.username + '</td>');
		                	 var followText = user.followStatus ? '언팔로우' : '팔로우';
		                	 tr.append('<td><button data-userid="' + user.userid + '" class="btn btn-outline-primary">' + followText + '</button></td>');
		                	 tbody.append(tr);
		                }
		            });

		            table.append(tbody);
		            userList.append(table);
		        },
		        error: function(error) {
		            // 오류 처리
		        }
		    });
		}

	// 팔로우 상태 토글
function toggleFollow(userId) {
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");

    $.ajax({
        url: '/security/toggleFollow',
        method: 'POST',
        data: { userId: userId },
        beforeSend: function(xhr) {
            if (header) {
                xhr.setRequestHeader(header, token);
            }
        },
        success: function(isFollowing) {
            console.log("Toggle follow response for user " + userId + ": " + isFollowing);
            var button = $('button[data-userid="' + userId + '"]');
            updateButtonState(button, isFollowing);
        },
        error: function(error) {
            console.error('Error toggling follow:', error);
        }
    });
}
	
	//버튼 상태 업데이트 
function updateButtonState(button, isFollowing) {
    if (isFollowing) {
        button.text('언팔로우');
    } else {
        button.text('팔로우');
    }
}
	
$('#userList').on('click', 'button', function() {
    var userId = $(this).data('userid');
    console.log("Toggling follow for user " + userId);
    toggleFollow(userId);
});

	//  모달창 닫기
	window.onclick = function(event) {
		if (event.target == document.getElementById('followModal')) {
			closeFollowModal();
		}
	};
</script>

<%@ include file="../layouts/footer.jsp"%>
