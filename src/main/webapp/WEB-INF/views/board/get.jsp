<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css"
	integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	referrerpolicy="no-referrer"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>


<script>
	$(document).ready(function() {
		$("#edit-button1").click(function() {
			$("#input1").removeAttr("readonly");
			$("#textarea1").removeAttr("readonly");
			$("#modify-submit1").removeClass("d-none");
			$("#delete-submit1").removeClass("d-none");
		});

		$("#delete-submit1").click(function(e) {
			e.preventDefault();

			if (confirm("삭제하시겠습니까?")) {
				let form1 = $("#form1");
				let actionAttr = "${appRoot}/board/remove";
				form1.attr("action", actionAttr);

				form1.submit();
			}

		});

		// reply-edit-toggle 버튼 클릭시 댓글 보여주는 div 숨기고,
		// 수정 form 보여주기
		$(".reply-edit-toggle-button").click(function() {
			console.log("버튼클릭");
			const replyId = $(this).attr("data-reply-id");
			const displayDivId = "#replyDisplayContainer" + replyId;
			const editFormId = "#replyEditFormContainer" + replyId;

			console.log(replyId);
			console.log(displayDivId);
			console.log(editFormId);

			$(displayDivId).hide();
			$(editFormId).show();
		});

		// reply-delete-button 클릭시
		$(".reply-delete-button").click(function() {
			const replyId = $(this).attr("data-reply-id");
			const message = "댓글을 삭제하시겠습니까?";

			if (confirm(message)) {
				$("#replyDeleteInput1").val(replyId);
				$("#replyDeleteForm1").submit();
			}
		});
		
		// 페이지 로딩 후 reply list 가져오는 ajax 요청
		
		const data = {boardId : ${board.id}};
		$.ajax({
			url : "${appRoot}/reply/list",
			type : "get",
			data : data,
			success : function(list) {
				// console.log("댓글 가져 오기 성공");
				console.log(list);
				
				const replyListElement = $("#replyList1");
				for (let i = 0; i < list.length; i++) {
					const replyElement = $("<li class='list-group-item' />");
					replyElement.html(`
							
							<div id="replyDisplayContainer\${list[i].id }">
								<div class="fw-bold">
									<i class="fa-solid fa-comment"></i>
									\${list[i].prettyInserted}
									<span class="reply-edit-toggle-button badge bg-info text-dark"
										id="replyEditToggleButton\${list[i].id }"
										data-reply-id="\${list[i].id }">
										<i class="fa-solid fa-pen-to-square"></i>
									</span>
									<span class="reply-delete-button badge bg-danger"
										data-reply-id="\${list[i].id }">
										<i class="fa-solid fa-trash-can"></i>
									</span>
								</div>
								\${list[i].content }


							</div>

							<div id="replyEditFormContainer\${list[i].id }"
								style="display: none;">
								<form action="${appRoot }/reply/modify" method="post">
									<div class="input-group">
										<input type="hidden" name="boardId" value="${board.id }" />
										<input type="hidden" name="id" value="\${list[i].id }" />
										<input class="form-control" value="\${list[i].content }"
											type="text" name="content" required />
										<button class="btn btn-outline-secondary">
											<i class="fa-solid fa-comment-dots"></i>
										</button>
									</div>
								</form>
							</div>
							
							`);
					replyListElement.append(replyElement);
				}
			},
			error : function() {
				console.log("댓글 가져오기 실패");
			}
		});
		
		// addReplySubmitButton1 버튼 클릭시 ajax 댓글 추가 요청
		$("#addReplySubmitButton1").click(function(e) {
			e.preventDefault();
			
			const data = $("#insertReplyForm1").serialize();
			
			$.ajax({
				url : "${appRoot }/reply/insert",
				type : "post",
				data : data,
				success : function(data) {
					// 새 댓글 등록되었다는 메시지 출력
					$("#replyMessage1").show().text(data).fadeOut(3000);
					
					// text input 초기화 
					
					// 모든 댓글 가져오는 ajax 요청 
					console.log(data);
				},
				error : function() {
					console.log("문제 발생");
				},
				complete : function() {
					console.log("요청 완료");
				}
			});
		});
	});
