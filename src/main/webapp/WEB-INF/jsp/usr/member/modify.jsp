<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
body {
	margin-top: 125px;
}
</style>

<!-- lodash -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<!-- sha256 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	const ModifyMember_checkAndSubmitDone = false;
	function ModifyMember_checkAndSubmit(form) {
		if (ModifyMember_checkAndSubmitDone) {
			return;
		}
		form.loginPwInput.value = form.loginPwInput.value.trim();
		if (form.loginPwInput.value.length == 0) {
			alert('비밀번호를 입력해주세요.');
			form.loginPwInput.focus();
			return;
		}
		if (form.loginPwConfirm.value.length == 0) {
			alert('비밀번호를 확인해주세요.');
			form.loginPwConfirm.focus();
			return;
		}
		if (form.loginPwInput.value != form.loginPwConfirm.value) {
			alert('비밀번호가 일치하지 않습니다.');
			form.loginPwConfirm.focus();
			return;
		}
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.name.focus();
			return;
		}
		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}
		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		if (form.cellphoneNo.value.length == 0) {
			alert('휴대전화번호를 입력해주세요.');
			form.cellphoneNo.focus();
			return;
		}
		form.loginPw.value = sha256(form.loginPwInput.value);
		form.loginPwInput.value = '';
		form.loginPwConfirm.value = '';

		form.submit();
		ModifyMember_checkAndSubmitDone = true;
	}
</script>

<section class="section-usr-member-modify">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child ">

		<div class="flex pb-7">
			<div class="items-center ml-2">
				<span class="ml-4 text-2xl font-bold">내 정보 수정</span>
			</div>
		</div>

		<div class="px-4 py-4">

			<form class="grid form-type-1" action="doModify" method="POST"
				onsubmit="ModifyMember_checkAndSubmit(this); return false;">

				<input type="hidden" name="id" value="${member.id}" />
				<input type="hidden" name="loginPw" />
				<input type="hidden" name="authLevel" value="${member.authLevel}" />
				<input type="hidden" name="checkPasswordAuthCode"
					value="${param.checkPasswordAuthCode}">

				<!-- 등록날짜 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>가입날짜</span>
					</div>
					<div class="p-1 md:flex-grow">${member.regDate}</div>
				</div>

				<!-- 수정날짜 -->
				<c:if test="${member.regDate != member.updateDate}">
					<div class="flex flex-col mb-4 md:flex-row">
						<div class="p-1 md:w-36 md:flex md:items-center">
							<span>수정날짜</span>
						</div>
						<div class="p-1 md:flex-grow">${member.updateDate}</div>
					</div>
				</c:if>

				<!-- 아이디 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>아이디</span>
					</div>
					<div class="p-1 md:flex-grow">${member.loginId}</div>
				</div>

				<!-- 비밀번호 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>비밀번호</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input autofocus="autofocus" type="password" maxlength="30"
							placeholder="비밀번호를 입력해주세요." name="loginPwInput"
							class="inputLoginId shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
					</div>
				</div>

				<!-- 비밀번호 확인 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>비밀번호 확인</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input autofocus="autofocus" type="password"
							placeholder="비밀번호와 일치해야합니다." name="loginPwConfirm" maxlength="30"
							class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
					</div>
				</div>

				<!-- 이름 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>이름</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input type="text" placeholder="이름 입력해주세요." name="name"
							class="hadow appearance-none border rounded w-full py-2 px-3 text-grey-darker"
							value="${member.name}">
					</div>
				</div>

				<!-- 이메일 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>이메일</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input type="email" name="email"
							class="hadow appearance-none border rounded w-full py-2 px-3 text-grey-darker"
							value="${member.email}">
					</div>
				</div>

				<!-- 전화번호 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>전화번호</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input type="text" name="cellphoneNo"
							class="hadow appearance-none border rounded w-full py-2 px-3 text-grey-darker"
							value="${member.cellphoneNo}">
					</div>
				</div>

				<button
					class="btn btn-block btn-sm mb-1 bg-white text-black hover:bg-black hover:text-white"
					type="submit">
					<span>수정</span>
				</button>

			</form>

		</div>
	</div>

</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>