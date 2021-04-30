<%--
  Created by IntelliJ IDEA.
  User: tht12
  Date: 2021-04-29
  Time: 오후 3:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/header.jsp" %>

<button id="github">github</button>

<script>

    // let code = $('?code').val();
    let urlParams = new URLSearchParams(window.location.search);
    let code = urlParams.get("code");
    console.log(code);

    let clientID = '190944c4173bf58cc6e5';
    let clientSecret = '6cef3b8bb7a83ca00207f602539850c53f549dff';

    $("#github").on("click",function () {
        sendData();
    });

    function sendData(){
        // $.ajaxSetup({ dataType: "jsonp" });

        try{
            $.ajax({
                // beforeSend: function(xhr) {
                //     xhr.setRequestHeader("Access-Control-Allow-Origin", "*");
                // },
                crossOrigin : true,
                url: 'https://github.com/login/oauth/access_token',
                type: 'GET',
                data: {
                    client_id : clientID,
                    client_secret : clientSecret,
                    code : code
                },
                xhrFields: {
                    withCredentials: true
                },
                crossDomain: true,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    console.log();
                    console.log("성공");

                },
                error : function (result) {
                    console.log(result);
                    console.log("에러");
                }
            });
        }catch (e) {
            console.log(e);
        }

    }

    <%--const app = express();--%>

    <%--app.get('/callback', (req, res) => {--%>
    <%--    //'/callback': 인증 정보를 바탕으로 access token을 받아올 수 있도록 도와주는 라우터이다.--%>
    <%--    const requestToken = req.query.code //이 req.query.code가 위의 'code=[Authorization Code]' 에 해당한다.--%>
    <%--    axios({--%>
    <%--        method: 'post',--%>
    <%--        url: `https://github.com/login/oauth/access_token?client_id=${clientID}&client_secret=${clientSecret}&code=${requestToken}`,--%>
    <%--        headers: {--%>
    <%--            accept: 'application/json',--%>
    <%--        },--%>
    <%--    }).then((response) => {--%>
    <%--        const accessToken = response.data.access_token //Github가 access_token을 응답으로 줄 것이다.--%>
    <%--        res.redirect(`/welcome.html?access_token=${accessToken}`) //그리고 이렇게 accessToken을 받은 사용자에 한해서만 welcome 페이지로 리다이렉트 된다.--%>
    <%--        //그리고 welcome 페이지를 구성하는 client에서 get fetch를 통해 token및 데이터를 받아오게 된다.--%>
    <%--    }).catch((err) => {--%>
    <%--        console.error(err)--%>
    <%--    })--%>
    <%--})--%>
</script>