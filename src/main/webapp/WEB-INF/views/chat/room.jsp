<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
                <li><a style="display: block" href="/chat/room/${room.chatRoomId}">
                    <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg" alt="">
                    <div>

                        <h2>${room.yourName}</h2>

                        <h3>
                            <span>${room.contents}</span>
                        </h3>
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
                <c:set var="style" value="style='width: 54px; height: 54px; border-radius: 27px; border: 4px solid #6a6a76;'"/>
            </c:if>
            <c:if test="${you.picture == null || you.picture == 'myPicture.jpeg'}">
                <c:set var="src" value="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg"/>
            </c:if>

            <img src="${src}" ${style} alt="">
            <div>
                <h2>${you.name}</h2>
                <h3>already 1902 messages</h3>
            </div>
        </header>
        <ul id="chat" style="border-top-width: 0px;">
            <c:forEach var="message" items="${messages}">
                <c:if test="${you.id == message.senderId}">
                    <li class="you">
                        <div class="entete">
                            <span class="status green"></span>
                            <h2>${you.name}</h2>
                            <h3>${message.sendDate}</h3>
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
                            <h3>${message.sendDate}</h3>
                            <h2>나 = ${me.name}</h2>
                            <span class="status blue"></span>
                        </div>
                        <div class="triangle" style="margin-left: 530px;"></div>
                        <div class="message">
                                ${message.contents}
                        </div>
                    </li>
                </c:if>
            </c:forEach>

        </ul>
        <footer style="margin-top: 0px;">
            <textarea id="contents" placeholder="Type your message"></textarea>
            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_picture.png" alt="" style="visibility: hidden">
            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_file.png" alt="" style="visibility: hidden">
            <a href="" id="sendBtn" style="margin-left: 490px;">Send</a>
        </footer>
    </main>
</div>

<%@include file="../includes/footer.jsp" %>

<script type="text/javascript" src="/resources/js/chat.js"></script>
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
    // 전역변수 chatSocket
    let chatSocket = null;

    $(document).ready(function() {

        //웹소켓 연결
        let sock = new SockJS('/chat');
        chatSocket = sock;

        // 연결됐을 때
        sock.onopen = onOpen;
        // 데이터 전달받았을 때
        sock.onmessage = onMessage;

        function onOpen() {
            sock.send(JSON.stringify({chatRoomId : "${chatRoomId}", type: "ENTER", senderId : "${pinfo.username}"}));

        }


        function onMessage(e) {
            let data = e.data;

            if(data === "reload chatList") {

                //채팅방 리로드
                reloadChatList();

                return;
            }

            let arr = data.split(",");
            let chatRoomId = arr[0];
            let senderId = arr[1];
            let contents = arr[2];
            let sendDate = new Date();

            if(chatRoomId === "${chatRoomId}") {
                let msg = '';

                if("${pinfo.username}" === senderId) {
                    msg += '<li class="me">';
                    msg += '<div class="entete">';
                    msg += '<h3>' + sendDate + '</h3>';
                    msg += '<h2>나 =' + "${me.name}" + '</h2>';
                    msg += '<span class="status blue"></span>';
                    msg += '</div>';
                    msg += '<div class="triangle" style="margin-left: 530px;"></div>';
                    msg += '<div class="message">';
                    msg += contents;
                    msg += '</div>';
                    msg += '</li>';

                }else {
                    msg += '<li class="you">';
                    msg += '<div class="entete">';
                    msg += '<span class="status green"></span>';
                    msg += '<h2>' + "${you.name}" + '</h2>';
                    msg += '<h3>' + sendDate + '</h3>';
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
    function reloadChatList() {
        chatService.getList("${pinfo.username}", function(result) {

            if(result == null || result.length === 0) {
                return;
            }

            let str = "";

            for(let i = 0; i < result.length; i++) {
                str += '<li><a style="display: block" href="/chat/room/' + result[i].chatRoomId+ '">';
                str += '<img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg" alt="">';
                str += '<div>';
                str += '<h2>' + result[i].yourName + '</h2>';
                str += '<h3>';
                str += '<span>' + result[i].contents +'</span>';
                str += '</h3>';
                str += '</div>';
                str += '</a>';
                str += '</li>';

            }

            $('#chatList').html(str);

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