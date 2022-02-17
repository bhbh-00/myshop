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
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child ">

		<div class="ml-4 pb-7">
			<span class="text-2xl font-bold">카테고리 수정</span>
		</div>

		<div class="px-4 py-8">

			<form class="formCategoryName grid form-type-1"
				onsubmit="CategoryModify_checkAndSubmit(this); return false;"
				action="doModify" method="POST" enctype="multipart/form-data">

				<input type="hidden" name="id" value="${category.id}" />
				<input type="hidden" name="redirectUrl" value="${param.redirectUrl}" />

				<!-- 번호 -->
				<div class="form-control">
					<label class="cursor-pointer label"> 번호 </label>
					<div class="plain-text">${category.id}</div>
				</div>

				<!-- 등록날짜 -->
				<div class="form-control">
					<label class="cursor-pointer label"> 등록날짜 </label>
					<div class="plain-text">${category.regDate}</div>
				</div>

				<!-- 수정날짜 -->
				<c:if test="${category.updateDate != category.regDate}">
					<div class="form-control">
						<label class="cursor-pointer label"> 수정날짜 </label>
						<div class="plain-text">${category.updateDate}</div>
					</div>
				</c:if>

				<!-- 코드 -->
				<div class="form-control">
					<label class="cursor-pointer label"> 코드 </label>
					<div class="plain-text">${category.code}</div>
				</div>

				<!-- 이름 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">이름</span>
					</label>
					<input type="text" name="categoryName" placeholder="이름"
						class="inputCategoryName input input-bordered" maxlength="20"
						value="${category.categoryName}">
				</div>

				<!-- 중복확인 -->
				<div class="form-control">
					<div class="CategoryNameInputMsg"></div>
				</div>

				<div>
					<button class="btn btn-ghost btn-sm mb-1 text-blue-500"
						type="submit">
						<i class="fas fa-edit mr-1"></i>
						<span>수정</span>
					</button>

					<button onclick="history.back();"
						class="btn btn-ghost btn-sm mb-1 text-red-500">
						<i class="fas fa-trash mr-1"></i>
						<span>취소</span>
					</button>
				</div>

			</form>

		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>