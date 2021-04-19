<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<h1>작성 댓글</h1>
<style>
    element.style {
        width: 67.0%;
    }
    .score_ntz .sc_area .star_score span.st_on {
        position: absolute;
        z-index: 10;
        background-position: 0 -690px;
    }
    .score_ntz .sc_area .star_score span {
        display: inline-block;
        height: 14px;
        background: url(https://ssl.pstatic.net/static/movie/2019/09/sp_ico3.png) no-repeat -9999px -9999px;
    }
    .star_score span.st_on {
        overflow: hidden;
        position: absolute;
        top: 0;
        left: 0;
        z-index: 10;
        background-position: 0 -140px;
        text-indent: -9999px;
    }
    .star_score span {
        display: inline-block;
        height: 12px;
        background: url(https://ssl.pstatic.net/static/movie/2019/09/sp_ico3.png) no-repeat -9999px -9999px;
    }
    .score_ntz .sc_area .star_score {
        position: static;
        margin-right: 1px;
        line-height: 21px;
        height: 21px;
    }
    .graph_area .grade_tit {
        float: left;
        height: 58px;
        cursor: pointer;
    }
    #wrap.basic #content {
        width: 775px;
        text-align: left;
    }
    #wrap {
        position: relative;
        min-height: 100%;
        margin: 0 auto;
        padding-top: 7px;
        text-align: left;
        *background: url(https://ssl.pstatic.net/static/movie/2014/04/header_bg.png) repeat-y;
    }
    body {
        background: #727272 url(https://ssl.pstatic.net/static/movie/2012/06/body_bg.png) repeat;
        text-align: center;
    }
    .score_ntz .sc_area .star_score {
        position: static;
        margin-right: 1px;
        line-height: 21px;
        height: 21px;
    }
    .graph_area .grade_tit {
        float: left;
        height: 58px;
        cursor: pointer;
    }
    #wrap.basic #content {
        width: 775px;
        text-align: left;
    }
    #wrap {
        position: relative;
        min-height: 100%;
        margin: 0 auto;
        padding-top: 7px;
        text-align: left;
        *background: url(https://ssl.pstatic.net/static/movie/2014/04/header_bg.png) repeat-y;
    }
</style>

<div class="star_score" id="netizen_point_tab_inner">
    <span class="st_off">
        <span class="st_on" style="width:67.0%">
        </span>
    </span>
</div>