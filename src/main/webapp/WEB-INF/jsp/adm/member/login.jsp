<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<!-- sha256 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	<!--  자바스크립트  -->
		const LoginForm__checkAndSubmitDone = false;
		<!--  const = var / 중복 방지를 위한.  -->
		function LoginForm__checkAndSubmit(form) {
			if ( LoginForm__checkAndSubmitDone ) {
				return;
			}
		
			form.loginId.value = form.loginId.value.trim();
			<!--  trim() : 공백 감지  -->
			if ( form.loginId.value.length == 0 ) {
				alert('아이디를 입력해주세요.');
				form.loginId.focus();
				
				return;
			}
			
			form.loginPwInput.value = form.loginPwInput.value.trim();
			if ( form.loginPwInput.value.length == 0 ) {
				alert('비밀번호를 입력해주세요.');
				form.loginPwInput.focus();
				
				return;
			}
			
			form.loginPw.value = sha256(form.loginPwInput.value);
			form.loginPwInput.value = '';
			
			form.submit();
			LoginForm__checkAndSubmitDone = true;
		}
		
	
</script>

<section class="section-usr-login">

	<div class="container mx-auto max-w-3xl min-w-max p-5 mb-5 relative">
		<form class="w-full shadow-md px-8 pt-6 pb-8"
			action="doLogin" method="POST"
			onsubmit="LoginForm__checkAndSubmit(this); return false;">
			<input type="hidden" name="redirectUrl" value="${param.redirectUrl}" />
			<input type="hidden" name="loginPw" />

			<div class="form-control">
				<input name="loginId" autofocus="autofocus" type="text"
					placeholder="아이디를 입력해주세요." class="input input-bordered"
					maxlength="20">
			</div>

			<div class="form-control mt-3 mb-4">
				<input name="loginPwInput" autofocus="autofocus" type="password"
					placeholder="비밀번호를 입력해주세요." class="input input-bordered"
					maxlength="30">
			</div>

			<div class="form-control mb-2">
				<input type="submit"
					class="btn btn-wide btn-sm mb-1 bg-gray-400 border-transparent w-full"
					value="로그인">
			</div>

			<div class="flex flex-col md:flex-row text-gray-600">
				<div class="p-1 text-center md:flex-grow">
					<i class="fas fa-home"></i>
					<a href="../home/main" class="inline-block hover:underline">홈</a>
					<a href="#" class="inline-block hover:underline"> | </a>
					<i class="fas fa-user"></i>
					<a href="join" class="inline-block hover:underline">회원가입</a>
					<a href="#" class="inline-block hover:underline"> | </a>
					<i class="fas fa-search"></i>
					<a href="findLoginId" class="inline-block hover:underline">아이디</a>
					<a href="#" class="inline-block hover:underline"> · </a>
					<a href="findLoginPw" class="inline-block hover:underline">비밀번호찾기</a>
				</div>
			</div>
		</form>

	</div>

</section>

<%@ include file="../part/foot.jspf"%>