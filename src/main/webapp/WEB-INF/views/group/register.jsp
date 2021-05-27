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
    <form role="form" action="/group/register" method="post">
        <h4 style="margin-top : 3rem; margin-bottom : 3rem;">모임정보입력</h4>
        <div class="form-group">
            <label for="userId" hidden>아이디</label>
            <input type="text" class="form-control" id="userId" name="userId" required
            value="${pinfo.username}" readonly="readonly" hidden>
        </div>

        <div class="form-group">
            <label for="name">모임명</label>
            <input type="text" class="form-control" name="name" id="name" required>
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
            <textarea class="form-control" rows="2" id="description" name="description" required></textarea>
        </div>

        <div class="form-group">
            <label for="info">모임정보 - 모임에 대해 자세히 적어주세요(운영계획, 공부할 책제목 등)</label>
            <textarea class="form-control" rows="20" id="info" name="info" required></textarea>
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
                    <option value="LOGU01" hidden="hidden">강남구</option>
                    <option value="LOGU02" hidden="hidden">강동구</option>
                    <option value="LOGU03" hidden="hidden">강북구</option>
                    <option value="LOGU04" hidden="hidden">강서구</option>
                    <option value="LOGU05" hidden="hidden">관악구</option>
                    <option value="LOGU06" hidden="hidden">광진구</option>
                    <option value="LOGU07" hidden="hidden">구로구</option>
                    <option value="LOGU08" hidden="hidden">금천구</option>
                    <option value="LOGU09" hidden="hidden">노원구</option>
                    <option value="LOGU10" hidden="hidden">도봉구</option>
                    <option value="LOGU11" hidden="hidden">동대문구</option>
                    <option value="LOGU12" hidden="hidden">동작구</option>
                    <option value="LOGU13" hidden="hidden">마포구</option>
                    <option value="LOGU14" hidden="hidden">서대문구</option>
                    <option value="LOGU15" hidden="hidden">서초구</option>
                    <option value="LOGU16" hidden="hidden">성동구</option>
                    <option value="LOGU17" hidden="hidden">성북구</option>
                    <option value="LOGU18" hidden="hidden">송파구</option>
                    <option value="LOGU19" hidden="hidden">양천구</option>
                    <option value="LOGU20" hidden="hidden">영등포구</option>
                    <option value="LOGU21" hidden="hidden">용산구</option>
                    <option value="LOGU22" hidden="hidden">은평구</option>
                    <option value="LOGU23" hidden="hidden">종로구</option>
                    <option value="LOGU24" hidden="hidden">중구</option>
                    <option value="LOGU25" hidden="hidden">중랑구</option>
                    <option value="LOSI01" hidden="hidden">고양시</option>
                    <option value="LOSI02" hidden="hidden">과천시</option>
                    <option value="LOSI03" hidden="hidden">광명시</option>
                    <option value="LOSI04" hidden="hidden">광주시</option>
                    <option value="LOSI05" hidden="hidden">구리시</option>
                    <option value="LOSI06" hidden="hidden">군포시</option>
                    <option value="LOSI07" hidden="hidden">김포시</option>
                    <option value="LOSI08" hidden="hidden">남양주시</option>
                    <option value="LOSI09" hidden="hidden">동두천시</option>
                    <option value="LOSI10" hidden="hidden">미금시</option>
                    <option value="LOSI11" hidden="hidden">부천시</option>
                    <option value="LOSI12" hidden="hidden">성남시</option>
                    <option value="LOSI13" hidden="hidden">송탄시</option>
                    <option value="LOSI14" hidden="hidden">수원시</option>
                    <option value="LOSI15" hidden="hidden">시흥시</option>
                    <option value="LOSI16" hidden="hidden">안산시</option>
                    <option value="LOSI17" hidden="hidden">안성시</option>
                    <option value="LOSI18" hidden="hidden">안양시</option>
                    <option value="LOSI19" hidden="hidden">양주시시</option>
                    <option value="LOSI20" hidden="hidden">양주시</option>
                    <option value="LOSI21" hidden="hidden">여주시</option>
                    <option value="LOSI22" hidden="hidden">여주시</option>
                    <option value="LOSI23" hidden="hidden">오산시</option>
                    <option value="LOSI24" hidden="hidden">용인시</option>
                    <option value="LOSI25" hidden="hidden">의왕시</option>
                    <option value="LOSI26" hidden="hidden">의정부</option>
                    <option value="LOSI27" hidden="hidden">이천시</option>
                    <option value="LOSI28" hidden="hidden">파주시</option>
                    <option value="LOSI29" hidden="hidden">평택시</option>
                    <option value="LOSI30" hidden="hidden">포천시</option>
                    <option value="LOSI31" hidden="hidden">포천시</option>
                    <option value="LOSI32" hidden="hidden">하남시</option>
                    <option value="LOSI33" hidden="hidden">화성시</option>
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
            <select class="form-control" id="tags" name="tags">
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



        <sec:csrfInput/>
        <button type="submit" class="btn btn-primary">등록</button>
        <button type="reset" class="btn btn-secondary">목록</button>
    </form>
</div>

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

    $(document).ready(function(e) {

        let formObj = $("form[role='form']");
        let regex = new RegExp("(.*?)\.(png|jpg|jpeg|bmp|gif)$");
        let maxSize = 5242880;
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        $("button[type='submit']").on("click", function(e) {

            e.preventDefault();

            console.log("submit clicked");

            if(!validation()) {
                return;
            }

            //$("#info").val($("#info").val().replace(/(?:\r\n|\r|\n)/g, '<br/>'));
            //console.log($("#info").val());


            let str = "";

            $('.uploadResult ul li').each(function(i, obj) {

                let jobj = $(obj);

                console.dir(jobj);

                str += "<input type='hidden' name='attach.fileName' value='"+jobj.data("filename")+"'>";
                str += "<input type='hidden' name='attach.uuid' value='"+jobj.data("uuid")+"'>";
                str += "<input type='hidden' name='attach.uploadPath' value='"+jobj.data("path")+"'>";
                str += "<input type='hidden' name='attach.fileType' value='"+jobj.data("type")+"'>";

            })

            formObj.append(str).submit();
        })

        $("button[type='reset']").on("click", function(e) {
            e.preventDefault();

            window.location.href = "/group/list";
            //formObj.attr("action", '/group/list').attr('method', 'get');
            //formObj.submit();
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
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                },
                data: formData,
                type: 'POST',
                dataType:'json',
                success: function(result) {
                    console.log(">>>>>>>" + result);
                    showUploadResult(result);
                },
                error: function (result) {
                    console.log(">>>>>>>" + result);
                }
            })

        })

        $(".uploadResult").on("click", "button", function(e) {
            console.log("delete file");

            let targetFile = $(this).data("file");
            let type = $(this).data("type");

            let targetLI = $(this).closest("li");

            $('.custom-file-label').html("없음");

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
<script>
    // Add the following code if you want the name of the file appear on select
    $(".custom-file-input").on("change", function() {
        var fileName = $(this).val().split("\\").pop();
        $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
    });
</script>




<%@include file="../includes/footer.jsp" %>
