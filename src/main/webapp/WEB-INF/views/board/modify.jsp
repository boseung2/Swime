
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../../../resources/css/boardModify.css">


<div class="container">
    <h2>게시글 수정하기</h2>

    <form id="modifyForm" role="form"  method="post">


        <div class="form-group">
            <label for="name">아이디</label>
            <input type="text" class="form-control" id="name" name="name"
                   value="${board.userId}" readonly="readonly">
        </div>

        <div class="form-group">
            <label for="sn">번호</label>
            <input type="text" class="form-control" name="sn" id="sn"
                   value="${board.sn}" readonly="readonly">
        </div>


        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" class="form-control" name="title" id="title" value="${board.title}">
        </div>

        <div class="form-group">
            <label for="content">내용</label>
            <textarea class="form-control" rows="5" id="content" name="content">${board.content}</textarea>
        </div>

<%--        <div class="form-group">--%>
<%--            <label for="picture">사진</label>--%>
<%--            <input type="file" class="form-control" id="picture" name="picture">--%>
<%--        </div>--%>

        <div class="form-group uploadDiv">
            <label for="uploadFile">첨부파일</label>
            <input multiple="multiple" type="file" class="form-control" id="uploadFile" name="uploadFile" >

            <ul class="uploadResult">

            </ul>

        </div>


        <div class="form-check">
            <c:choose>
                <c:when test="${group.grpRole ne 'GRRO03'}">
                    <input class="form-check-input" type="checkbox" id="topFix_CKBox" name="topFix_CKBox">
                    <label class="form-check-label" for="topFix_CKBox">게시물 상위고정</label>
                    <input type="hidden" id="topFix" name="topFix" value="BOFI01">
                </c:when>
                <c:otherwise>
                    <input class="hiddenTop" type="hidden" id="topFix2" name="topFix" value="BOFI01">
                </c:otherwise>
            </c:choose>
        </div>


        <input type="hidden" name="status" value="${board.status}">
<%--        <input type="text" name="pageNum" value="${cri.pageNum}">--%>
<%--        <input type="text" name="amount" value="${cri.amount}">--%>
        <input type="hidden" class="form-control" id="grpSn" name="grpSn" value="${board.grpSn}">

        <sec:authentication property="principal" var="pinfo"/>
        <sec:authorize access="isAuthenticated()">
            <c:choose>
                <c:when test="${group.grpRole ne 'GRRO03'}">
                    <button id='modifyBtn' type="submit" data-oper="modify" class="btn btn-primary">수정</button>
                    <button type="submit" data-oper="remove" class="btn btn-danger">삭제</button>
                </c:when>
                <c:when test="${pinfo.username eq board.userId}">
                    <button id='modifyBtn' type="submit" data-oper="modify" class="btn btn-primary">수정</button>
                    <button type="submit" data-oper="remove" class="btn btn-danger">삭제</button>
                </c:when>
            </c:choose>
        </sec:authorize>
                <button type="submit" data-oper="list" class="btn btn-dark">목록</button>
<%--        <a id="back" class="btn btn-dark">취소</a>--%>

        <%--        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">--%>
        <sec:csrfInput/>
    </form>
</div>

