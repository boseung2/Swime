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
            <li>
                <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg" alt="">
                <div>
                    <h2>Prénom Nom</h2>
                    <h3>
                        <span class="status orange"></span>
                        offline
                    </h3>
                </div>
            </li>
            <li>
                <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_02.jpg" alt="">
                <div>
                    <h2>Prénom Nom</h2>
                    <h3>
                        <span class="status green"></span>
                        online
                    </h3>
                </div>
            </li>
            <li>
                <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_03.jpg" alt="">
                <div>
                    <h2>Prénom Nom</h2>
                    <h3>
                        <span class="status orange"></span>
                        offline
                    </h3>
                </div>
            </li>
            <li>
                <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_04.jpg" alt="">
                <div>
                    <h2>Prénom Nom</h2>
                    <h3>
                        <span class="status green"></span>
                        online
                    </h3>
                </div>
            </li>
            <li>
                <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_05.jpg" alt="">
                <div>
                    <h2>Prénom Nom</h2>
                    <h3>
                        <span class="status orange"></span>
                        offline
                    </h3>
                </div>
            </li>
            <li>
                <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_06.jpg" alt="">
                <div>
                    <h2>Prénom Nom</h2>
                    <h3>
                        <span class="status green"></span>
                        online
                    </h3>
                </div>
            </li>
            <li>
                <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_07.jpg" alt="">
                <div>
                    <h2>Prénom Nom</h2>
                    <h3>
                        <span class="status green"></span>
                        online
                    </h3>
                </div>
            </li>
            <li>
                <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_08.jpg" alt="">
                <div>
                    <h2>Prénom Nom</h2>
                    <h3>
                        <span class="status green"></span>
                        online
                    </h3>
                </div>
            </li>
            <li>
                <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_09.jpg" alt="">
                <div>
                    <h2>Prénom Nom</h2>
                    <h3>
                        <span class="status green"></span>
                        online
                    </h3>
                </div>
            </li>
            <li>
                <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_10.jpg" alt="">
                <div>
                    <h2>Prénom Nom</h2>
                    <h3>
                        <span class="status orange"></span>
                        offline
                    </h3>
                </div>
            </li>
        </ul>
    </aside>
    <main>
        <header>
            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg" alt="">
            <div>
                <h2>Chat with Vincent Porter</h2>
                <h3>already 1902 messages</h3>
            </div>
        </header>
        <ul id="chat" style="border-top-width: 0px;">
            <li class="you">
                <div class="entete">
                    <span class="status green"></span>
                    <h2>Vincent</h2>
                    <h3>10:12AM, Today</h3>
                </div>
                <div class="triangle"></div>
                <div class="message">
                    Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.
                </div>
            </li>
            <li class="me">
                <div class="entete">
                    <h3>10:12AM, Today</h3>
                    <h2>Vincent</h2>
                    <span class="status blue"></span>
                </div>
                <div class="triangle" style="margin-left: 530px;"></div>
                <div class="message">
                    Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.
                </div>
            </li>
            <li class="me">
                <div class="entete">
                    <h3>10:12AM, Today</h3>
                    <h2>Vincent</h2>
                    <span class="status blue"></span>
                </div>
                <div class="triangle" style="margin-left: 530px;"></div>
                <div class="message">
                    OK
                </div>
            </li>
            <li class="you">
                <div class="entete">
                    <span class="status green"></span>
                    <h2>Vincent</h2>
                    <h3>10:12AM, Today</h3>
                </div>
                <div class="triangle"></div>
                <div class="message">
                    Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.
                </div>
            </li>
            <li class="me">
                <div class="entete">
                    <h3>10:12AM, Today</h3>
                    <h2>Vincent</h2>
                    <span class="status blue"></span>
                </div>
                <div class="triangle" style="margin-left: 530px;"></div>
                <div class="message">
                    Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor.
                </div>
            </li>
            <li class="me">
                <div class="entete">
                    <h3>10:12AM, Today</h3>
                    <h2>Vincent</h2>
                    <span class="status blue"></span>
                </div>
                <div class="triangle" style="margin-left: 530px;"></div>
                <div class="message">
                    OK
                </div>
            </li>
        </ul>
        <footer style="margin-top: 0px;">
            <textarea placeholder="Type your message"></textarea>
            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_picture.png" alt="" style="visibility: hidden">
            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_file.png" alt="" style="visibility: hidden">
            <a href="#" style="margin-left: 490px;">Send</a>
        </footer>
    </main>
</div>

<%@include file="../includes/footer.jsp" %>

<script>

    $(document).ready(function() {
        <!-- 스크롤바가 존재하면 비어있지 않으면 스크롤바 맨 밑으로 내리기 -->
        if($('#chat').scroll != null) {
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