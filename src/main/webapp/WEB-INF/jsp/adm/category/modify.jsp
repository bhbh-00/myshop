<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<!-- lodash -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<style>
body {
	margin-top: 150px;
}

th, td {
	padding: 10px;
}
</style>

<script>
	const CategoryModify_checkAndSubmitDone = false;

	let CategoryModify__validName = '';

	//조건 체크 함수 ajax
	function ModifyForm__checkCodeDup(obj) {

		const form = $('.formCategoryName').get(0);

		form.categoryName.value = form.categoryName.value.trim();

		if (form.categoryName.value.length == 0) {
			return;
		}
		$.get('getNameDup', {
			categoryName : form.categoryName.value
		}, function(data) {
			let colorClass = 'text-green-500';
			if (data.fail) {
				colorClass = 'text-red-500';
			}
			$('.CategoryNameInputMsg').html("<span class='" + colorClass + "'>" + data.msg + "</span>");
			if (data.fail) {
				form.categoryName.focus();
			} else {
				CategoryModify__validName = data.body.categoryName;
			}
		}, 'json');
	}

	function CategoryModify_checkAndSubmit(form) {

		if (CategoryModify_checkAndSubmitDone) {
			return;
		}

		// 기본적인 처리
		form.categoryName.value = form.categoryName.value.trim();
		
		if (form.categoryName.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.categoryName.focus();
			return;
		}

		if (form.categoryName.value != CategoryModify__validName) {
			alert('이름 중복체크를 해주세요.');
			form.categoryName.focus();
			return;
		}

		form.submit();
		CategoryModify_checkAndSubmitDone = true;
	}
	$(function() {
		$('.inputCategoryName').change(function() {
			ModifyForm__checkCodeDup();
		});
		$('.inputCategoryName').keyup(_.debounce(ModifyForm__checkCodeDup, 1000));
	});
</script>

<section class="section-category-modify">
	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="flex pb-7">
			<div class="items-center ml-2">
				<span class="ml-4 text-2xl font-bold">카테고리 수정</span>
			</div>

			<div class="flex-grow"></div>

			<div class="flex items-center mr-4 text-gray-500">
				<button onclick="history.back();">
					<i class="fas fa-backspace"></i>
					<span>이전</span>
				</button>
			</div>
		</div>

		<div>
			<form class="formCategoryName grid form-type-1"
				onsubmit="CategoryModify_checkAndSubmit(this); return false;"
				action="doModify" method="POST" enctype="multipart/form-data">

				<input type="hidden" name="id" value="${category.id}" />
				<input type="hidden" name="redirectUrl" value="${param.redirectUrl}" />
				<table
					class="container max-w-3xl min-w-max mx-auto item-bt-1-not-last-child text-center h-6">
					<tr>
						<th>번호</th>
						<td>${category.id}</td>
					</tr>
					<tr>
						<th>등록날짜</th>
						<td>${category.regDate}</td>
					</tr>
					<!-- 수정날짜 -->
					<c:if test="${category.updateDate != category.regDate}">
						<tr>
							<th>수정날짜</th>
							<td>${category.updateDate}</td>
						</tr>

					</c:if>
					<tr>
						<th>코드</th>
						<td>${category.code}</td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" name="categoryName" placeholder="이름"
								class="inputCategoryName input input-bordered" maxlength="20"
								value="${category.categoryName}"></td>
					</tr>

					<tr>
						<th></th>
						<td class="CategoryNameInputMsg"></td>
					</tr>


					<tr>
						<th></th>
						<td>
							<button type="submit">
								<span>수정</span>
							</button>
						</td>
					</tr>
				</table>

			</form>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>