<script type="text/javascript">

    $(document).ready(function(){
        //게시물이 상위고정이면 checkbox에 체크상태가 되게 한다.
        let isTopChecked = '<c:out value="${board.topFix}"/>';
        console.log(isTopChecked);

        if(isTopChecked === "BOFI02") {
            $("input[type='checkbox']").prop("checked", true);
            $("input[name='topFix']").val("BOFI02");
        }

        $('#topFix_CKBox').on("click", function () {
            console.log("ck box");
            let ischecked = $("input[type='checkbox']").is(":checked");
            console.log(ischecked);//true/false

            if (ischecked) {
                console.log("if");
                // $("input[name='topFix']").attr('value', 'BOFI02');
                $("input[name='topFix']").val("BOFI02");
            }else{
                console.log("else");
                // $("input[name='topFix']").attr('value', 'BOFI01');
                $("input[name='topFix']").val("BOFI01");

            }
        });//end topFix

        // $("#back").on("click", function(){
        //     window.history.back();
        // });
        let formObj = $("#modifyForm");

        $("button").on("click", function(e){
            e.preventDefault();

            let operation = $(this).data('oper');

            console.log("operation : "+operation);

            if(operation === 'remove') {
                formObj.attr("action", "/board/remove");
                formObj.submit();
            } else if (operation === 'list') {
                console.log("list !!!!!!!!!!!!!!");
                formObj.attr("action", '/group/get').attr("method", "get");
                formObj.find("input[name='sn']").remove();
                formObj.find("input[name='name']").remove();
                formObj.find("input[name='title']").remove();
                formObj.find("textarea[name='content']").remove();
                formObj.find("input[name='_csrf']").remove();
                formObj.find("input[name='picture']").remove();
                formObj.find("input[name='post']").remove();
                formObj.find("input[name='topFix']").remove();
                formObj.find("input[name='grpSn']").remove();
                formObj.find("input[name='status']").remove();
                //수정..
                formObj.find("input[name='uploadFile']").remove();
                formObj.append("<input type='hidden' name = 'sn' value='" + ${board.grpSn} + "'>");
                formObj.submit();
                // let pageNumTag = $("input[name='pageNum']").clone();
                // let amountTag = $("input[name='amount']").clone();
                // formObj.empty();
                // formObj.append(pageNumTag);
                // formObj.append(amountTag);
            } else if(operation === 'modify'){
                //e.preventDefault();
                console.log("submit clicked.........");
                //formObj.attr("action", "/board/modify");
                let str = "";

                if(!validation()) {
                    return;
                }



                $('ul.uploadResult li').each(function(i,obj){

                    let jobj = $(obj);
                    console.log("uploadResult.each()........");
                    console.dir(jobj);

                    str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
                    str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
                    str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
                    str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";

                });
                formObj.append(str).submit();

            }
            formObj.submit();
            // alert("asda");
        });

        function validation(){
            // getByte($("input[id='title']").val()) == ""
            if($("input[id='title']").val().trim().length == 0) {
                alert("제목을 입력해주세요.");
                return false;
            }else if(getByte($("input[id='title']").val()) > 200){
                alert("게시글 제목을 65자 이하로 작성해주세요.");
                return false;
            }
            //getByte($("textarea[id='content']").val()) == ""
            if($("textarea[id='content']").val().trim().length == 0) {
                alert("내용을 입력해주세요");
                return false;

            }else if(getByte($("textarea[id='content']").val()) > 4000){
                alert("게시글 내용이 너무 깁니다.");
                return false;
            }
            return true;
        }

        function getByte(str){
            let byte = 0;
            for(let i = 0; i<str.length; ++i){
                (str.charCodeAt(i) > 127) ? byte += 3 : byte++;
            }
            return byte;
        }


    });

