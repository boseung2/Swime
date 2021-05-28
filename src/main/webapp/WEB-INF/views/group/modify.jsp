<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>

<!-- 상단 이미지 -->
<div class="head-image">
    <div class="head-content" onclick="location.href='/group/register'">
        <p>모임만들기</p>
        회원들과 함께 모임을 이끌어 보세요.
    </div>
</div>
<!-- 상단 이미지 -->

<div class="container group-register">
    <form role="form" action="/group/modify" method="post">
        <div class="form-group">
            <label for="sn" hidden>모임번호</label>
            <input type="text" class="form-control" id="sn" name="sn" value="<c:out value="${group.sn}"/>" readonly="readonly" hidden>
        </div>
        <div class="form-group">
            <label for="userId" hidden>아이디</label>
            <input type="text" class="form-control" id="userId" name="userId" value="<c:out value="${group.userId}"/>" readonly="readonly" hidden>
        </div>

        <div class="form-group">
            <label for="name">모임명</label>
            <input type="text" class="form-control" name="name" id="name" value="<c:out value="${group.name}"/>" required>
        </div>

        <div class="form-group">
            <label for="category">카테고리</label>
            <select class="form-control" id="category" name="category" required>
                <option value="select">-------------</option>
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
            <label for="description">간단소개</label>
            <textarea class="form-control" rows="2" id="description" name="description" required><c:out value="${group.description}"/></textarea>
        </div>

        <div class="form-group">
            <label for="info">모임정보 - 모임에 대해 자세히 적어주세요(운영계획, 공부할 책제목 등)</label>
            <textarea class="form-control" rows="20" id="info" name="info" required><c:out value="${group.info}"/></textarea>
        </div>

        <div class="form-group">
        <div class="form-row">
            <div class="col">
                <label for="sido">시/도</label>
                <select class="form-control" id="sido" name="sido">
                    <option value="select">-------------</option>
                    <option value="LODO01">서울특별시</option>
                    <option value="LODO02">경기도</option>
                </select>
            </div>
            <div class="col">
                <label for="sigungu">시/군/구</label>
                <select class="form-control" id="sigungu" name="sigungu">
                    <option value="select">-------------</option>
                    <option value="LOGU01">강남구</option>
                    <option value="LOGU02">강동구</option>
                    <option value="LOGU03">강북구</option>
                    <option value="LOGU04">강서구</option>
                    <option value="LOGU05">관악구</option>
                    <option value="LOGU06">광진구</option>
                    <option value="LOGU07">구로구</option>
                    <option value="LOGU08">금천구</option>
                    <option value="LOGU09">노원구</option>
                    <option value="LOGU10">도봉구</option>
                    <option value="LOGU11">동대문구</option>
                    <option value="LOGU12">동작구</option>
                    <option value="LOGU13">마포구</option>
                    <option value="LOGU14">서대문구</option>
                    <option value="LOGU15">서초구</option>
                    <option value="LOGU16">성동구</option>
                    <option value="LOGU17">성북구</option>
                    <option value="LOGU18">송파구</option>
                    <option value="LOGU19">양천구</option>
                    <option value="LOGU20">영등포구</option>
                    <option value="LOGU21">용산구</option>
                    <option value="LOGU22">은평구</option>
                    <option value="LOGU23">종로구</option>
                    <option value="LOGU24">중구"</option>
                    <option value="LOGU25">중랑구</option>
                    <option value="select">-------------</option>
                    <option value="LOSI01">고양시</option>
                    <option value="LOSI02">과천시</option>
                    <option value="LOSI03">광명시</option>
                    <option value="LOSI04">광주시</option>
                    <option value="LOSI05">구리시</option>
                    <option value="LOSI06">군포시</option>
                    <option value="LOSI07">김포시</option>
                    <option value="LOSI08">남양주시</option>
                    <option value="LOSI09">동두천시</option>
                    <option value="LOSI10">미금시</option>
                    <option value="LOSI11">부천시</option>
                    <option value="LOSI12">성남시</option>
                    <option value="LOSI13">송탄시</option>
                    <option value="LOSI14">수원시</option>
                    <option value="LOSI15">시흥시</option>
                    <option value="LOSI16">안산시</option>
                    <option value="LOSI17">안성시</option>
                    <option value="LOSI18">안양시</option>
                    <option value="LOSI19">양주시</option>
                    <option value="LOSI20">양주시</option>
                    <option value="LOSI21">여주시</option>
                    <option value="LOSI22">여주시</option>
                    <option value="LOSI23">오산시</option>
                    <option value="LOSI24">용인시</option>
                    <option value="LOSI25">의왕시</option>
                    <option value="LOSI26">의정부</option>
                    <option value="LOSI27">이천시</option>
                    <option value="LOSI28">파주시</option>
                    <option value="LOSI29">평택시</option>
                    <option value="LOSI30">포천시</option>
                    <option value="LOSI31">포천시</option>
                    <option value="LOSI32">하남시</option>
                    <option value="LOSI33">화성시</option>
                </select>
            </div>
        </div>
        </div>


        <p>대표사진</p>
        <div class="form-group">
            <div class="uploadDiv">
                <div class="custom-file">
                    <label for="uploadFile" class="custom-file-label">없음</label>
                    <input type="file" class="form-control custom-file-input" id="uploadFile" name="uploadFile" accept="image/*">
                    <div class="uploadResult">
                        <ul>

                        </ul>
                    </div>
                </div>
            </div>
        </div>



        <div class="form-group">
            <label for="tags">태그</label>
            <select class="form-control" id="tags" name="tags" >
                <option value="select">-------------</option>
                <option value="GRTG01">HTML</option>
                <option value="GRTG02">CSS</option>
                <option value="GRTG03">Java Script</option>
                <option value="GRTG04">Vue.js</option>
                <option value="GRTG05">React</option>
                <option value="GRTG06">Java</option>
                <option value="GRTG07">Python</option>
                <option value="GRTG08">Node.js</option>
                <option value="GRTG09">Spring</option>
                <option value="GRTG10">Spring Boot</option>
                <option value="GRTG11">Django</option>
                <option value="GRTG12">Android</option>
                <option value="GRTG13">IOS</option>
                <option value="GRTG14">Kotlin</option>
                <option value="GRTG15">Firebase</option>
                <option value="GRTG16">Flutter</option>
                <option value="GRTG17">React Native</option>
                <option value="GRTG18">IONIC</option>
                <option value="GRTG19">Unity</option>
                <option value="GRTG20">C#</option>
                <option value="GRTG21">C</option>
                <option value="GRTG22">Unreal Engine</option>
                <option value="GRTG23">Swift</option>
                <option value="GRTG24">C++</option>
                <option value="GRTG25">Scratch</option>
                <option value="GRTG26">UE Blueprints</option>
                <option value="GRTG27">R</option>
                <option value="GRTG28">코딩테스트</option>
                <option value="GRTG29">자료구조</option>
                <option value="GRTG30">운영체제</option>
                <option value="GRTG31">알고리즘</option>
                <option value="GRTG32">SQL</option>
                <option value="GRTG33">MySQL</option>
                <option value="GRTG34">Oracle</option>
                <option value="GRTG35">JPA</option>
                <option value="GRTG36">MongoDB</option>
                <option value="GRTG37">MsSQL</option>
                <option value="GRTG38">IntelliJ</option>
                <option value="GRTG39">Eclipse</option>
                <option value="GRTG40">Excel</option>
            </select>
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

        <h2>멤버 관리</h2>
        <hr/>
        <!-- 멤버 리스트 -->
        <div id="groupAttend">
            <ul class="attend">
                <li data-sn="1203">
                    <div>
                        <div class="attendCard">
                            <img src="../../../resources/img/img_avatar2.png" alt="Avatar" class="avatar"><b>정보승</b>	<span style="color:gray">회원</span>
                        </div>
                        <div class="attendBtn" style="text-decoration: underline; color: red;"><a href="#" id="">모임장양도</a><a href="#" class="changeManager" data-sn="1203">운영진임명</a><a href="#" class="ban">추방</a></div>
                    </div>
                </li>
            </ul>
        </div>
        <!-- 멤버 관리 -->
        <script>
            $(document).ready(function() {

                let grpSnValue = '<c:out value="${group.sn}"/>';
                let attendUL = $(".attend");

                let userId = null;
                <sec:authorize access="isAuthenticated()">
                userId = "${pinfo.username}";
                </sec:authorize>

                let csrfHeaderName = "${_csrf.headerName}";
                let csrfTokenValue = "${_csrf.token}";

                // ajax spring security header
                $(document).ajaxSend(function(e, xhr, options) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                });

                showList();

                function showList() {
                    groupAttendService.getListWithBan({grpSn:grpSnValue}, function(list) {
                        let str = "";
                        if(list == null || list.length == 0) {
                            attendUL.html("");
                            return;
                        }

                        for(let i=0, len=list.length || 0; i<len; i++) {
                            str += "<li data-sn='"+list[i].sn+"'>";

                            // str += "<div><div class='attendCard'><img src='../../../resources/img/img_avatar2.png' alt='Avatar' class='avatar'>";

                            console.log("pic=" + list[i].picture);
                            if(list[i].picture !== null && list[i].picture !== 'myPicture.jpeg') {

                                str += '<div><div class="attendCard"><img src="' + '/display?fileName=' + list[i].picture.replace('s_', '') + '" alt="Avatar" class="avatar">';
                            }else {
                                str += '<div><div class="attendCard"><img src="https://image.flaticon.com/icons/png/512/3237/3237472.png" alt="Avatar" class="avatar">';
                            }

                            str += "<b>"+list[i].name+"</b>\t";
                            str += "<span style='color:gray'>"+ (list[i].status !== "GRUS03" ? list[i].grpRole : '영구추방회원') +"</span></div><div class='attendBtn' data-sn='"+list[i].sn+"' style='text-decoration: underline; color: red;'>"
                            if(list[i].status === "GRUS03") {
                                str += "<a href='#' class='cancelBan'>영구추방해제</a>"
                            } else if(userId !== list[i].userId) {
                                str += "<a href='#' class='changeLeader'>모임장양도</a>"
                                if(list[i].grpRole === "운영진") {
                                    str += "<a href='#' class='cancelManager'>운영진해제</a>"
                                } else {
                                    str += "<a href='#' class='changeManager'>운영진임명</a>"
                                }
                                if(list[i].status === "GRUS01") {
                                    str += "<a href='#' class='ban'>추방</a>"
                                }
                            }
                            str += "</div></div></li>"
                        }
                        attendUL.html(str);
                    })
                }

                let attend = $('.attend');

                attend.on("click", "li", function(e) {
                    e.preventDefault();

                    if(e.target === $(this).find('.changeManager')[0]) {
                        // 운영진 임명 클릭시
                        groupAttendService.changeManager($(this).data('sn'), function(result) {
                            alert('운영진임명완료');
                            showList();
                        })
                    } else if(e.target === $(this).find('.cancelManager')[0]) {
                        // 운영진 해제 클릭시
                        groupAttendService.cancelManager($(this).data('sn'), function(result) {
                            alert('운영진해제완료');
                            showList();
                        })
                    } else if(e.target === $(this).find('.changeLeader')[0]) {
                        // 모임장 임명 클릭시
                        let result = confirm("정말 모임장을 양도하시겠습니까?(모임장 양도는 되돌릴 수 없습니다.");
                        if(result === false) {
                            return;
                        }
                        groupAttendService.changeLeader($(this).data('sn'), function(result) {
                            alert('정상적으로 양도되었습니다.');
                            // group/get 페이지로 이동해야함
                            window.location.href="get?sn=" + "<c:out value="${group.sn}"/>";
                        })
                    } else if(e.target === $(this).find('.ban')[0]) {
                        // 추방 버튼 클릭시
                        let permanent = confirm("사용자를 영구추방하시겠습니까?(취소를 선택하면 추방한 유저는 재가입이 가능합니다.)");
                        if(permanent) {
                            groupAttendService.banPermanent($(this).data('sn'), function(result) {
                                alert('영구추방했습니다');
                                showList();
                            })
                        } else {
                            groupAttendService.ban($(this).data('sn'), function(result) {
                                alert('추방했습니다.');
                                showList();
                            })
                        }
                    } else if(e.target === $(this).find('.cancelBan')[0]) {
                        groupAttendService.cancelBan($(this).data('sn'), function(result) {
                            alert('영구추방해제완료');
                            showList();
                        })
                    }
                });
            })
        </script>



        <br>
        <c:if test="${pinfo.username eq group.userId}">
            <button type="submit" class="btn btn-warning" data-oper="modify">수정</button>
            <button type="submit" class="btn btn-danger" data-oper="remove">삭제</button>
        </c:if>
        <button type="submit" class="btn btn-secondary" data-oper="list">취소</button>
    </form>
