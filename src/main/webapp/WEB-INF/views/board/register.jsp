<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../../../resources/css/boardRegister.css">

<sec:authorize access="isAuthenticated()">
    <c:set value="${principal.username}" var="userId"/>
    <sec:authentication property="principal" var="pinfo"/>
    <sec:authentication property="principal.memberVO" var="mv"/>
</sec:authorize>


<div class="container">
    <h2>게시글 작성</h2>
    <hr/>
    <form id="registerForm"role="form" action="/board/register" method="post" enctype="multipart/form-data">

        <div class="form-group">
            <label for="userId">아이디</label>
            <input type="text" class="form-control" id="userId" name="userId"
                   value="<sec:authentication property="principal.username"/>" readonly="readonly">
        </div>

        <div class="form-group">
            <label for="grpSn">모임번호</label>
            <input type="text" class="form-control" id="grpSn" name="grpSn" value="${grpSn}"
                   readonly="readonly">
        </div>

        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" class="form-control" name="title" id="title" required>
        </div>

        <div class="form-group">
            <label for="content">내용</label><small id="contentLength">(0/1333)</small>
            <textarea class="form-control" rows="5" id="content" name="content" required></textarea>
        </div>

<%--        <div class="form-group">--%>
<%--            <label for="picture">사진</label>--%>
<%--            <input type="file" class="form-control" id="picture" name="picture">--%>
<%--        </div>--%>

        <div class="form-group uploadDiv">
            <label for="uploadFile">첨부파일</label>
            <input multiple="multiple" type="file" class="form-control" id="uploadFile" name="uploadFile" >

            <div class="uploadResult">
                <ul>

                </ul>
            </div>

            <div class="uploadResult2">
                <ul>

                </ul>
            </div>

        </div>


<%--        <div class="form-group">--%>
<%--            <label for="topFix">게시물 상위고정</label>--%>
<%--            <input type="checkbox" class="form-control" name="topFix" id="topFix">--%>
<%--        </div>--%>
        <!--
            게시글 상위고정은 모임장, 운영진만 가능하니까 일반회원은 안보이게한다.
            GRRO01 : 모임장
            GRRO02 : 운영진
            GRRO03 : 회원-->

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


        <sec:csrfInput/>
<%--        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">--%>
        <button id='registerBtn' type="submit" class="btn btn-primary">등록</button>
        <button id="back" type="reset" class="btn btn-dark">취소</button>



        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    </form>
</div>

<script>
    $(document).ready(function(){

        //exe|sh|zip|alz|  png|jpg|jpeg|bmp|
        let fileInput = $("#registerForm > .form-group > input[id='uploadFile']");
        let formObj = $("form[role='form']");
        let regex = new RegExp("(.*?)\.(exe|sh|zip|alz|)$");
        let maxSize = 5242880;
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        //체크박스를 클릭한다.
        // function isChecked() {
        console.log("ck box 11");
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



       // }

        $("button[type='submit']").on("click", function(e) {

            e.preventDefault();

            if(!validation()) {
                console.log('no validataion');
                return;
            }else{
                console.log('inserting');
                //alert("제목을 입력해주세요.");
                // return;
            }
            //체크박스 값 가져오기 위한 메서드
            // isChecked();


            console.log("final");
            console.log($("input[name='topFix']").val());
            //
            objForm.submit();

            let str = "";

            $('.uploadResult ul li').each(function(i, obj) {

                let jobj = $(obj);
                console.log('kkkkkk');
                console.dir(jobj);

                str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
                str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
                str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
                str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";

            })

            formObj.append(str).submit();
        })

        //----------------------------
        // $("button[type='reset']").on("click", function(e) {
        //     e.preventDefault();
        //
        //     formObj.attr("action", '/group/get=').attr('method', 'get');
        //     formObj.submit();
        //})


        // 파일버튼누르면 업로드하는 fileInput $("input[type='file']")
        $("input[type='file']").change(function(e) {

            let formData = new FormData();

            let inputFile = $("input[name='uploadFile']");


            let files = inputFile[0].files;

            console.log(files);

            for(let i=0; i<files.length; i++) {

                if(!checkExtension(files[i].name, files[i].size)) {
                    return false;
                }
                formData.append("uploadFile", files[i]);
            }


            // if(!checkExtension(file.name, file.size)) {
            //     return false;
            // }
            //
            // formData.append("uploadFile", file);


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
        })
        //, .uploadResult2
        $(".uploadResult").on("click", "button", function(e) {
            console.log("delete file");

            let targetFile = $(this).data("file");
            let type = $(this).data("type");

            let targetLI = $(this).closest("li");

            $.ajax({
                url: '/deleteFile',
                data: {fileName: targetFile, type:type},
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                dataType:'text',
                type: 'POST',
                success: function(result) {
                    alert(result);
                    targetLI.remove();
                }
            })
        })

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

        function showUploadResult(uploadResult) {
            console.log(uploadResult);

            //수정부분
            if(!uploadResult || uploadResult.length == 0) {
                return;
            }

            let uploadUL = $('.uploadResult ul');
            //이미지와 첨부파일을 구별하기.. 나중에 하자
            //let uploadUL2 = $('.uploadResult2 ul');

            //첨부파일 한개만 나온 거 해결! "" -> 아래 코드
            let str = $('.uploadResult ul').html();

            //let str2 = $('.uploadResult2 ul').html();

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
                    str += "<span>"+obj.fileName+"</span>";
                    str += "<button type='button' class='btn btn-secondary btn-circle' data-file=\'"+fileCallPath+"\' data-type='file'>X</button><br>";
                    str += "<img src='/resources/img/1.png'>";
                    str += "</div>";
                    str += "</li>";

                }
            })

            uploadUL.html(str);
            //uploadUL2.html(str2);
        } // end showUploadResult

/////////////////////////////////////////////////////////


    $("#back").on("click", function(){
        window.history.back();
    });

    let objForm = $('#registerForm');

    // $('button[type="submit"]').on("click", function(e) {
    //
    //
    // });

    //내용이 입력되면 글자 개수 증가
     $('textarea').keyup(function(){
            //정규식 숫자 영어 특수문자 한글
            let inputLength = $(this).val().length;
            let remain = inputLength++;

        if(inputLength > 0){
            $('textarea').val($('textarea').val().substring(0,1333));
            if(remain > 1333){
                alert("내용 입력을 초과하였습니다.");
            }
        }


        $('#contentLength').html('('+remain+'/1333)');
    });

    /*테스트 결과 register에서 처리해야 할 부분
    1. 제목 내용 공백(스페이스바)들어가는 것 처리.
    제목/내용 공백처리 완료.
    * */
    function validation(){
        // $("input[id='title']").val().trim().length == 0
        // getByte($("input[id='title']").val()) == ""
        if($("input[id='title']").val().trim().length == 0) {
            alert("제목을 입력해주세요.");
            return false;

        }else if(getByte($("input[id='title']").val()) > 200){
            alert("게시글 제목이 너무 깁니다.");
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



    })//end ready
</script>


<%@include file="../includes/footer.jsp" %>