<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>

<div class="container">
    <h2>모임 만들기</h2>
    <hr/>
    <form role="form" action="/group/register" method="post">
        <div class="form-group">
            <label for="userId">아이디</label>
            <input type="text" class="form-control" id="userId" name="userId" required>
        </div>
        <div class="form-group">
            <label for="category">카테고리</label>
            <select class="form-control" id="category" name="category" required>
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
            <input type="text" class="form-control" name="name" id="name" required>
        </div>
        <div class="form-group">
            <label for="description">한줄소개</label>
            <textarea class="form-control" rows="1" id="description" name="description" required></textarea>
        </div>
        <div class="form-group">
            <label for="info">정보 (모임에 대해 자세히 적어주세요)</label>
            <textarea class="form-control" rows="5" id="info" name="info" required></textarea>
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
                    <option value="LOGU01">강남</option>
                    <option value="LOGU02">명동</option>
                    <option value="LOGU03">홍대</option>
                    <option value="LOGU04">오산시</option>
                    <option value="LOGU05">화성시</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="tags">태그</label>
            <select class="form-control" id="tags" name="tags">
                <option value="GRTG01">자바</option>
                <option value="GRTG02">파이썬</option>
                <option value="GRTG03">스프링</option>
                <option value="GRTG04">자바스크립트</option>
            </select>
        </div>

        <!-- 첨부파일 -->
        <div class="form-group uploadDiv">
            <label for="uploadFile">사진</label>
            <input type="file" class="form-control" id="uploadFile" name="uploadFile" multiple>
            <div class="uploadResult">
                <ul>

                </ul>
            </div>
        </div>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <button type="submit" class="btn btn-primary">등록</button>
        <button type="reset" class="btn btn-primary">취소</button>
    </form>
</div>

<script>

    $(document).ready(function(e) {

        let formObj = $("form[role='form']");
        let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        let maxSize = 5242880;

        $("button[type='submit']").on("click", function(e) {

            e.preventDefault();

            console.log("submit clicked");

            let str = "";

            $('.uploadResult ul li').each(function(i, obj) {

                let jobj = $(obj);

                console.dir(jobj);

                str += "<input type='hidden' name='attachList[" + i + "].fileName' value='"+jobj.data("filename")+"'>";
                str += "<input type='hidden' name='attachList[" + i + "].uuid' value='"+jobj.data("uuid")+"'>";
                str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='"+jobj.data("path")+"'>";
                str += "<input type='hidden' name='attachList[" + i + "].fileType' value='"+jobj.data("type")+"'>";

            })

            formObj.append(str).submit();
        })

        $("input[type='file']").change(function(e) {

            let formData = new FormData();

            let inputFile = $("input[name='uploadFile']");

            let files = inputFile[0].files;

            for(let i=0; i<files.length; i++) {

                if(!checkExtension(files[i].name, files[i].size)) {
                    return false;
                }
                formData.append("uploadFile", files[i]);
            }

            $.ajax({
                url: '/uploadAjaxAction',
                processData: false,
                contentType: false,
                data: formData,
                type: 'POST',
                dataType:'json',
                success: function(result) {
                    console.log(result);
                    showUploadResult(result);
                }
            })

        })

        $(".uploadResult").on("click", "button", function(e) {
            console.log("delete file");

            let targetFile = $(this).data("file");
            let type = $(this).data("type");

            let targetLI = $(this).closest("li");

            $.ajax({
                url: '/deleteFile',
                data: {fileName: targetFile, type:type},
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

            if(regex.test(fileName)) {
                alert("해당 종류의 파일은 업로드 할 수 없습니다.");
                return false;
            }
            return true;
        }

        function showUploadResult(uploadResultArr) {

            if(!uploadResultArr || uploadResultArr.length == 0) {
                return;
            }

            let uploadUL = $('.uploadResult ul');

            let str = "";

            $(uploadResultArr).each(function(i, obj) {

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
                    let fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
                    let fileLink =fileCallPath.replace(new RegExp(/\\/g), "/");

                    str += "<li";
                    str += "data-path='" + obj.uploadPath + "' data-uuid='"+obj.uuid+"'data-filename='" + obj.fileName + "'data-type='" + obj.image+"'><div>";
                    str += "<span> " + obj.fileName+"</span>";
                    str += "<button type='button' class='btn btn-secondary btn-circle' data-file=\'"+fileCallPath+"\' data-type='file'>X</button><br>";
                    str += "<img src='/resources/img/attach.png'></a>";
                    str += "</div>";
                    str += "</li>";

                }
            })

            uploadUL.append(str);
        }

    })
</script>




<%@include file="../includes/footer.jsp" %>
