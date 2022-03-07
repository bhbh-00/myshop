<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<!-- sha256 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	const checkPasswordForm__checkAndSubmitDone = false;
	function checkPasswordForm__checkAndSubmit(form) {
		if (checkPasswordForm__checkAndSubmitDone) {
			return;
		}
		form.loginPwInput.value = form.loginPwInput.value.trim();
		if (form.loginPwInput.value.length == 0) {
			alert('비밀번호를 입력해주세요.');
			form.loginPwInput.focus();
			return;
		}
		form.loginPw.value = sha256(form.loginPwInput.value);
		form.loginPwInput.value = '';
		form.submit();
		checkPasswordForm__checkAndSubmitDone = true;
	}
</script>

<section class="section-checkPassword">

	<div class="container mx-auto max-w-3xl min-w-max p-5 mb-5 relative">

		<form class="w-full shadow-md px-8 pt-6 pb-8" action="doCheckPassword"
			method="POST"
			onsubmit="checkPasswordForm__checkAndSubmit(this); return false;">

			<div class="pb-7">
				<i class="fas fa-user-cog"></i>
				<span class="ml-4 text-2xl font-bold">비밀번호 확인</span>
			</div>

			<input type="hidden" name="checkPasswordAuthCode"
				value="${param.checkPasswordAuthCode}">
			<input type="hidden" name="loginPw" />


			<div class="form-control mt-3 mb-4">
				<input name="loginPwInput" autofocus="autofocus" type="password"
					placeholder="비밀번호를 입력해주세요." class="input input-bordered"
					maxlength="30">
			</div>

			<div class="form-control mb-2">
				<input type="submit"
					class="btn btn-wide btn-sm mb-1 bg-gray-400 border-transparent w-full"
					value="확인">
			</div>

			<div class="flex flex-col md:flex-row">
				<div class="p-1 text-center md:flex-grow">
					<a href="findLoginPw"
						class="text-gray-600 inline-block hover:underline">비밀번호 찾기</a>
				</div>
			</div>
		</form>
	</div>
	
</section>


<%@ include file="../part/foot.jspf"%>