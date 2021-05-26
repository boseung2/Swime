<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@include file="../includes/header.jsp" %>

<head>
    <link rel="stylesheet" href="/resources/css/chat.css">
</head>


<div id="container" style="margin-top: 48px;">
    <aside>
        <header>
            <input type="text" placeholder="search">
        </header>
        <ul id="chatList">
            <c:forEach var="room" items="${rooms}">
                <li>
                    <a style="display: block" href="/chat/room/${room.chatRoomId}">

                        <c:if test="${room.yourPicture != null && room.yourPicture != 'myPicture.jpeg'}">
                            <c:set var="src" value="${fn:replace(('/display?fileName=' += room.yourPicture), 's_', '')}"/>
                            <c:set var="style" value="style='width: 60px; height: 60px; '"/>
                        </c:if>
                        <c:if test="${room.yourPicture == null || room.yourPicture == 'myPicture.jpeg'}">
                            <c:set var="src" value="https://image.flaticon.com/icons/png/512/3237/3237472.png"/>
                        </c:if>
                        <img src="${src}" ${style} alt="">

                    <div>
                        <h2>${room.yourName}</h2>

                        <h3>
                            <c:if test="${fn:length(room.contents) >= 10}">
                                ${fn:substring(room.contents, 0, 10)}...
                            </c:if>
                            <c:if test="${fn:length(room.contents) < 10}">
                                ${room.contents}
                            </c:if>
                        </h3>
                    </div>
                    <div style="float:right">
                        <h3 style="float:right;margin-right: 10px;"><fmt:formatDate value="${room.sendDate}" pattern="yy/MM/dd HH:ss"/></h3>
                        <br>

                        <c:if test="${room.unreadMsg > 0}">
                            <h3 style="float:right;margin-right: 10px;background-color: red; padding: 3px 6px; border-radius: 50%; color: white">
                                    ${room.unreadMsg}
                            </h3>
                        </c:if>
                    </div>
                </a>
                </li>
            </c:forEach>
        </ul>
    </aside>
    <main>
        <header>
            <c:if test="${you.picture != null && you.picture != 'myPicture.jpeg'}">
                <c:set var="src" value="${fn:replace(('/display?fileName=' += you.picture), 's_', '')}"/>
                <c:set var="style" value="style='width: 60px; height: 60px;'"/>
            </c:if>
            <c:if test="${you.picture == null || you.picture == 'myPicture.jpeg'}">
                <c:set var="src" value="https://image.flaticon.com/icons/png/512/3237/3237472.png"/>
            </c:if>

            <img src="${src}" ${style} alt="">
            <div>
                <h2 style="margin-top: 15px;">${you.name}</h2>
            </div>
        </header>
        <ul id="chat" style="border-top-width: 0px;">
            <c:forEach var="message" items="${messages}">
                <c:if test="${you.id == message.senderId}">
                    <li class="you">
                        <div class="entete">
                            <span class="status green"></span>
                            <h2>${you.name}</h2>
                            <h3><fmt:formatDate value="${message.sendDate}" pattern="yy/MM/dd HH:ss"/></h3>
                        </div>
                        <div class="triangle"></div>
                        <div class="message">
                            ${message.contents}
                        </div>
                    </li>
                </c:if>

                <c:if test="${me.id == message.senderId}">
                    <li class="me">
                        <div class="entete">
                            <h3><fmt:formatDate value="${message.sendDate}" pattern="yy/MM/dd HH:ss"/></h3>
                            <h2>나 = ${me.name}</h2>
                            <span class="status blue"></span>
                        </div>
                        <div class="triangle" style="margin-left: 530px;"></div>
                        <c:if test="${message.status == 'MSST02'}">
                            <h3>안읽음</h3>
                        </c:if>
                        <div class="message">
                                ${message.contents}
                        </div>
                    </li>
                </c:if>
            </c:forEach>

        </ul>
        <footer style="background-color:#eff3f7; margin-top: 0px;">
            <textarea id="contents" placeholder="Type your message"></textarea>
            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_picture.png" alt="" style="visibility: hidden">
            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_file.png" alt="" style="visibility: hidden">
            <a href="" id="sendBtn" style="margin-left: 490px;">Send</a>
        </footer>
    </main>
