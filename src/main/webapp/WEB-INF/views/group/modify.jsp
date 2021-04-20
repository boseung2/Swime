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
            <select class="form-control" id="category" name="category" required>
                <option value="select">------</option>
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
            <input type="text" class="form-control" name="name" id="name" value="<c:out value="${group.name}"/>" required>
        </div>
        <div class="form-group uploadDiv">
            <label for="uploadFile">대표사진</label>
            <input type="file" class="form-control" id="uploadFile" name="uploadFile" >
            <div class="uploadResult">
                <ul>

                </ul>
            </div>
        </div>
        <div class="form-group">
            <label for="description">한줄소개</label>
            <textarea class="form-control" rows="1" id="description" name="description" required><c:out value="${group.description}"/></textarea>
        </div>
        <div class="form-group">
            <label for="info">정보 (모임에 대해 자세히 적어주세요)</label>
            <textarea class="form-control" rows="5" id="info" name="info" required><c:out value="${group.info}"/></textarea>
        </div>
        <div class="form-row">
            <div class="col">
            <label for="sido">시/도</label>
            <select class="form-control" id="sido" name="sido">
                <option value="select">------</option>
                <option value="LOSI01">서울시</option>
                <option value="LOSI02">경기도</option>
            </select>
            </div>
            <div class="col">
                <label for="sigungu">시/군/구</label>
                <select class="form-control" id="sigungu" name="sigungu">
                    <option value="select">------</option>
                    <option value="LOGU01">강남</option>
                    <option value="LOGU02">명동</option>
                    <option value="LOGU03">홍대</option>
                    <option value="LOGU04">오산시</option>
                    <option value="LOGU05">화성시</option>
                </select>
            </div>
        </div>
        <script>
            $(document).ready(function() {
                let seoul = $('#sido').children()[0];
                let gyunggido = $('#sido').children()[1];

                $('#sido').on("click", function(e) {
                    $('#sido').children()
                })
            })
        </script>
        <div class="form-group">
            <label for="tags">태그</label>
            <select class="form-control" id="tags" name="tags" >
                <option value="select">------</option>
                <option value="GRTG01">자바</option>
                <option value="GRTG02">파이썬</option>
                <option value="GRTG03">스프링</option>
                <option value="GRTG04">자바스크립트</option>
            </select>
        </div>

        <div class="bigPictureWrapper">
            <div class="bigPicture">
            </div>
        </div>

        <div class="form-group">
            <label for="updDate" hidden></label>
            <input type="date" class="form-control" name="updDate" id="updDate" value="<fmt:formatDate value="${group.updDate}" pattern="yyyy/MM/dd"/>" hidden>
            <input type="number" class="form-control" name="attendCount" id="attendCount" value="<c:out value="${group.attendCount}"/>" hidden>
            <input type="number" class="form-control" name="rating" id="rating" value="<c:out value="${group.rating}"/>" hidden>
            <input type="number" class="form-control" name="ratingCount" id="ratingCount" value="<c:out value="${group.ratingCount}"/>" hidden>
            <input type="text" class="form-control" name="status" id="status" value="<c:out value="${group.status}"/>" hidden>
        </div>
        <sec:csrfInput/>
        <input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
        <input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
        <c:if test="${pinfo.username eq group.userId}">
            <button type="submit" class="btn btn-primary" data-oper="modify">수정</button>
            <button type="submit" class="btn btn-warning" data-oper="remove">삭제</button>
        </c:if>
        <button type="submit" class="btn btn-secondary" data-oper="list">목록</button>
    </form>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        let formObj = $('form');

        $('button').on("click", function(e) {

            e.preventDefault();

            if(!validation()) {
                return;
            }

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

            }else if(operation === 'modify') {

                console.log("submit clicked");

                let str = "";

                $(".uploadResult ul li").each(function(i, obj) {

                    let jobj = $(obj);

                    console.dir(jobj);

                    str += "<input type='hidden' name='attach.fileName' value='"+jobj.data("filename")+"'>";
                    str += "<input type='hidden' name='attach.uuid' value='"+jobj.data("uuid")+"'>";
                    str += "<input type='hidden' name='attach.uploadPath' value='"+jobj.data("path")+"'>";
                    str += "<input type='hidden' name='attach.fileType' value='"+jobj.data("type")+"'>";
                })

                formObj.append(str).submit();
            }

            formObj.submit();
        })
    })
</script>

