<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/tagLib.jsp" %>
<link href="/resources/css/minicard.css" rel="stylesheet">

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal.username" var="userId"/>
</sec:authorize>
<script type="text/javascript" src="../../../../resources/js/validation.js"></script>

<div class="subContainer">
    <div class="h3cover" >
        <%--    <h3 class="h3title">생성한 스터디</h3>--%>
        <h4 class="h3title">프로필</h4>
    </div>
    <div class="subBody">
    <div id="errorMsgDiv"></div>
<%--    action="/user/modify" method="post"--%>
    <form role="form" id="userInfoForm">

        <div class="form-group">
            <label for="userId">아이디</label>
            <input type="text" class="form-control" id="userId" name="id" value="${MemberVo.id}" readonly>
        </div>

        <c:if test="${userId == MemberVo.id}">
            <div class="form-group" ${MemberVo.regPath == 'REPA01' ? '' : 'hidden'}>
                <label for="password">비밀번호</label>
                <input type="password" class="form-control" name="password" id="password" readonly>
            </div>
            <div class="form-group" ${MemberVo.regPath == 'REPA01' ? '' : 'hidden'}>
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
                <input type="file" class="form-control" id="picture" name="picture" accept="image/*" value="${MemberVo.picture}" readonly>

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
</div>


<script>
    $(document).ready(function (){
        // 변수들
        let password = $("#password")[0];
        let confirmPassword = $("#passwordConfirm")[0];
        let modifyMode = false;
        let inputs = $("#userInfoForm > .form-group > input");
        let submitBtn = $("#userInfoForm > #submitBtn");
        let cancelBtn = $("#cancel")[0];
        let fileInput = $("#userInfoForm > .form-group > input[type='file']")[0];
        let profileImg = $("#imgPlace")[0];
        let nameInput = $("#name")[0];
        let birthInput = $("#birth")[0];

        let imgPlace = $("#uploadResult")[0];
        let uploadImg = $("#imageTag")[0];
        let deleteImg = $("#deleteImg")[0];

        // 기본세팅
        $(cancelBtn).hide();
        $(deleteImg).hide();
        $(fileInput).hide();
        // $(imgPlace).hide();


        let errorBox = $("#errorMsgDiv")[0];
        let errorMsg;
        init();

        function init() {
            $(errorBox).hide();
            $(errorBox).html('<div id="errorMsg" class="w-100 btn btn-lg btn-danger">error</div>');
            errorMsg = $("#errorMsg")[0];
        }

        $(birthInput).on("change", function () {
            futureDate();
        });



        if("${MemberVo.picture}" === '' || "${MemberVo.picture}" === 'myPicture.jpeg') $(imgPlace).hide();


        function checkTwo() {
            let min = 8;
            let max = 20;
            if(password.value !== '') if(!checkLength(password, 4, 12, errorBox, errorMsg, "비밀번호")) return false;
            if (!checkLength(nameInput, 1, 10, errorBox, errorMsg, "이름")) return false;
            else return true;
        }

        function futureDate(){
            if(birthInput.valueAsNumber > Date.now()){
                showErrorMsg(errorBox, errorMsg, "생일을 미래로 설정 할 수 없습니다");
                // function showErrorMsg(textPlaceDiv, textPlace, msg) {
                //     $(textPlaceDiv).show();
                //     $(textPlace).html(msg);
                // }
                return false;
            }
            return true;

        }



        // 제출 버튼을 누르면
        $(submitBtn).on("click", function (e){
            console.log("click submit!!!");
            if(!compare(password, confirmPassword)) {
                confirmPassword.setCustomValidity("비밀번호가 일치하지 않습니다");
                return;
            }

            // console.log(password.value);
            e.preventDefault();
            if(modifyMode){
                if(!checkTwo()) return;
                if(!futureDate()) return;

            }






            sendData().then(function (result){
                changeBtn(result);
                $(submitBtn).attr("disabled", false);

                // console.log(profileImg);
                // console.dir(profileImg);
                // console.log(profileImg.src);
                // console.log(fileInput.filepath);

                // profileImg
                // fileInput.filepath
                // profileImg.src = fileInput.filepath;
            });
        });

        //취소버튼
        $(cancelBtn).on("click", function (e){
            e.preventDefault();
            $.ajax({url:"/user/details/profile" ,
                data : {
                    id : '${MemberVo.id}'
                },
                success:function(result) {
                    $("#content").html(result);
                }});
        });

        // 지금 처리방법
        //파일 첨부 버튼을 누르면
        //컨트롤러에 파일을 보내서 파일명을 폴더명 + uuid 로 썸네일과 함계 저장한다 << 파일을 변경하면 ajax를 호출
        //썸네일을 불러와서 하단에 html 영역에 뿌려준다 << ajax가 실행되고 결과값을 받아서 ajax안에서 메소드 실행
        //서밋을 누르면 유저 정보에 파일패스를 저장한다




        // 파일버튼누르면 업로드하는
        $(fileInput).on("change", function (){
            let file = this.files[0];

            let formData = new FormData();

            if(!checkExtension(file.name, file.size)) return false;


            formData.append("uploadFile", file);

            $.ajax({
                url: '/uploadAjaxAction',
                processData: false,
                contentType: false,
                beforeSend : function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                data: formData,
                type: 'POST',
                dataType:'json',
                success: function(result) {
                    showUploadResult(result, imgPlace, fileInput, uploadImg);
                    alert('성공');
                },
                error : function (msg) {
                    alert('에러가 발생했습니다');
                }
            });

        });

        // 삭제 버튼 누르면
        $(deleteImg).on("click", function () {
            console.log("delete click!");
            let obj = uploadImg.src;

            let targetFile = obj.slice(obj.indexOf("fileName="),).replace('fileName=','');
            let type = 'image';


            alert("파일을 삭제합니다");
            fileInput.filepath = '';
            // profileImg.src = 'http://placehold.it/900x400';
            $(imgPlace).hide();

            try{
                $('#picture')[0].removeAttr("filepath");
                $('#picture')[0].removeAttr("value.textContent");
            }catch(e){}


            <%--$.ajax({--%>
            <%--    url: '/deleteFile',--%>
            <%--    data: {fileName: targetFile, type:type},--%>
            <%--    beforeSend : function(xhr) {--%>
            <%--        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");--%>
            <%--    },--%>
            <%--    dataType:'text',--%>
            <%--    type: 'POST',--%>
            <%--    success: function(result) {--%>
            <%--        fileInput.filepath = '';--%>
            <%--        alert(result);--%>
            <%--        if(fileInput.value !== '') profileImg.src = 'http://placehold.it/900x400';--%>
            <%--        $(imgPlace).hide();--%>

            <%--        $('#picture')[0].removeAttr("filepath");--%>
            <%--        $('#picture')[0].removeAttr("value.textContent");--%>
            <%--    }--%>
            <%--});--%>
        });





        // console.log(fileInput);
        // console.dir(fileInput);

        function sendData() {
            return new Promise(function(resolve, reject) {
                if(modifyMode){

                    $(submitBtn).attr("disabled", true);

                    let beforeImg = $('#picture')[0].attributes.value.textContent;
                    let upImg = $('#picture')[0].filepath;

                    let img =
                        upImg !== undefined ?
                            upImg :
                            beforeImg !== undefined ? beforeImg : '';
                    profileImg.src = img === '' ? 'http://placehold.it/900x400' : '';
                    console.dir(img);

                    $.ajax({
                        url: '/user/modify',
                        type: 'POST',
                        beforeSend : function(xhr) {
                            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                        },
                        data: {
                            id : $('#userId')[0].value,
                            password : $('#password')[0].value,
                            name : $('#name')[0].value,
                            birth : $('#birth')[0].value,
                            picture : img,
                            status : '${MemberVo.status}',
                            email : '${MemberVo.id}'
                        },
                        success: function(msg) {
                            alert(msg);
                            password.value = '';
                            confirmPassword.value = '';
                            if(fileInput.value !== '') profileImg.src = "/display?fileName=" + (fileInput.filepath).replace('s_', '');
                            $(errorBox).hide();
                            resolve(true);
                        },
                        error : function (msg) {
                            alert(msg);
                            resolve(false);
                        }
                    });
                }else{
                    resolve(true);
                }
            });
        }

        function changeBtn(result){
            if(result){
                changeModifyStatus(submitBtn, inputs, modifyMode, cancelBtn, deleteImg, fileInput);
                modifyMode = !modifyMode;
            }
            else if(!result){
                console.log("실패");
            }
        }

        function checkPassword(){
            if(!compare(password, confirmPassword)) {
                console.log("비밀번호 일치x")
                confirmPassword.setCustomValidity("비밀번호가 일치하지 않습니다");
                return;
            }
        }

    });


    function compare(pwd1, pwd2){
        return pwd1.value === pwd2.value;
    }

    function changeModifyStatus(obj, inputs, condition, cancelBtn, deleteImg, fileInput){
        changeBtn(obj, condition, cancelBtn, deleteImg, fileInput);
        changeInputs(inputs, condition);
    }

    function changeInputs(inputs, condition){
        for(let i = 0; i < inputs.length; i++)
            if(inputs[i].id !== 'userId')
                inputs[i].readOnly = condition;
    }

    function changeBtn(obj, condition, cancelBtn, deleteImg, fileInput){
        if(condition){
            $(obj).removeClass('btn btn-danger');
            $(obj).addClass('btn btn-primary');
            $(obj).text('정보 수정');
            $(cancelBtn).hide();
            $(deleteImg).hide();
            $(fileInput).hide();
        }
        else{
            $(obj).removeClass('btn btn-primary');
            $(obj).addClass('btn btn-danger');
            $(obj).text('확인');
            $(cancelBtn).show();
            $(deleteImg).show();
            $(fileInput).show();
        }
    }

    function checkExtension(fileName, fileSize) {
        let regex = new RegExp("(.*?)\.(jpg|jpeg|png|bmp)$");
        let maxSize = 5242880;

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

    function showUploadResult(uploadResult, imgPlace, fileInput, uploadImg) {
        if(!uploadResult) return;

        // $(imgPlace).show();


        $(uploadResult).each(function(i, obj) {

            //////////////////////////////
            // let jobj = $(obj);

            // console.dir(jobj);
            //
            //
            // str += "<input type='hidden' name='attach.fileName' value='"+jobj.data("filename")+"'>";
            // str += "<input type='hidden' name='attach.uuid' value='"+jobj.data("uuid")+"'>";
            // str += "<input type='hidden' name='attach.uploadPath' value='"+jobj.data("path")+"'>";
            // str += "<input type='hidden' name='attach.fileType' value='"+jobj.data("type")+"'>";


            //////////////////////////////

            // let str = "";
            if(obj.image) {
                let fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);

                // fileInput.filepath = encodeURIComponent(obj.uploadPath + "\\" + obj.uuid + "_" +obj.fileName);
                fileInput.filepath = fileCallPath;
                console.log();

                uploadImg.src = '/display?fileName=' + fileCallPath;
            } else {
                return;
            }

        });
        $(imgPlace).show();
    }
</script>


