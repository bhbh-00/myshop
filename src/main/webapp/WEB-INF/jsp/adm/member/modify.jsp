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

<script>
	const ModifyMember_checkAndSubmitDone = false;
	
	function ModifyMember_checkAndSubmit(form) {
		if (ModifyMember_checkAndSubmitDone) {
			return;
		}

		form.authLevel.value = form.authLevel.value.trim();
		if (form.authLevel.value.length == 0) {
			alert('회원타입을 선택해주세요.');
			form.authLevel.focus();
			return;
		}
		
		form.submit();
		ModifyMember_checkAndSubmitDone = true;
	}
</script>

<section class="section-usr-member-modify">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child ">

		<div class="flex pb-7">
			<div class="items-center ml-2">
				<span class="ml-4 text-2xl font-bold">회원정보 수정</span>
			</div>
		</div>

		<div class="px-4 py-4">

			<form class="grid form-type-1" action="doModify" method="POST"
				onsubmit="ModifyMember_checkAndSubmit(this); return false;">

				<input type="hidden" name="id" value="${member.id}" />
				<input type="hidden" name="authLevel" value="${member.authLevel}" />

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

				<!-- 회원타입 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>회원타입</span>
					</div>
					<div class="p-1 md:flex-grow">
						<select name="authLevel"
							class="select select-auth-level appearance-none border rounded w-full py-2 px-3 text-grey-darker">
							<option disabled="disabled" selected="selected">회원타입을
								선택해주세요.</option>
							<option value="3">일반</option>
							<option value="7">관리자</option>
						</select>
						<script>
							const memberAuthLevel = parseInt("${member.authLevel}");
						</script>
						<script>
							$('.section-adm-member-modify .select-auth-level').val(memberAuthLevel);
						</script>
					</div>
				</div>

				<!-- 이름 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>이름</span>
					</div>
					<div class="p-1 md:flex-grow">${member.name}</div>
				</div>

				<!-- 이메일 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>이메일</span>
					</div>
					<div class="p-1 md:flex-grow">${member.email}</div>
				</div>

				<!-- 전화번호 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>전화번호</span>
					</div>
					<div class="p-1 md:flex-grow">${member.cellphoneNo}</div>
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