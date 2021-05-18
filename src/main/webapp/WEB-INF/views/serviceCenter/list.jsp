<%--
  Created by IntelliJ IDEA.
  User: toywa
  Date: 2021-04-30
  Time: 오후 12:04
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<style>
    div.ing{
        font-size: 100px;
        color: #6f42c1;
    }
    img.zz{
        display: block;
        margin: 0px auto;
        width: 1000px;

    }
    html {
        height: 100%;
        background: linear-gradient(#123 30%, #667);
        overflow: hidden;
    }
    .snow, .snow:before, .snow:after {
        position: absolute;
        top: -300px;
        left: 0;
        background-image: radial-gradient(5px 5px at 11px 517px, white 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 116px 176px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 253px 524px, rgba(255, 255, 255, 0.7) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 15px 106px, white 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 528px 318px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 426px 437px, rgba(255, 255, 255, 0.7) 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 19px 551px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 75px 57px, rgba(255, 255, 255, 0.7) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 481px 160px, rgba(255, 255, 255, 0.6) 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 37px 200px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 235px 542px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 409px 338px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 197px 474px, rgba(255, 255, 255, 0.7) 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 356px 591px, white 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 66px 165px, white 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 443px 141px, rgba(255, 255, 255, 0.7) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 324px 248px, rgba(255, 255, 255, 0.6) 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 297px 375px, white 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 533px 209px, white 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 355px 89px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 78px 161px, white 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 162px 524px, rgba(255, 255, 255, 0.6) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 548px 374px, rgba(255, 255, 255, 0.7) 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 467px 206px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 249px 122px, rgba(255, 255, 255, 0.8) 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 174px 285px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 7px 294px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 424px 458px, rgba(255, 255, 255, 0.6) 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 134px 357px, rgba(255, 255, 255, 0.6) 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 421px 560px, rgba(255, 255, 255, 0.8) 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 373px 61px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 69px 146px, rgba(255, 255, 255, 0.8) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 255px 224px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 92px 257px, rgba(255, 255, 255, 0.8) 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 366px 262px, rgba(255, 255, 255, 0.8) 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 82px 72px, rgba(255, 255, 255, 0.8) 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 389px 244px, white 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 484px 277px, rgba(255, 255, 255, 0.6) 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 439px 226px, white 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 65px 473px, rgba(255, 255, 255, 0.6) 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 569px 423px, rgba(255, 255, 255, 0.7) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 442px 293px, rgba(255, 255, 255, 0.7) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 223px 341px, rgba(255, 255, 255, 0.6) 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 521px 305px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 13px 152px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 548px 563px, rgba(255, 255, 255, 0.7) 50%, rgba(0, 0, 0, 0)),
        radial-gradient(3px 3px at 190px 161px, rgba(255, 255, 255, 0.8) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 93px 574px, white 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 17px 478px, rgba(255, 255, 255, 0.6) 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 497px 497px, rgba(255, 255, 255, 0.8) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 87px 147px, rgba(255, 255, 255, 0.7) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 554px 408px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 144px 208px, rgba(255, 255, 255, 0.9) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 278px 54px, rgba(255, 255, 255, 0.6) 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 554px 298px, rgba(255, 255, 255, 0.7) 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 337px 577px, rgba(255, 255, 255, 0.8) 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 492px 374px, white 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 374px 133px, rgba(255, 255, 255, 0.8) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 70px 190px, white 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 462px 295px, white 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 375px 69px, rgba(255, 255, 255, 0.7) 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 500px 377px, rgba(255, 255, 255, 0.7) 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 385px 222px, rgba(255, 255, 255, 0.6) 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 83px 577px, rgba(255, 255, 255, 0.8) 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 219px 159px, white 50%, rgba(0, 0, 0, 0)), radial-gradient(4px 4px at 313px 74px, rgba(255, 255, 255, 0.7) 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 589px 577px, white 50%, rgba(0, 0, 0, 0)), radial-gradient(3px 3px at 92px 37px, rgba(255, 255, 255, 0.8) 50%, rgba(0, 0, 0, 0)), radial-gradient(6px 6px at 126px 431px, rgba(255, 255, 255, 0.6) 50%, rgba(0, 0, 0, 0)), radial-gradient(5px 5px at 290px 75px, rgba(255, 255, 255, 0.8) 50%, rgba(0, 0, 0, 0));
        bottom: 0;
        right: 0;
        background-size: 600px 600px;
        animation: snow 3s linear infinite;
        content: "";
    }
    .snow:after {
        margin-left: -200px;
        opacity: 0.4;
        animation-duration: 6s;
        animation-direction: reverse;
        filter: blur(3px);
    }
    .snow:before {
        animation-duration: 9s;
        animation-direction: reverse;
        margin-left: -300px;
        opacity: 0.65;
        filter: blur(1.5px);
    }
    @keyframes snow {
        to {
            transform: translateY(600px);
        }
    }

</style>



<div class="snow">
    <img class="zz" src="../../../resources/img/2.png">
    <div class="ing">구현중입니다</div>
</div>