</div>

<%@include file="../includes/footer.jsp" %>

<%--<script type="text/javascript" src="/resources/js/chat.js"></script>--%>
<script>

    $(document).ready(function() {
        <!-- 스크롤바가 존재하면 비어있지 않으면 스크롤바 맨 밑으로 내리기 -->
        if($('#chat').scroll != null) {
            $('#chat').scrollTop($('#chat')[0].scrollHeight);
        }

        enterKey();

    })
</script>

<!-- 웹소켓-->
<script type="text/javascript">

    $(document).ready(function() {

        // 연결됐을 때
        chatSocket.onopen = onOpen;

        function onOpen() {
            chatSocket.send(JSON.stringify({chatRoomId : "${chatRoomId}", type: "ENTER", senderId : "${pinfo.username}"}));
        }

        // 메시지 왔을때
        chatSocket.onmessage = onRoomMessage;

        function onRoomMessage(e) {
            let data = e.data;

            if(data === "reload chatList") {

                //채팅방 리로드
                reloadChatList();

                return;
            }

            if(data === "reload chatMsg") {
                // 채팅 메시지 리로드
                reloadChatMsg();

                return;
            }

            // 채팅방 밑에 추가
            let arr = data.split(",");
            let chatRoomId = arr[0];
            let senderId = arr[1];
            let contents = arr[2];
            let status = arr[3];
            let sendDate = new Date();

            if(chatRoomId === "${chatRoomId}") {
                let msg = '';

                let year = (sendDate.getFullYear() + '');
                let month = (sendDate.getMonth() + 1) < 10 ? '0' + (sendDate.getMonth() + 1) : sendDate.getMonth() + 1;
                let day = sendDate.getDate() < 10 ? '0' + sendDate.getDate() : sendDate.getDate();
                let hours = sendDate.getHours() < 10 ? '0' + sendDate.getHours() : sendDate.getHours();
                let min = sendDate.getMinutes() < 10 ? '0' + sendDate.getMinutes() : sendDate.getMinutes();

                if("${pinfo.username}" === senderId) {
                    msg += '<li class="me">';
                    msg += '<div class="entete">';
                    msg += '<h3>';
                    msg += year.substring(2, 4) + '/' + month + '/' + day + ' ' + hours + ':' + min;
                    msg += '</h3> ';
                    msg += '<h2> 나 =' + "${me.name}" + '</h2>';
                    msg += '<span class="status blue"></span>';
                    msg += '</div>';
                    msg += '<div class="triangle" style="margin-left: 530px;"></div>';

                    if(status === 'MSST02') {
                        msg += '<h3>안읽음 </h3>';
                    }
                    msg += ' <div class="message">';
                    msg += contents;
                    msg += '</div>';
                    msg += '</li>';

                }else {
                    msg += '<li class="you">';
                    msg += '<div class="entete">';
                    msg += '<span class="status green"></span>';
                    msg += '<h2>' + "${you.name}" + '</h2>';
                    msg += '<h3>';
                    msg += year.substring(2, 4) + '/' + month + '/' + day + ' ' + hours + ':' + min;
                    msg += ' </h3>';
                    msg += '</div>';
                    msg += '<div class="triangle"></div>';
                    msg += '<div class="message">';
                    msg += contents;
                    msg += '</div>';
                    msg += '</li>';

                }

                // 온 메시지와 해당 채팅방의 id가 같으면 화면에 뿌려준다.
                let chat = $('#chat').html();
                $('#chat').html(chat + msg);

                // 스크롤바 맨밑으로 내리기
                if($('#chat').scroll != null) {
                    $('#chat').scrollTop($('#chat')[0].scrollHeight);
                }
            }

            // 채팅방 리스트를 다시 불러온다.
            reloadChatList();

        }
    })