</script>
<script>
    $(document).ready(function (){

        let regex = new RegExp("(.*?)\.(exe|sh|zip|alz|)$");
        let maxSize = 5242880;
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";


        (function(){

        let brdSn = '<c:out value="${board.sn}"/>';
        console.log(brdSn);
            //게시판 상세 조회 시 첨부파일
            $.getJSON("/board/getAttachList", {brdSn : brdSn}, function(arr){
                console.log("게시판 brdSn" + brdSn)
                console.log(arr);


                let str = "";


                $(arr).each(function(i, attach) {

                    console.log(attach.fileType);//true.false 이미지 첨부 판단

                    console.log(attach.uploadPath);
                    console.log(attach.uuid);
                    console.log(attach.fileName);

                    //https://dev-timero.tistory.com/96 참고 자료
                    //이미지면 true 첨부면 false이다. attach.filetype이 첨부면 false찍히는데
                    //if문에서는 true로 간다. 해결방법은 위에 참고 자료 봐가지고 해결.
                    let attachFileType = (attach.fileType === 'true');

                    if(attachFileType){
                        console.log("if");
                        let fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
                        str += "<li data-path='"+attach.uploadPath+"'";
                        str += "data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"'data-type='"+attach.fileType+"'";
                        str += "><div>";
                        str += "<span> "+attach.fileName+"</span>";
                        str += "<button type='button' class='btn btn-secondary btn-circle' data-file=\'"+fileCallPath+"\' data-type='image'>X</button><br>";
                        str += "<img src='/display?fileName="+fileCallPath+"'>";
                        str += "</div>";
                        str += "</li>";
                    } else {
                        //return;
                        let fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
                        console.log("else");
                        str += "<li data-path='"+attach.uploadPath+"'";
                        str += "data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"'data-type='"+attach.fileType+"'";
                        str += "><div>";
                        str += "<span> "+attach.fileName+"</span>";
                        str += "<button type='button' class='btn btn-secondary btn-circle' data-file=\'"+fileCallPath+"\' data-type='image'>X</button><br>";
                        str += "<img src='../../../resources/img/1.png'>";
                        str += "</div>";
                        str += "</li>";

                    }

                })

                $(".uploadResult").html(str);

            }); // end getJSON

        })();


        //첨부파일 삭제
        $(".uploadResult").on("click", "button", function(e) {

            console.log("delete file");

            if(confirm("첨부파일을 삭제하시겠습니까?")) {

                let targetLi = $(this).closest("li");
                targetLi.remove();
            }
        })

        $("input[type='file']").change(function(e) {

            let formData = new FormData();

            let inputFile = $("input[name='uploadFile']");

            //let file = inputFile[0].files[0]; 함정카드 찾았다. 여기 밑에
            let files = inputFile[0].files;

            console.log(files);

            for(let i=0; i<files.length; i++) {

                if(!checkExtension(files[i].name, files[i].size)) {
                    console.log("failed");
                    return false;
                }
                formData.append("uploadFile", files[i]);
            }


            //여기수정
            $.ajax({
                url: '/uploadAjaxAction',
                processData: false,
                contentType: false,
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                data: formData,
                type: 'POST',
                dataType:'json',
                success: function(result) {
                    console.log(">>>>>>>" + result);
                    showUploadResult(result);
                    console.log("done")
                }
            }) //end ajax

        }) //end change

        function checkExtension(fileName, fileSize) {

            if(fileSize >= maxSize) {
                alert("파일 사이즈 초과");
                return false;
            }

            if(!regex.test(fileName)) {
                alert("해당 종류의 파일은 업로드 할 수 없습니다.");
                return false;
            }
            return true;
        }

        //
        function showUploadResult(uploadResult) {

            //수정부분
            if(!uploadResult || uploadResult.length == 0) {
                return;
            }

            let uploadUL = $('.uploadResult');

            //첨부파일 한개만 나온 거 해결! "" -> 아래 코드
            let str = $('.uploadResult').html();

            console.log(str);
            $(uploadResult).each(function(i, obj) {
                console.log("each");
                if(obj.image) {
                    let fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
                    str += "<li data-path='"+obj.uploadPath+"'";
                    str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'data-type='"+obj.image+"'";
                    str += "><div>";
                    str += "<span> "+obj.fileName+"</span>";
                    str += "<button type='button' class='btn btn-secondary btn-circle' data-file=\'"+fileCallPath+"\' data-type='image'>X</button><br>";
                    str += "<img src='/display?fileName="+fileCallPath+"'>";
                    str += "</div>";
                    str += "</li>";
                } else {
                    //return;
                    let fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
                    str += "<li data-path='"+obj.uploadPath+"'";
                    str += "data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"'data-type='"+obj.image+"'";
                    str += "><div>";
                    str += "<span> "+obj.fileName+"</span>";
                    str += "<button type='button' class='btn btn-secondary btn-circle' data-file=\'"+fileCallPath+"\' data-type='file'>X</button><br>";
                    str += "<img src='/resources/img/1.png'>";
                    str += "</div>";
                    str += "</li>";

                }
            })

            uploadUL.html(str);


        } // end showUploadResult




    });//end ready
</script>


<%@include file="../includes/footer.jsp" %>
