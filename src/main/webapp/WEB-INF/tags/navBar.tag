<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="current" %>

<c:url value="/board/list" var="listUrl"></c:url>
<c:url value="/board/insert" var="insertUrl"></c:url>
<c:url value="/member/signup" var="signupUrl" ></c:url>
<c:url value="/member/list" var="memberListUrl"></c:url>

<nav class="navbar navbar-expand-md navbar-light bg-light mb-3">
  <div class="container">
    <a class="navbar-brand" href="${listUrl }"><i class="fa-solid fa-house"></i></a>
    
    <!-- button.navbar-toggler>span.navbar-toggler-icon -->
    <button class="navbar-toggler" 
            data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent">
    	<span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link ${current == 'list' ? 'active' : '' }" href="${listUrl }">목록보기</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ${current == 'insert' ? 'active' : '' }" href="${insertUrl }">글쓰기</a>
        </li>
        <!-- li.nav-item>a.nav-link{회원가입} -->
        <li class="nav-item">
        	<a href="${signupUrl }" class="nav-link ${current == 'signup' ? 'active' : '' }">회원가입</a>
        </li>
        
        <li class="nav-item">
        	<a href="${memberListUrl }" class="nav-link ${current == 'memberList' ? 'active' : '' }">회원목록</a>
        </li>
      </ul>
      
      <!-- form.d-flex>input.form-control.me-2[type=search]+button.btn.btn-outline-success -->
      
      <form action="${listUrl }" class="d-flex">
      	<div class="input-group">
	      	<!-- select.form-select>option*3 -->
	      	<select name="type" id="" class="form-select" style="flex:0 0 100px;">
	      		<option value="all" ${param.type != 'title' && param.type != 'body' ? 'selected' : '' }>전체</option>
	      		<option value="title" ${param.type == 'title' ? 'selected' : '' }>제목</option>
	      		<option value="body" ${param.type == 'body' ? 'selected' : ''}>본문</option>
	      	</select>
	      
	      	<input type="search" class="form-control" name="keyword"/>
	      	<button class="btn btn-outline-success"><i class="fa-solid fa-magnifying-glass"></i></button>
      	</div>
      </form>
    </div>
  </div>
</nav>