</script>

<script>

    function reloadChatMsg() {
        chatService.getMsg("${id}", function(result){

            if(result == null || result.length == 0) return;

            let msg = '';

            for(let i = 0; i < result.length; i++) {

                let date = new Date(result[i].sendDate);
                let year = (date.getFullYear() + '');
                let month = (date.getMonth() + 1) < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1;
                let day = date.getDate() < 10 ? '0' + date.getDate() : date.getDate();
                let hours = date.getHours() < 10 ? '0' + date.getHours() : date.getHours();
                let min = date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes();

                if(result[i].senderId === "${pinfo.username}") {
                    msg += '<li class="me">';
                    msg += '<div class="entete">';
                    msg += '<h3>';
                    msg += year.substring(2, 4) + '/' + month + '/' + day + ' ' + hours + ':' + min;
                    msg += '</h3> ';
                    msg += '<h2> 나 =' + "${me.name}" + '</h2>';
                    msg += '<span class="status blue"></span>';
                    msg += '</div>';
                    msg += '<div class="triangle" style="margin-left: 530px;"></div>';

                    if(result[i].status === 'MSST02') {
                        msg += '<h3>안읽음 </h3>';
                    }
                    msg += ' <div class="message">';
                    msg += result[i].contents;
                    msg += '</div>';
                    msg += '</li>';

                }else {
                    msg += '<li class="you">';
                    msg += '<div class="entete">';
                    msg += '<span class="status green"></span>';
                    msg += '<h2>' + "${you.name}" + '</h2>';
                    msg += '<h3>';
                    msg += year.substring(2, 4) + '/' + month + '/' + day + ' ' + hours + ':' + min;
                    msg += ' </h3>';
                    msg += '</div>';
                    msg += '<div class="triangle"></div>';
                    msg += '<div class="message">';
                    msg += result[i].contents;
                    msg += '</div>';
                    msg += '</li>';
                }
            }

            $('#chat').html(msg);

            // 스크롤바 맨밑으로 내리기
            if($('#chat').scroll != null) {
                $('#chat').scrollTop($('#chat')[0].scrollHeight);
            }
        })

    }
</script>


<script>

    $('#sendBtn').on("click", function(e) {
        e.preventDefault();

        // 유효성 검사
        if ($('#contents')[0].value === "" || $('#contents')[0].value.length >= 1000) { // 비어있으면 send 못함
            alert('빈문자열이거나 1000자 이상은 보낼 수 없습니다.');
            return;
        }

        // 공백만 있으면 send 못함
        let flag = false;
        let contents = $('#contents')[0].value;
        for(let i = 0; i < contents.length; i++) {
            if(contents[i] !== " ") {
                flag = true;
                break;
            }
        }

        if(flag) {
            // chatHandler로 메시지 보내기

            chatSocket.send(JSON.stringify(
                {chatRoomId : "${chatRoomId}", senderId : "${pinfo.username}", receiverId : "${you.id}",
                    contents : $('#contents').val(), type : "CHAT"}
                )
            );

            // 채팅 치는 칸 비워주기
            $('#contents')[0].value = "";
        }

    })

    function enterKey() {
        $("#contents").focus(function () {
            enterActive();
        });
        $("#contents").focusout(function () {
            enterActiveOff();
        });

        function enterActive() {

            $("#contents").on("keyup", function (key) {
                key.preventDefault();
                let msg = $("#contents")[0];
                if(key.keyCode === 13 && !key.shiftKey) {
                    let lastEnter = msg.value.lastIndexOf('\n');
                    msg.value = msg.value.substring(0, lastEnter).replaceAll('\n', '<br>');
                    $("#sendBtn").click();
                }
            });
        }

        function enterActiveOff() {
            $("#contents").off("keyup");
        }
    }

</script>