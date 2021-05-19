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
<%--                    <img src="${room.yourPicture}" alt="">--%>
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
            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg" alt="">
<%--            <img src="${member.picture}" alt="">--%>
            <div>
                <h2 style="margin-top: 15px;">${member.name}</h2>
            </div>
        </header>
        <ul id="chat" style="border-top-width: 0px;">

        </ul>
        <footer style="margin-top: 0px;">
            <textarea name="contents" placeholder="Type your message"></textarea>
            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_picture.png" alt="" style="visibility: hidden">
            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_file.png" alt="" style="visibility: hidden">
            <a href="" id="sendBtn" style="margin-left: 490px;">Send</a>
        </footer>

        <form id="toChatRoom" action="" method="get"></form>
    </main>
</div>

<%@include file="../includes/footer.jsp" %>

<script type="text/javascript" src="/resources/js/chat.js"></script>

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

            if(data === "reload chatList") {

                //채팅방 리로드
                reloadChatList();
            }
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

            //ajax - register
            chatService.registerRoom({senderId : "${pinfo.username}", receiverId : "${member.id}", contents : contents}, function(result) {

                // 해당 채팅방으로 이동
                $('#toChatRoom').attr("action", "/chat/room/" + result);
                $('#toChatRoom').submit();

            })

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

                if(result[i].contents.length >= 10) {
                    str += result[i].contents.substring(0, 10) + '...';
                }else {
                    str += result[i].contents;
                }
                str += '</h3>';
                str += '</div>';
                str += '<div style="float:right">';

                let date = new Date(result[i].sendDate);
                let year = (date.getFullYear() + '');
                let month = (date.getMonth() + 1) < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1;
                let day = date.getDate() < 10 ? '0' + date.getDate() : date.getDate();
                let hours = date.getHours() < 10 ? '0' + date.getHours() : date.getHours();
                let min = date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes();

                str += '<h3 style="float:right;margin-right: 10px;">';
                str += year.substring(2, 4) + '/' + month + '/' + day + ' ' + hours + ':' + min;
                str += '</h3>';
                str += '<br>';

                if(result[i].unreadMsg > 0) {
                    str += '<h3 style="float:right;margin-right: 10px;background-color: red; padding: 3px 6px; border-radius: 50%; color: white">';
                    str += result[i].unreadMsg;
                    str += '</h3>';
                }
                str += '</div>';
                str += '</a>';
                str += '</li>';

            }

            $('#chatList').html(str);

        })
    }
</script>