<script>
    $(document).ready(function() {
        let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        let maxSize = 5242880;
        let formObj = $("form");
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        (function() {

            let grpSn = '<c:out value="${group.sn}"/>';

            $.getJSON("/group/getAttach", {grpSn: grpSn}, function(arr) {
                console.log(arr);

                let str = "";

                $(arr).each(function(i, attach) {

                    if(attach.fileType) {
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
                        let fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
                        str += "<li";
                        str += "data-path='" + attach.uploadPath + "' data-uuid='"+attach.uuid+"'data-filename='" + attach.fileName + "'data-type='" + attach.fileType+"'><div>";
                        str += "<span> " + attach.fileName+"</span>";
                        str += "<button type='button' class='btn btn-secondary btn-circle' data-file=\'"+fileCallPath+"\' data-type='file'>X</button><br>";
                        str += "<img src='/resources/img/attach.png'></a>";
                        str += "</div>";
                        str += "</li>";
                    }
                })

                $(".uploadResult ul").html(str);
            });
        })();

        $(".uploadResult").on("click", "button", function(e) {

            console.log("delete file");

            if(confirm("Remove this file? ")) {

                let targetLi = $(this).closest("li");
                targetLi.remove();
            }
        })

        $("input[type='file']").change(function(e) {

            let formData = new FormData();

            let inputFile = $("input[name='uploadFile']");

            let file = inputFile[0].files[0];

            console.log(file);

            //let files = inputFile[0].files;

            if(!checkExtension(file.name, file.size)) {
                return false;
            }

            formData.append("uploadFile", file);

            // for(let i=0; i<files.length; i++) {
            //
            //     if(!checkExtension(files[i].name, files[i].size)) {
            //         return false;
            //     }
            //     formData.append("uploadFile", files[i]);
            // }

            $.ajax({
                url: '/uploadAjaxAction',
                processData: false,
                contentType: false,
                data: formData,
                type: 'POST',
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
                },
                dataType:'json',
                success: function(result) {
                    console.log(">>>>>>>" + result);
                    showUploadResult(result);
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

        function showUploadResult(uploadResult) {

            if(!uploadResult) {
                return;
            }

            let uploadUL = $('.uploadResult ul');

            let str = "";

            $(uploadResult).each(function(i, obj) {

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
                    return;
                }
            })

            uploadUL.html(str);
        }
    })
</script>
<!-- select box에 값 넣기 -->
<script>
    $(document).ready(function() {
        let category = $('#category').children();
        let sido = $('#sido').children();
        let sigungu = $('#sigungu').children();
        let tag = $('#tags').children();

        let categoryValue = '<c:out value="${group.category}"/>';
        let sidoValue = '<c:out value="${group.sido}"/>';
        let sigunguValue = '<c:out value="${group.sigungu}"/>';
        let tagValue = '<c:out value="${group.tags}"/>'.substr(1,6); // 임시로 []제거

        console.log(tag);
        console.log(tagValue);

        const setSelectBox = (selectBox, value) => {
            for(let i=0; i<selectBox.length; i++) {
                if(selectBox[i].value === value) {
                    selectBox[i].setAttribute("selected", true);
                }
            }
        };
        setSelectBox(category, categoryValue);
        setSelectBox(sido, sidoValue);
        setSelectBox(sigungu, sigunguValue);
        setSelectBox(tag, tagValue);
    })
</script>
<!-- 유효성검사 -->
<script>
    function validation() {
        if($('#category > option:selected').val() == "select") {
            alert("카테고리를 입력해주세요");
            return false;
        }

        if(getByte($('#name').val()) == "") {
            alert("모임명을 입력해주세요");
            return false;
        } else if(getByte($('#name').val()) > 70) {
            alert("모임명을 20자 이하로 작성해주세요");
            return false;
        }

        if(getByte($('#description').val()) == "") {
            alert("한줄소개를 입력해주세요");
            return false;
        } else if(getByte($('#description').val()) > 120) {
            alert("한줄소개를 40자 이내로 작성해주세요")
            return false;
        }

        if(getByte($('#info').val()) == "") {
            alert("모임정보를 입력해주세요");
            return false;
        } else if(getByte($('#info').val()) > 4000) {
            alert("모임 정보가 너무 깁니다");
            return false;
        }

        if($('#sido > option:selected').val() == "select") {
            alert("지역을 입력해주세요");
            return false;
        }

        if($('#sigungu > option:selected').val() == "select") {
            alert("지역을 입력해주세요");
            return false;
        }

        if($('#tags > option:selected').val() == "select") {
            alert("태그를 입력해주세요");
            return false;
        }

        return true;
    }

    function getByte(str) {
        let byte = 0;
        for (let i=0; i<str.length; ++i) {
            (str.charCodeAt(i) > 127) ? byte += 3 : byte++ ;
        }
        return byte;
    }
</script>







<%@include file="../includes/footer.jsp" %>
