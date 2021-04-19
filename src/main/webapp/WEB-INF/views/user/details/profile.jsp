<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/tagLib.jsp" %>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal.username" var="userId"/>
</sec:authorize>


<div class="container">
    <h2>프로필 수정</h2>
    <hr/>
<%--    action="/user/modify" method="post"--%>
    <form role="form" id="userInfoForm">

        <div class="form-group">
            <label for="userId">아이디</label>
            <input type="text" class="form-control" id="userId" name="id" value="${MemberVo.id}" readonly>
        </div>

        <c:if test="${userId == MemberVo.id}">
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" class="form-control" name="password" id="password" readonly>
            </div>
            <div class="form-group">
                <label for="passwordConfirm">비밀번호 확인</label>
                <input type="password" class="form-control" id="passwordConfirm" name="passwordConfirm" readonly>
            </div>
        </c:if>

        <div class="form-group">
            <label for="name">이름</label>
            <input type="text" class="form-control" id="name" name="name" value="${MemberVo.name}" readonly>
        </div>
        <div class="form-group">
            <label for="birth">생일</label>
            <input type="date" class="form-control" id="birth" name="birth" value="${MemberVo.birth}" readonly>
        </div>

        <c:if test="${userId == MemberVo.id}">
            <div class="form-group">
                <label for="picture">사진</label>
                <input type="file" class="form-control" id="picture" name="picture" accept="image/*" readonly>

                <div id="uploadResult">
                    <img id="imageTag" src="${'/display?fileName=' += MemberVo.picture}" value="" >
                    <button id="deleteImg" type='button' class='btn btn-secondary btn-circle'>X</button><br>
                </div>
            </div>
            <button id="submitBtn" class="btn btn-primary">정보 수정</button>
            <button id='cancel' class='btn btn-primary'>취소</button>
        </c:if>

        <input type="hidden" name="status" value="${MemberVo.status}">
        <input type="hidden" name="email" value="${MemberVo.id}">
<%--        <sec:csrfInput/>--%>
    </form>
</div>


<input type="file" id="input-file" size="35" >
<input type="text" id="file_path" size="100">



