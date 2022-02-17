<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
	const CategoryAdd_checkAndSubmitDone = false;

	let CategoryAdd__validCode = '';

	//조건 체크 함수 ajax
	function AddForm__checkCodeDup(obj) {

		const form = $('.formCode').get(0);

		form.code.value = form.code.value.trim();

		if (form.code.value.length == 0) {
			return;
		}

		$.get('getCodeDup', {
			code : form.code.value
		}, function(data) {
			let colorClass = 'text-green-500';
			if (data.fail) {
				colorClass = 'text-red-500';
			}
			$('.CodeInputMsg').html("<span class='" + colorClass + "'>" + data.msg + "</span>");
			if (data.fail) {
				form.code.focus();
			} else {
				CategoryAdd__validCode = data.body.code;
			}
		}, 'json');
	}

	function CategoryAdd__checkAndSubmit(form) {

		if (CategoryAdd_checkAndSubmitDone) {
			return;
		}

		// 기본적인 처리
		form.code.value = form.code.value.trim();
		if (form.code.value.length == 0) {
			alert('코드을 입력해주세요.');
			form.code.focus();
			return false;
		}

		if (form.code.value != CategoryAdd__validCode) {
			alert('코드 중복체크를 해주세요.');
			form.code.focus();
			return;
		}

		form.categoryName.value = form.categoryName.value.trim();
		if (form.categoryName.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.categoryName.focus();
			return;
		}

		form.submit();
		CategoryAdd_checkAndSubmitDone = true;
	}
	$(function() {
		$('.inputCode').change(function() {
			AddForm__checkCodeDup();
		});
		$('.inputCode').keyup(_.debounce(AddForm__checkCodeDup, 1000));
	});
</script>

<section class="section-category-add">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="pb-7">
			<span class="ml-4 text-2xl font-bold">카테고리 등록</span>
		</div>
		
		<div class="px-4 py-4">
		
			<form class="formCode" action="doAdd" method="POST"
				onsubmit="CategoryAdd__checkAndSubmit(this); return false;">

				<input type="hidden" name="memberId" value="${loginedMember.id}" />

				<!-- 코드 -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">코드</span>
					</label>
					<input type="text" name="code" placeholder="코드을 입력해주세요."
						autofocus="autofocus" class="inputCode input input-bordered">
				</div>

				<!-- 중복확인 -->
				<div class="form-control ml-1 mt-1">
					<div class="CodeInputMsg"></div>
				</div>


				<!-- 이름 -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">이름</span>
					</label>
					<input type="text" name="categoryName" placeholder="이름을 입력해주세요."
						autofocus="autofocus" class="input input-bordered">
				</div>

				<button
					class="btn btn-block btn-sm mt-7 mb-1 bg-white text-black hover:bg-black hover:text-white"
					type="submit">
					<span>작성</span>
				</button>
				
			</form>

		</div>
	</div>

</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>