<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
body {
	margin-top: 150px;
}
</style>

<script>
	const OrderAdd_checkAndSubmitDone = false;

	function OrderAdd__checkAndSubmit(form) {

		if (OrderAdd_checkAndSubmitDone) {
			return;
		}

		// 기본적인 처리
		form.orderName.value = form.orderName.value.trim();
		if (form.orderName.value.length == 0) {
			alert('이름을(받는 사람) 입력해주세요.');
			form.orderName.focus();
			return false;
		}

		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		if (form.cellphoneNo.value.length == 0) {
			alert('연락처를 입력해주세요.');
			form.cellphoneNo.focus();
			return;
		}

		form.post.value = form.post.value.trim();
		if (form.post.value.length == 0) {
			alert('우편번호를 입력해주세요.');
			form.post.focus();
			return false;
		}

		form.address.value = form.address.value.trim();
		if (form.address.value.length == 0) {
			alert('주소를 입력해주세요.');
			form.address.focus();
			return false;
		}

		form.detailAddress.value = form.detailAddress.value.trim();
		if (form.detailAddress.value.length == 0) {
			alert('상세주소를 입력해주세요.');
			form.detailAddress.focus();
			return false;
		}

		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return;
		}

		form.payment.value = form.payment.value.trim();
		if (form.payment.value.length == 0) {
			alert('결제방식 입력해주세요.');
			form.payment.focus();
			return false;
		}

		form.submit();
		OrderAdd_checkAndSubmitDone = true;

	}

	function findAddr() {
		new daum.Postcode({
			oncomplete : function(data) {

				console.log(data);

				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var roadAddr = data.roadAddress; // 도로명 주소 변수
				var jibunAddr = data.jibunAddress; // 지번 주소 변수
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('member_post').value = data.zonecode;
				if (roadAddr !== '') {
					document.getElementById("member_addr").value = roadAddr;
				} else if (jibunAddr !== '') {
					document.getElementById("member_addr").value = jibunAddr;
				}
			}
		}).open();
	}
</script>

<section class="section-order-add">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="pb-7">
			<span class="text-2xl ml-4 font-bold">주문하기</span>
		</div>
		
		<div class="px-4 py-4">
		
		</div>

		<div class="px-4 py-4">

			<form onsubmit="OrderAdd__checkAndSubmit(this); return false;"
				action="doAdd" method="POST" enctype="multipart/form-data">

				<input type="hidden" name="productId" value="${param.productId}" />
				<input type="hidden" name="categoryId" value="${param.categoryId}" />
				<input type="hidden" name="totalPayment" value="0" />

				<!-- name -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>이름</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input type="text" name="orderName"
							placeholder="받으 실 분의 이름을 입력해주세요." autofocus="autofocus"
							class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
					</div>
				</div>

				<!-- cellphoneNo -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>연락처</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input type="text" name="cellphoneNo"
							placeholder="-는 제외하고 입력해주세요." autofocus="autofocus"
							class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
					</div>
				</div>

				<!-- address (readonly: 읽기 전용) -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>우편주소</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input id="member_post" name="post" type="text" placeholder="우편번호"
							readonly onclick="findAddr()"
							class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
					</div>
				</div>

				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>주소지</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input id="member_addr" name="address" type="text"
							placeholder="주소지" readonly
							class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
					</div>
				</div>

				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>상세주소</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input type="text" name="detailAddress" placeholder="상세주소"
							class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
					</div>
				</div>

				<!-- email -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>이메일</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input type="email" name="email" placeholder="이메일을 입력해주세요."
							autofocus="autofocus"
							class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
					</div>
				</div>

				<!-- payment -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>결제 방식</span>
					</div>
					<div class="p-1 md:flex-grow">
						<select name="payment"
							class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
							<option disabled="disabled" selected="selected">결제방식을
								선택해주세요.</option>
							<option value="1">무통장입금</option>
						</select>
					</div>
				</div>

				<button
					class="btn btn-block btn-sm mt-7 mb-1 bg-white text-black hover:bg-black hover:text-white"
					type="submit">
					<span>결제하기</span>
				</button>

			</form>

		</div>
	</div>

</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>