<script>
    $(document).ready(function() {
        $("#input-file").change(function() {
            let length = this.files.length;
            if (!length) {
                return false;
            }
            useImage(this);
        });
    });

    // Creating the function
    function useImage(img) {
        let file = img.files[0];
        let imagefile = file.type;
        let match = ["image/jpeg", "image/png", "image/jpg"];
        if (!((imagefile == match[0]) || (imagefile == match[1]) || (imagefile == match[2]))) {
            alert("Invalid File Extension");
        } else {
            let reader = new FileReader();
            // reader.onload = imageIsLoaded;
            // reader.readAsDataURL(img.files[0]);
            console.log(reader.readAsDataURL(img.files[0]))
        }

        function imageIsLoaded(e) {
            $('div.withBckImage').css({ 'background-image': "url(" +  + ")" });

        }
    }



    <%--$(document).ready(function (){--%>
    <%--    // 변수들--%>
    <%--    let password = $("#password")[0];--%>
    <%--    let confirmPassword = $("#passwordConfirm")[0];--%>
    <%--    let modifyMode = false;--%>
    <%--    let inputs = $("#userInfoForm > .form-group > input");--%>
    <%--    let submitBtn = $("#userInfoForm > #submitBtn");--%>
    <%--    let cancelBtn = $("#cancel")[0];--%>
    <%--    let fileInput = $("#userInfoForm > .form-group > input[type='file']")[0];--%>
    <%--    let profileImg = $("#imgPlace")[0];--%>

    <%--    let imgPlace = $("#uploadResult")[0];--%>
    <%--    let uploadImg = $("#imageTag")[0];--%>
    <%--    let deleteImg = $("#deleteImg")[0];--%>


    <%--    // 기본세팅--%>
    <%--    $(cancelBtn).hide();--%>
    <%--    // $(imgPlace).hide();--%>

    <%--    if("${MemberVo.picture}" === '' || "${MemberVo.picture}" === 'myPicture.jpeg') $(imgPlace).hide();--%>


    <%--    // $(password).change(function () {--%>
    <%--    //     if(!compare(password, confirmPassword)) {--%>
    <%--    //         console.log("비밀번호 일치x")--%>
    <%--    //         this.setCustomValidity("비밀번호가 일치하지 않습니다");--%>
    <%--    //         return;--%>
    <%--    //     }--%>
    <%--    // });--%>
    <%--    //--%>
    <%--    // $(confirmPassword).keyup(function (e){--%>
    <%--    //     e.preventDefault();--%>
    <%--    //     if(!compare(password, confirmPassword)) {--%>
    <%--    //         confirmPassword.setCustomValidity("비밀번호가 일치하지 않습니다");--%>
    <%--    //--%>
    <%--    //     }--%>
    <%--    // });--%>



    <%--    // 제출 버튼을 누르면--%>
    <%--    $(submitBtn).on("click", function (e){--%>
    <%--        if(!compare(password, confirmPassword)) {--%>
    <%--            confirmPassword.setCustomValidity("비밀번호가 일치하지 않습니다");--%>
    <%--            return;--%>
    <%--        }--%>

    <%--        e.preventDefault();--%>

    <%--        sendData().then(function (result){--%>
    <%--            changeBtn(result);--%>
    <%--            $(submitBtn).attr("disabled", false);--%>

    <%--            // console.log(profileImg);--%>
    <%--            // console.dir(profileImg);--%>
    <%--            // console.log(profileImg.src);--%>
    <%--            // console.log(fileInput.filepath);--%>

    <%--            // profileImg--%>
    <%--            // fileInput.filepath--%>
    <%--            // profileImg.src = fileInput.filepath;--%>
    <%--        });--%>
    <%--    });--%>

    <%--    //취소버튼--%>
    <%--    $(cancelBtn).on("click", function (e){--%>
    <%--        e.preventDefault();--%>
    <%--        $.ajax({url:"/user/details/profile" ,--%>
    <%--            data : {--%>
    <%--                id : '${MemberVo.id}'--%>
    <%--            },--%>
    <%--            success:function(result) {--%>
    <%--                $("#content").html(result);--%>
    <%--            }});--%>

    <%--    });--%>

    <%--    // 지금 처리방법--%>
    <%--    //파일 첨부 버튼을 누르면--%>
    <%--    //컨트롤러에 파일을 보내서 파일명을 폴더명 + uuid 로 썸네일과 함계 저장한다 << 파일을 변경하면 ajax를 호출--%>
    <%--    //썸네일을 불러와서 하단에 html 영역에 뿌려준다 << ajax가 실행되고 결과값을 받아서 ajax안에서 메소드 실행--%>
    <%--    //서밋을 누르면 유저 정보에 파일패스를 저장한다--%>




    <%--    // 파일버튼누르면 업로드하는--%>
    <%--    $(fileInput).on("change", function (){--%>

    <%--        let file = this.files[0];--%>
    <%--        let formData = new FormData();--%>

    <%--        if(!checkExtension(file.name, file.size)) return false;--%>


    <%--        formData.append("uploadFile", file);--%>

    <%--        $.ajax({--%>
    <%--            url: '/uploadAjaxAction',--%>
    <%--            processData: false,--%>
    <%--            contentType: false,--%>
    <%--            beforeSend : function(xhr) {--%>
    <%--                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");--%>
    <%--            },--%>
    <%--            data: formData,--%>
    <%--            type: 'POST',--%>
    <%--            dataType:'json',--%>
    <%--            success: function(result) {--%>
    <%--                showUploadResult(result, imgPlace, fileInput, uploadImg);--%>
    <%--                alert('성공');--%>
    <%--            },--%>
    <%--            error : function (msg) {--%>
    <%--                alert('에러가 발생했습니다');--%>
    <%--            }--%>
    <%--        });--%>

    <%--    });--%>

    <%--    $(deleteImg).on("click", function () {--%>
    <%--        console.log("delete click!");--%>
    <%--        let obj = uploadImg.src;--%>

    <%--        let targetFile = obj.slice(obj.indexOf("fileName="),).replace('fileName=','');--%>
    <%--        let type = 'image';--%>


    <%--        $.ajax({--%>
    <%--            url: '/deleteFile',--%>
    <%--            data: {fileName: targetFile, type:type},--%>
    <%--            beforeSend : function(xhr) {--%>
    <%--                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");--%>
    <%--            },--%>
    <%--            dataType:'text',--%>
    <%--            type: 'POST',--%>
    <%--            success: function(result) {--%>
    <%--                alert(result);--%>
    <%--                if(fileInput.value !== '') profileImg.src = 'http://placehold.it/900x400';--%>
    <%--                $(imgPlace).hide();--%>
    <%--            }--%>
    <%--        });--%>
    <%--    });--%>


    <%--    $(".uploadRaaaesult").on("click", "button", function(e) {--%>
    <%--        console.log("delete file");--%>

    <%--        let targetFile = $(this).data("file");--%>
    <%--        let type = $(this).data("type");--%>

    <%--        let targetLI = $(this).closest("li");--%>

    <%--        $.ajax({--%>
    <%--            url: '/deleteFile',--%>
    <%--            data: {fileName: targetFile, type:type},--%>
    <%--            beforeSend: function(xhr) {--%>
    <%--                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);--%>
    <%--            },--%>
    <%--            dataType:'text',--%>
    <%--            type: 'POST',--%>
    <%--            success: function(result) {--%>
    <%--                alert(result);--%>
    <%--                targetLI.remove();--%>
    <%--            }--%>
    <%--        })--%>
    <%--    });--%>


    <%--    // console.log(fileInput);--%>
    <%--    // console.dir(fileInput);--%>

    <%--    function sendData() {--%>
    <%--        return new Promise(function(resolve, reject) {--%>
    <%--            if(modifyMode){--%>

    <%--                // console.log($('#picture')[0].filepath);--%>

    <%--                $(submitBtn).attr("disabled", true);--%>

    <%--                $.ajax({--%>
    <%--                    url: '/user/modify',--%>
    <%--                    type: 'POST',--%>
    <%--                    beforeSend : function(xhr) {--%>
    <%--                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");--%>
    <%--                    },--%>
    <%--                    data: {--%>
    <%--                        id : $('#userId')[0].value,--%>
    <%--                        password : $('#password')[0].value,--%>
    <%--                        name : $('#name')[0].value,--%>
    <%--                        birth : $('#birth')[0].value,--%>
    <%--                        picture : $('#picture')[0].filepath,--%>
    <%--                        status : '${MemberVo.status}',--%>
    <%--                        email : '${MemberVo.id}'--%>
    <%--                    },--%>
    <%--                    success: function(msg) {--%>
    <%--                        alert('정보를 수정했습니다');--%>
    <%--                        password.value = '';--%>
    <%--                        confirmPassword.value = '';--%>
    <%--                        if(fileInput.value !== '') profileImg.src = "/display?fileName=" + (fileInput.filepath).replace('s_', '');--%>
    <%--                        resolve(true);--%>
    <%--                    },--%>
    <%--                    error : function (msg) {--%>
    <%--                        alert('에러가 발생했습니다');--%>
    <%--                        resolve(false);--%>
    <%--                    }--%>
    <%--                });--%>
    <%--            }else{--%>
    <%--                resolve(true);--%>
    <%--            }--%>
    <%--        });--%>
    <%--    }--%>

    <%--    function changeBtn(result){--%>
    <%--        if(result){--%>
    <%--            changeModifyStatus(submitBtn, inputs, modifyMode, cancelBtn, deleteImg);--%>
    <%--            modifyMode = !modifyMode;--%>
    <%--        }--%>
    <%--        else if(!result){--%>
    <%--            console.log("실패");--%>
    <%--        }--%>
    <%--    }--%>

    <%--    function checkPassword(){--%>
    <%--        if(!compare(password, confirmPassword)) {--%>
    <%--            console.log("비밀번호 일치x")--%>
    <%--            confirmPassword.setCustomValidity("비밀번호가 일치하지 않습니다");--%>
    <%--            return;--%>
    <%--        }--%>
    <%--    }--%>

    <%--});--%>

    <%--function compare(pwd1, pwd2){--%>
    <%--    return pwd1.value === pwd2.value;--%>
    <%--}--%>

    <%--function changeModifyStatus(obj, inputs, condition, cancelBtn, deleteImg){--%>
    <%--    changeBtn(obj, condition, cancelBtn, deleteImg);--%>
    <%--    changeInputs(inputs, condition);--%>
    <%--}--%>

    <%--function changeInputs(inputs, condition){--%>
    <%--    for(let i = 0; i < inputs.length; i++)--%>
    <%--        if(inputs[i].id !== 'userId')--%>
    <%--            inputs[i].readOnly = condition;--%>
    <%--}--%>

    <%--function changeBtn(obj, condition, deleteImg){--%>
    <%--    if(condition){--%>
    <%--        $(obj).removeClass('btn btn-warning');--%>
    <%--        $(obj).addClass('btn btn-primary');--%>
    <%--        $(obj).text('정보 수정');--%>
    <%--        $(deleteImg).hide();--%>
    <%--    }--%>
    <%--    else{--%>
    <%--        $(obj).removeClass('btn btn-primary');--%>
    <%--        $(obj).addClass('btn btn-warning');--%>
    <%--        $(obj).text('확인');--%>
    <%--        $(deleteImg).show();--%>
    <%--    }--%>
    <%--}--%>

    <%--function checkExtension(fileName, fileSize) {--%>
    <%--    let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");--%>
    <%--    let maxSize = 5242880;--%>

    <%--    if(fileSize >= maxSize) {--%>
    <%--        alert("파일 사이즈 초과");--%>
    <%--        return false;--%>
    <%--    }--%>

    <%--    if(regex.test(fileName)) {--%>
    <%--        alert("해당 종류의 파일은 업로드 할 수 없습니다.");--%>
    <%--        return false;--%>
    <%--    }--%>
    <%--    return true;--%>
    <%--}--%>

    <%--function showUploadResult(uploadResult, imgPlace, fileInput, uploadImg) {--%>
    <%--    if(!uploadResult) return;--%>

    <%--    // $(imgPlace).show();--%>


    <%--    $(uploadResult).each(function(i, obj) {--%>

    <%--        //////////////////////////////--%>
    <%--        // let jobj = $(obj);--%>

    <%--        // console.dir(jobj);--%>
    <%--        //--%>
    <%--        //--%>
    <%--        // str += "<input type='hidden' name='attach.fileName' value='"+jobj.data("filename")+"'>";--%>
    <%--        // str += "<input type='hidden' name='attach.uuid' value='"+jobj.data("uuid")+"'>";--%>
    <%--        // str += "<input type='hidden' name='attach.uploadPath' value='"+jobj.data("path")+"'>";--%>
    <%--        // str += "<input type='hidden' name='attach.fileType' value='"+jobj.data("type")+"'>";--%>


    <%--        //////////////////////////////--%>

    <%--        // let str = "";--%>
    <%--        if(obj.image) {--%>
    <%--            let fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);--%>

    <%--            // fileInput.filepath = encodeURIComponent(obj.uploadPath + "\\" + obj.uuid + "_" +obj.fileName);--%>
    <%--            fileInput.filepath = fileCallPath;--%>
    <%--            console.log();--%>

    <%--            uploadImg.src = '/display?fileName=' + fileCallPath;--%>
    <%--        } else {--%>
    <%--            return;--%>
    <%--        }--%>

    <%--    });--%>
    <%--    $(imgPlace).show();--%>
    <%--}--%>
</script>


