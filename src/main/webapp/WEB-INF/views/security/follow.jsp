<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
    prefix="sec"%>


<sec:authentication property="principal.userid" var="loggedInUserId" />

<!-- 팔로우 목록 -->
<div class="user-list">
    <c:forEach var="follower" items="${followers}">
        <div class="follower">
            <span>${follower.username}</span>
            <c:if test="${follower.userid != loggedInUserId}">
                <!-- 팔로우/언팔로우 버튼 표시 -->
                <button>팔로우/언팔로우</button>
            </c:if>
        </div>
    </c:forEach>
</div>