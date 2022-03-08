<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
html, body {
	margin-top: 125px;
}

body {
	margin: 0;
	padding: 0;
}

th, td {
	padding: 10px;
}
</style>

<section class="section-usr-mypage-detail">

	<div class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative">

		<div class="pb-7">
			<span class="ml-4 text-2xl font-bold">내 정보</span>
		</div>

		<!-- 제품 정보 -->
		<div class="">
			<table class="container text-center max-w-3xl min-w-max mx-auto">

				<tr class="border-b border-gray-400">
					<th>아이디</th>
					<td>${member.loginId}</td>
				</tr>

				<tr>
					<th>이름</th>
					<td>${loginedMember.name}</td>
				</tr>

			</table>
		</div>

		<div
			class="container flex justify-center items-center text-center text-lg font-bold">

			<div
				class="w-1/2 border border-gray-400 hover:bg-black hover:text-gray-50">
				<a
					href="checkPassword?afterUrl=${Util.getUrlEncoded('../member/modify')}">
					<span>수정</span>
				</a>
			</div>

			<div class="mx-1"></div>
			
			<div
				class="w-1/2 border border-gray-400 hover:bg-black hover:text-gray-50">
				<a href="doDelete?id=${member.id}"
					onclick="if ( !confirm('회원을 탈퇴하시겠습니까?') ) return false;"
					class="text-red-500 ">
					<span>탈퇴</span>
				</a>
			</div>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>