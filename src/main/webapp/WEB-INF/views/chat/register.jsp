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
        <ul>
            <c:forEach var="room" items="${rooms}">
                <li><a style="display: block" href="/chat/room/${room.chatRoomId}">
                    <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg" alt="">
                    <div>

                        <h2>${room.yourName}</h2>

                        <h3>
                            <span class="status orange"></span>
                            ${room.contents}
                        </h3>
                    </div>
                </a>
                </li>
            </c:forEach>

        </ul>
    </aside>
    <main>
        <header>
            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg" alt="">
            <div>
                <h2>${member.name}</h2>
                <h3>already 1902 messages</h3>
            </div>
        </header>
        <ul id="chat" style="border-top-width: 0px;">

        </ul>
        <footer style="margin-top: 0px;">
            <form id="registerForm" action="/chat/register" method="post">
                <textarea name="contents" placeholder="Type your message"></textarea>
                <input type="hidden" name="receiverId" value="${member.id}">
                <input type="hidden" name="senderId" value="${pinfo.username}">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
            </form>
            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_picture.png" alt="" style="visibility: hidden">
            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_file.png" alt="" style="visibility: hidden">
            <a href="" id="sendBtn" style="margin-left: 490px;">Send</a>
        </footer>
    </main>
</div>

<%@include file="../includes/footer.jsp" %>

<script>

    $(document).ready(function() {
        <!-- 스크롤바가 존재하면 비어있지 않으면 스크롤바 맨 밑으로 내리기 -->
        if($('#chat').length !== 0) {
            $('#chat').scrollTop($('#chat')[0].scrollHeight);
        }

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

        // 데이터 전달받았을 때
        sock.onmessage = onMessage;

        function onMessage(e) {
            let data = e.data;

            // 채팅방 리스트를 다시 불러온다.
        }

    })

</script>

<script>

    $('#sendBtn').on("click", function(e) {
        e.preventDefault();

        // 유효성 검사
        if ($('textarea[name="contents"]')[0].value === "") { // 비어있으면 send 못함
            return;
        }

        let flag = false;
        let contents = $('textarea[name="contents"]')[0].value;
        for(let i = 0; i < contents.length; i++) {
            if(contents[i] !== " ") {
                flag = true;
                break;
            }
        }

        if(flag) {
            $('#registerForm').submit();
        }

    })

</script>