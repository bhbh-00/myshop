<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<script>
	<!--  자바스크립트  -->
		const findLoginId__checkAndSubmitDone = false;
		<!--  const = var / 중복 방지를 위한.  -->
		function findLoginId__checkAndSubmit(form) {
			if ( findLoginId__checkAndSubmitDone ) {
				return;
			}
		
			form.name.value = form.name.value.trim();
			if ( form.name.value.length == 0 ) {
				alert('이름을 입력해주세요.');
				form.name.focus();
				
				return;
			}
			
			form.email.value = form.email.value.trim();
			
			if ( form.email.value.length == 0 ) {
				alert('이메일을 입력해주세요.');
				form.email.focus();
				
				return;
			}
			
			form.submit();
			findLoginId__checkAndSubmitDone = true;
		}
		
	
	</script>
<section class="section-usr-login">

	<div class="container mx-auto max-w-3xl min-w-max p-5 mb-5 relative">

		<form class="w-full shadow-md px-8 pt-6 pb-8" action="doFindLoginId"
			method="POST"
			onsubmit="findLoginId__checkAndSubmit(this); return false;">

			<input type="hidden" name="redirectUrl" value="${param.redirectUrl}" />

			<div class="pb-7">
				<span class="text-2xl font-bold">아이디 찾기</span>
			</div>

			<div class="flex flex-col mb-4 md:flex-row">
				<div class="p-1 md:w-36 md:flex md:items-center">
					<span>이름</span>
				</div>
				<div class="p-1 md:flex-grow">
					<input type="text" name="name" placeholder="이름을 입력해주세요."
						autofocus="autofocus" maxlength="20"
						class="inputLoginId shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
				</div>
			</div>

			<!-- email -->
			<div class="flex flex-col mb-4 md:flex-row">
				<div class="p-1 md:w-36 md:flex md:items-center">
					<span>이메일</span>
				</div>
				<div class="p-1 md:flex-grow">
					<input autofocus="autofocus" type="email"
						placeholder="이메일를 입력해주세요." name="email" maxlength="100"
						class="inputLoginId shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
				</div>
			</div>

			<div class="form-control mb-2">
				<input type="submit"
					class="btn btn-wide btn-sm mb-1 bg-gray-400 border-transparent w-full"
					value="찾기">
			</div>

			<div class="flex flex-col md:flex-row text-gray-600">
				<div class="p-1 text-center md:flex-grow">
					<i class="fas fa-sign-in-alt"></i>
					<a href="login" class="inline-block hover:underline">로그인</a>
					<a href="#" class="inline-block hover:underline"> | </a>
					<i class="fas fa-user"></i>
					<a href="join" class="inline-block hover:underline">회원가입</a>
					<a href="#" class="inline-block hover:underline"> | </a>
					<i class="fas fa-search"></i>
					<a href="findLoginPw" class="inline-block hover:underline">비밀번호찾기</a>
				</div>
			</div>
		</form>

	</div>


</section>
<%@ include file="../part/foot.jspf"%>