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

            <c:if test="${member.picture != null && member.picture != 'myPicture.jpeg'}">
                <c:set var="src" value="${fn:replace(('/display?fileName=' += member.picture), 's_', '')}"/>
                <c:set var="style" value="style='width: 60px; height: 60px;'"/>
            </c:if>
            <c:if test="${member.picture == null || member.picture == 'myPicture.jpeg'}">
                <c:set var="src" value="https://image.flaticon.com/icons/png/512/3237/3237472.png"/>
            </c:if>

            <img src="${src}" ${style} alt="">

            <div>
                <h2 style="margin-top: 15px;">${member.name}</h2>
            </div>
        </header>
        <ul id="chat" style="border-top-width: 0px;">

        </ul>
        <footer style="background-color:#eff3f7; margin-top: 0px;">
            <textarea name="contents" placeholder="Type your message"></textarea>
            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_picture.png" alt="" style="visibility: hidden">
            <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_file.png" alt="" style="visibility: hidden">
            <a href="" id="sendBtn" style="margin-left: 490px;">Send</a>
        </footer>

        <form id="toChatRoom" action="" method="get"></form>
    </main>
</div>

<%@include file="../includes/footer.jsp" %>

<%--<script type="text/javascript" src="/resources/js/chat.js"></script>--%>

<script>

    $(document).ready(function() {
        <!-- 스크롤바가 존재하면 비어있지 않으면 스크롤바 맨 밑으로 내리기 -->
        if($('#chat').length !== 0) {
            $('#chat').scrollTop($('#chat')[0].scrollHeight);
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

                console.log("만들어진 chatRoomId = " + result);

                chatSocket.send(JSON.stringify(
                    {chatRoomId : result, senderId : "${pinfo.username}", receiverId : "${member.id}",
                        contents : contents, type : "REGISTER", status:"MSST02"}
                    )
                );

                // 해당 채팅방으로 이동
                $('#toChatRoom').attr("action", "/chat/room/" + result);
                $('#toChatRoom').submit();

            })

        }

    })

</script>