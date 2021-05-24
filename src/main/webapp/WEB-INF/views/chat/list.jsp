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
                            <c:set var="style" value="style='width: 54px; height: 54px; border-radius: 27px; border: 4px solid #6a6a76;'"/>
                        </c:if>
                        <c:if test="${room.yourPicture == null || room.yourPicture == 'myPicture.jpeg'}">
                            <c:set var="src" value="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg"/>
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