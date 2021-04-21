<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<h1>스타 테스트</h1>
<style>
    .star_score span {
        display: inline-block;
        height: 14px;
        width: 80px;
        background: url(https://ssl.pstatic.net/static/movie/2019/09/sp_ico3.png) no-repeat -9999px -9999px;
    }

    .star_score span.st_off {
        position: relative;

        margin-right: 2px;
        background-position: 0 -706px;
    }

    span.st_on {
        position: absolute;
        z-index: 10;
        background-position: 0 -690px;
        /*width: 67.0%;*/
    }
</style>


<div id="place"></div>
<div id="place1"></div>
<div id="place2"></div>

<script>

    $(document).ready(function (){

        // let star = $("span > .st_on")[0];
        //
        // $(star).css("width", 10);
        // console.dir(star);

        $("#place").html(star(33));
        $("#place1").html(star(66));
        $("#place2").html(star(100));
    });

    function star(percent){
        let width = 80 * (percent / 100);
        let tag = ''
            +'<div class="star_score" id="netizen_point_tab_inner">'
            +'  <span class="st_off">'
            +'      <span class="st_on" style="width:' + width + 'px;">'
            +'      </span>'
            +'  </span>'
            +'</div>';
        return tag;
    }


</script>