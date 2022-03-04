<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<!-- lodash -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<!-- sha256 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js"></script>

<script>
	const JoinForm__checkAndSubmitDone = false;

	//로그인 아이디 중복체크 함수 ajax
	let JoinForm__validLoginId = '';

	function JoinForm__checkLoginIdDup(obj) {

		const form = $('.formLogin').get(0);

		form.loginId.value = form.loginId.value.trim();

		if (form.loginId.value.length == 0) {
			return;
		}

		$.get('getLoginIdDup', {
			loginId : form.loginId.value
		}, function(data) {

			let colorClass = 'text-green-500';

			if (data.fail) {
				colorClass = 'text-red-500';
			}

			$('.loginIdInputMsg').html("<span class='" + colorClass + "'>" + data.msg + "</span>");

			if (data.fail) {
				form.loginId.focus();
			}

			else {
				JoinForm__validLoginId = data.body.loginId;
			}

		},

		'json');
	}

	function JoinForm__checkAndSubmit(form) {

		if (JoinForm__checkAndSubmitDone) {
			return;
		}

		form.loginId.value = form.loginId.value.trim();

		if (form.loginId.value.length == 0) {
			alert('아이디를 입력해주세요.');
			form.loginId.focus();

			return;
		}

		if (form.loginId.value != JoinForm__validLoginId) {
			alert('입력하신 아이디를 확인해 주세요.');
			form.loginId.focus();

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
			alert('이메일를 입력해주세요.');
			form.email.focus();

			return;
		}

		form.cellphoneNo.value = form.cellphoneNo.value.trim();

		if (form.cellphoneNo.value.length == 0) {
			alert('전화번호를 입력해주세요.');
			form.cellphoneNo.focus();

			return;
		}

		form.loginPw.value = sha256(form.loginPwInput.value);
		form.loginPwInput.value = '';
		form.loginPwConfirm.value = '';

		form.submit();
		JoinForm__checkAndSubmitDone = true;
	}

	$(function() {
		$('.inputLoginId').change(function() {
			JoinForm__checkLoginIdDup();
		});

		$('.inputLoginId').keyup(_.debounce(JoinForm__checkLoginIdDup, 1000));
	});
</script>

<style>
body {
	margin-top: 125px;
}
</style>


<section class="section-adm-member-join">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child ">

		<div class="pb-7">
			<span class="ml-4 text-2xl font-bold">회원가입</span>
		</div>

		<div class="px-4 py-4">
			<form class="formLogin grid form-type-1" action="doJoin"
				method="POST"
				onsubmit="JoinForm__checkAndSubmit(this); return false;">

				<input type="hidden" name="redirectUrl" value="${param.redirectUrl}" />
				<input type="hidden" name="loginPw" />
				<input type="hidden" name="authLevel" value="3" />

				<!-- loginId -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>아이디</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input type="text" name="loginId"
							placeholder="영문 혹은 영문+숫자만 입력해주세요." autofocus="autofocus"
							class="inputLoginId shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
					</div>
				</div>

				<!-- 아이디 중복여부를 ajax로 물어봄 -->
				<div class="form-control">
					<div class="loginIdInputMsg"></div>
				</div>

				<!-- 비밀번호 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>비밀번호</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input autofocus="autofocus" type="password" maxlength="30"
							placeholder="영문+숫자 조합으로 입력해주세요." name="loginPwInput"
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

				<!-- name -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>이름</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input autofocus="autofocus" type="text" placeholder="이름을 적어주세요."
							name="name" maxlength="20"
							class="inputLoginId shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
					</div>
				</div>

				<!-- email -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>email</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input autofocus="autofocus" type="email" placeholder=""
							name="email" maxlength="100"
							class="inputLoginId shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
					</div>
				</div>

				<!-- cellphoneNo -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>전화번호</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input autofocus="autofocus" type="tel" maxlength="11"
							placeholder="-는 제외해주세요. ex) 01000000000" name="cellphoneNo"
							class="inputLoginId shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
					</div>
				</div>

				<button
					class="btn btn-block btn-sm mt-7 mb-1 bg-white text-black hover:bg-black hover:text-white"
					type="submit">
					<span>가입하기</span>
				</button>

			</form>
		</div>
	</div>
</section>


<%@ include file="../part/mainLayoutFoot.jspf"%>
