<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

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

		const form = $('.formName').get(0);
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			return;
		}
		$.get('getNameDup', {
			name : form.name.value
		}, function(data) {
			let colorClass = 'text-green-500';
			if (data.fail) {
				colorClass = 'text-red-500';
			}
			$('.NameInputMsg').html("<span class='" + colorClass + "'>" + data.msg + "</span>");
			if (data.fail) {
				form.name.focus();
			} else {
				CategoryModify__validName = data.body.name;
			}
		}, 'json');
	}

	function CategoryModify_checkAndSubmit(form) {

		if (CategoryModify_checkAndSubmitDone) {
			return;
		}

		// 기본적인 처리
		form.code.value = form.code.value.trim();
		if (form.code.value.length == 0) {
			alert('코드을 입력해주세요.');
			form.code.focus();
			return false;
		}

		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.name.focus();
			return;
		}

		if (form.name.value != CategoryModify__validName) {
			alert('이름 중복체크를 해주세요.');
			form.name.focus();
			return;
		}

		form.submit();
		CategoryModify_checkAndSubmitDone = true;
	}
	$(function() {
		$('.inputName').change(function() {
			CategoryModify__validName();
		});
		$('.inputName').keyup(_.debounce(CategoryModify__validName, 1000));
	});
</script>

<section class="section-category-modify">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child ">

		<div class="ml-4 pb-7">
			<span class="text-2xl font-bold">카테고리 수정</span>
		</div>

		<div class="px-4 py-8">

			<form class="formCode grid form-type-1"
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
					<input type="text" name="name" placeholder="이름"
						class="inputName input input-bordered" maxlength="20"
						value="${category.name}">
				</div>

				<!-- 중복확인 -->
				<div class="form-control">
					<div class="NameInputMsg"></div>
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
	</div>
	</div>

</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>