</script>

<title>Insert title here</title>
</head>
<body>
	<my:navBar></my:navBar>
	<!-- .container>.row>.col>h1{글 본문} -->
	<div class="container">
		<div class="row">
			<div class="col">
				<h1>
					글 본문
					<button id="edit-button1" class="btn btn-secondary">
						<i class="fa-solid fa-pen-to-square"></i>
					</button>
				</h1>

				<c:if test="${not empty message }">
					<div class="alert alert-primary">${message }</div>
				</c:if>

				<form id="form1" action="${appRoot }/board/modify" method="post">
					<input type="hidden" name="id" value="${board.id }" />

					<div>
						<label class="form-label" for="input1">제목</label>
						<input class="form-control" type="text" name="title" required
							id="input1" value="${board.title }" readonly />
					</div>

					<div>
						<label class="form-label" for="textarea1">본문</label>
						<textarea class="form-control" name="body" id="textarea1"
							cols="30" rows="10" readonly>${board.body }</textarea>
					</div>

					<div>
						<label for="input2" class="form-label">작성일시</label>
						<input class="form-control" type="datetime-local"
							value="${board.inserted }" readonly />
					</div>

					<button id="modify-submit1" class="btn btn-primary d-none">수정</button>
					<button id="delete-submit1" class="btn btn-danger d-none">삭제</button>
				</form>

			</div>
		</div>
	</div>


	<%-- 댓글 추가 form --%>
	<!-- .container.mt-3>.row>.col>form -->
	<div class="container mt-3">
		<div class="row">
			<div class="col">
				<form id="insertReplyForm1">
					<div class="input-group">
						<input type="hidden" name="boardId" value="${board.id }" />
						<input class="form-control" type="text" name="content" required />
						<button id="addReplySubmitButton1" class="btn btn-outline-secondary">
							<i class="fa-solid fa-comment-dots"></i>
						</button>
					</div>
				</form>
			</div>
		</div>
		<div class="row">
			<div class="alert alert-primary" style="display:none; " id="replyMessage1"></div>
		</div>
	</div>

	<%-- 댓글 목록 --%>

	<!-- .container.mt-3>.row>.col -->
	<div class="container mt-3">
		<div class="row">
			<div class="col">
				<h3>댓글 ${board.numOfReply } 개</h3>

				<ul id="replyList1" class="list-group">
					<%-- 
					<c:forEach items="${replyList }" var="reply">
						<li class="list-group-item">
							<div id="replyDisplayContainer${reply.id }">
								<div class="fw-bold">
									<i class="fa-solid fa-comment"></i>
									${reply.prettyInserted}
									<span class="reply-edit-toggle-button badge bg-info text-dark"
										id="replyEditToggleButton${reply.id }"
										data-reply-id="${reply.id }">
										<i class="fa-solid fa-pen-to-square"></i>
									</span>
									<span class="reply-delete-button badge bg-danger"
										data-reply-id="${reply.id }">
										<i class="fa-solid fa-trash-can"></i>
									</span>
								</div>
								<c:out value="${reply.content }" />


							</div>

							<div id="replyEditFormContainer${reply.id }"
								style="display: none;">
								<form action="${appRoot }/reply/modify" method="post">
									<div class="input-group">
										<input type="hidden" name="boardId" value="${board.id }" />
										<input type="hidden" name="id" value="${reply.id }" />
										<input class="form-control" value="${reply.content }"
											type="text" name="content" required />
										<button class="btn btn-outline-secondary">
											<i class="fa-solid fa-comment-dots"></i>
										</button>
									</div>
								</form>
							</div>


						</li>
					</c:forEach>
					--%>
				</ul>
			</div>
		</div>
	</div>

	<%-- reply 삭제 form --%>
	<div class="d-none">
		<form id="replyDeleteForm1" action="${appRoot }/reply/delete"
			method="post">
			<input id="replyDeleteInput1" type="text" name="id" />
			<input type="text" name="boardId" value="${board.id }" />
		</form>
	</div>
</body>
</html>








