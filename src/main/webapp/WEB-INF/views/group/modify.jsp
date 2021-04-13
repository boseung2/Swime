<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>

<div class="container">
    <h2>모임 정보 수정</h2>
    <hr/>
    <form role="form" action="/group/modify" method="post">
        <div class="form-group">
            <label for="sn">모임번호</label>
            <input type="text" class="form-control" id="sn" name="sn" value="<c:out value="${group.sn}"/>" readonly="readonly">
        </div>
        <div class="form-group">
            <label for="userId">아이디</label>
            <input type="text" class="form-control" id="userId" name="userId" value="<c:out value="${group.userId}"/>" readonly="readonly">
        </div>
        <div class="form-group">
            <label for="category">카테고리</label>
            <select class="form-control" id="category" name="category">
                <option>------</option>
                <option value="GRCA01">프론트엔드</option>
                <option value="GRCA02">백엔드</option>
                <option value="GRCA03">앱 개발</option>
                <option value="GRCA04">게임 개발</option>
                <option value="GRCA05">프로그래밍 언어</option>
                <option value="GRCA06">알고리즘</option>
                <option value="GRCA07">데이터 사이언스</option>
                <option value="GRCA08">데이터베이스</option>
                <option value="GRCA09">컴퓨터 사이언스</option>
                <option value="GRCA10">개발 도구</option>
                <option value="GRCA11">교양 · 기타</option>
            </select>
        </div>
        <div class="form-group">
            <label for="name">모임이름</label>
            <input type="text" class="form-control" name="name" id="name" value="<c:out value="${group.name}"/>">
        </div>
        <div class="form-group">
            <label for="picture">대표사진</label>
            <input type="text" class="form-control" id="picture" name="picture" value="<c:out value="${group.picture}"/>">
        </div>
        <div class="form-group">
            <label for="description">한줄소개</label>
            <textarea class="form-control" rows="1" id="description" name="description"><c:out value="${group.description}"/></textarea>
        </div>
        <div class="form-group">
            <label for="info">정보 (모임에 대해 자세히 적어주세요)</label>
            <textarea class="form-control" rows="5" id="info" name="info"><c:out value="${group.info}"/></textarea>
        </div>
        <div class="form-row">
            <div class="col">
            <label for="sido">시/도</label>
            <select class="form-control" id="sido" name="sido">
                <option value="LOSI01">서울시</option>
                <option value="LOSI02">경기도</option>
            </select>
            </div>
            <div class="col">
                <label for="sigungu">시/군/구</label>
                <select class="form-control" id="sigungu" name="sigungu">
                    <option value="LOGU01">1</option>
                    <option value="LOGU01">2</option>
                    <option value="LOGU01">3</option>
                    <option value="LOGU01">4</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="tags">태그</label>
            <input type="text" class="form-control" name="tags" id="tags" value="<c:out value="${group.tags}"/>">
        </div>
        <div class="form-group">
            <label for="updDate" hidden></label>
            <input type="date" class="form-control" name="updDate" id="updDate" value="<fmt:formatDate value="${group.updDate}" pattern="yyyy/MM/dd"/>" hidden>
            <input type="number" class="form-control" name="attendCount" id="attendCount" value="<c:out value="${group.attendCount}"/>" hidden>
            <input type="number" class="form-control" name="rating" id="rating" value="<c:out value="${group.rating}"/>" hidden>
            <input type="number" class="form-control" name="ratingCount" id="ratingCount" value="<c:out value="${group.ratingCount}"/>" hidden>
            <input type="text" class="form-control" name="status" id="status" value="<c:out value="${group.status}"/>" hidden>
        </div>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
        <input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
        <button type="submit" class="btn btn-primary" data-oper="modify">수정</button>
        <button type="submit" class="btn btn-warning" data-oper="remove">삭제</button>
        <button type="submit" class="btn btn-secondary" data-oper="list">목록</button>
    </form>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        let formObj = $('form');

        $('button').on("click", function(e) {

            e.preventDefault();

            let operation = $(this).data('oper');

            console.log(operation);

            if(operation === 'remove') {
                formObj.attr("action", "/group/remove");
            } else if (operation === 'list') {
                formObj.attr("action", '/group/list').attr("method", "get");
                let pageNumTag = $("input[name='pageNum']").clone();
                let amountTag = $("input[name='amount']").clone();

                formObj.empty();
                formObj.append(pageNumTag);
                formObj.append(amountTag);
            }
            formObj.submit();
        })
    })
</script>








<%@include file="../includes/footer.jsp" %>