</div>

<!-- GroupAttend Module -->
<script type="text/javascript" src="/resources/js/groupAttend.js"></script>
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

                formObj.attr("action", '/group/get?sn=' + "<c:out value="${group.sn}"/>").attr("method", "get");
                //let pageNumTag = $("input[name='pageNum']").clone();
                //let amountTag = $("input[name='amount']").clone();

                //formObj.empty();
                //formObj.append(pageNumTag);
                //formObj.append(amountTag);

            }else if(operation === 'modify') {

                console.log("submit clicked");

                let str = "";

                if(!validation()) {
                    return;
                }

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
        let regex = new RegExp("(.*?)\.(png|jpg|jpeg|bmp)$");

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
                        //str += "<span> "+obj.fileName+"</span>";
                        str += "<img src='/display?fileName="+fileCallPath+"'>";
                        str += "<button type='button' class='btn btn-dark btn-circle' data-file=\'"+fileCallPath+"\' data-type='image'>X</button>";
                        str += "</div>";
                        str += "</li>";

                        $('.custom-file-label').html(attach.fileName);
                    } else {
                        let fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
                        str += "<li";
                        str += "data-path='" + attach.uploadPath + "' data-uuid='"+attach.uuid+"'data-filename='" + attach.fileName + "'data-type='" + attach.fileType+"'><div>";
                        //str += "<span> " + attach.fileName+"</span>";
                        //str += "<span> "+obj.fileName+"</span>";
                        str += "<img src='/resources/img/attach.png'></a>";
                        str += "<button type='button' class='btn btn-dark btn-circle' data-file=\'"+fileCallPath+"\' data-type='image'>X</button>";
                        str += "</div>";
                        str += "</li>";
                    }

                })

                $(".uploadResult ul").html(str);
            });
        })();

        $(".uploadResult").on("click", "button", function(e) {

            console.log("delete file");

            $('.custom-file-label').html("없음");

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

            if(!regex.test(fileName)) {
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
                    //str += "<span> "+obj.fileName+"</span>";
                    str += "<img src='/display?fileName="+fileCallPath+"'>";
                    str += "<button type='button' class='btn btn-dark btn-circle' data-file=\'"+fileCallPath+"\' data-type='image'>X</button>";
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
        let tagValue = '<c:out value="${group.tags}"/>';
        tagValue = tagValue.substr(1, tagValue.length-2); // 임시로 []제거

        console.log(tag);
        console.log(tagValue);

        const setSelectBox = (selectBox, value) => {
            for(let i=0; i<selectBox.length; i++) {
                if(selectBox[i].outerText === value) {
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
            alert("간단소개를 입력해주세요");
            return false;
        } else if(getByte($('#description').val()) > 300) {
            alert("간단소개를 90자 이내로 작성해주세요")
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
<script>
    // Add the following code if you want the name of the file appear on select
    $(".custom-file-input").on("change", function() {
        var fileName = $(this).val().split("\\").pop();
        $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
    });
</script>

<!-- 시/군/구를 시/도에 맞게 변경-->
<script>
    $(document).ready(function() {
        $('#sido').on("change", function() {
            let options = $('#sigungu option');

            for(let i=1; i<options.length; i++) {
                options[i].setAttribute("hidden", "hidden");
            }

            if($('#sido option:selected').val() == "LODO01") {
                // 서울특별시일때
                for(let i=0; i<options.length; i++) {
                    if(options[i].value.substr(0,4) == "LOGU") {
                        options[i].removeAttribute("hidden");
                    }
                }
            }else if($('#sido option:selected').val() == "LODO02") {
                // 경기도일때
                for(let i=0; i<options.length; i++) {
                    if(options[i].value.substr(0,4) == "LOSI") {
                        options[i].removeAttribute("hidden");
                    }
                }
            }
        })
    })
</script>





<%@include file="../includes/footer.jsp" %>
