<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<%@ include file="../layouts/header.jsp"%>



<div style="width: 1000px" class="mx-auto">
	<h1 class="my-5">
		<i class="fa-solid fa-user-plus"></i> 회원 가입
	</h1>
	<p class="text-end"></p>
	<hr class="hr-solid">
	<div>
		<form:form modelAttribute="user"
			action="/security/signup?_csrf=${_csrf.token}">

			<div class="form-group">
				<form:label path="userid">
					<i class="fa-solid fa-id-badge"></i> ID:</form:label>
				<form:input path="userid" class="form-control" />
				<form:errors path="userid" cssClass="error" />
			</div>

			<div class="form-group">
				<form:label path="username">
					<i class="fa-solid fa-user"></i>  이름:</form:label>
				<form:input path="username" class="form-control" />
				<form:errors path="username" cssClass="error" />
			</div>

			<div class="form-group">
				<form:label path="nickname">
					<i class="fa-solid fa-user"></i> 사용자 닉네임:</form:label>
				<form:input path="nickname" class="form-control" />
				<form:errors path="nickname" cssClass="error" />
			</div>

			<div class="form-group">
				<form:label path="password">
					<i class="fa-solid fa-lock"></i>  비밀번호:</form:label>
				<form:password path="password" class="form-control" />
				<form:errors path="password" cssClass="error" />
			</div>

			<div class="form-group">
				<form:label path="passwordcheck">
					<i class="fa-solid fa-lock"></i>  비밀번호 확인:</form:label>
				<form:password path="passwordcheck" class="form-control" />
				<form:errors path="passwordcheck" cssClass="error" />
			</div>

			<div class="form-group">
				<form:label path="email">이메일</form:label>
				<div id="SuperviserEmail" class="input-group">
					<input class="form-control" type="text" id="viserEmail"
						name="email" placeholder="이메일 아이디" />
					<div style="margin: 3px"></div>
					<span id="displayEmail"></span>
					<!-- 여기에 이메일 주소를 표시할 요소를 추가합니다 -->
					<!-- 수정 끝 -->
					<input class="box" id="domain-txt" type="text" name="email" /> <select
						class="box" id="domain-list" name="email">

						<option value="naver.com">naver.com</option>
						<option value="google.com">google.com</option>
						<option value="kakao.com">kakao.com</option>
						<option value="type">직접 입력</option>
					</select>
				</div>
				<form:errors path="email" cssClass="error" />
			</div>



			<script>
    const domainListEl = document.querySelector('#domain-list');
    const domainInputEl = document.querySelector('#domain-txt');
    const emailDisplay = document.querySelector('#displayEmail');
    const viserEmail = document.querySelector('#viserEmail');

    domainListEl.addEventListener('change', (event) => {
    	
        if (event.target.value !== "type") {
            domainInputEl.value = event.target.value;
            domainInputEl.disabled = true;
            
         // domainInputEl이 직접 입력일 때는 emailDisplay에 표시하지 않도록
            emailDisplay.textContent = `${viserEmail.value}@${event.target.value}`;
        } else {
            domainInputEl.value = "";
            domainInputEl.disabled = false;
       //     emailDisplay.textContent = viserEmail.value; // 직접 입력시 emailDisplay에 @type을 포함시키지 않음
        }

        // Email 생성 및 표시 로직
        const domain = domainInputEl.value;
       emailDisplay.textContent = `${viserEmail.value}@${domain}`;
    });

    // 초기화
    domainInputEl.disabled = true;
</script>



			<div class="form-group">
				<form:label path="birth"> 생일:</form:label>

				<div class="info" id="info-birth">
					<select class="box" id="birth.year" name="birth.year">
						<option disabled selected>Year</option>
						<c:forEach var="year" begin="1960" end="2023">
							<option value="${year}">${year}</option>
						</c:forEach>
					</select> <select class="box" id="birth.month" name="birth.month">
						<option disabled selected>월</option>
						<c:forEach var="month" begin="1" end="12">
							<option value="${month}">${month}</option>
						</c:forEach>
					</select> <select class="box" id="birth.day" name="birth.day">
						<option disabled selected>일</option>
						<c:forEach var="day" begin="1" end="31">
							<option value="${day}">${day}</option>
						</c:forEach>
					</select>
				</div>

				<form:errors path="birth" cssClass="error" />
			</div>

			<div class="form-group">
				<form:label path="gender">성별</form:label>
				<br> <input type="radio" id="male" name="gender" value="남성">
				<label for="male">남성</label><br> <input type="radio"
					id="female" name="gender" value="여성"> <label for="female">여성</label><br>
				<form:errors path="gender" cssClass="error" />
			</div>


			<div class="text-center">
				<button type="submit" class="btn btn-primary">
					<i class="fa-solid fa-user-plus"></i> 회원가입
				</button>
			</div>
		</form:form>

	</div>
</div>


<%@ include file="../layouts/footer.jsp"%>
