<%--
  Created by IntelliJ IDEA.
  User: sinseonggwon
  Date: 2021/05/06
  Time: 4:09 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<link href="../webapp/resources/assets">

<div class="main-container">
    <main class="main-wrapper">
        <section>
            <h1 style="display: none;">Main</h1>
            <div class="main-left">
                <h2 style="font-weight: bold">어떤 프로그래밍 언어를<br>공부하시나요?</h2>
                <div class="search-form">
                    <form action="#" method="get">
                        <label>
                            <input type="text" name="search" maxlength="20" placeholder="언어를 입력하세요"/>
                        </label>
                    </form>
                    <div class="flex-flow"></div>
                    <a href="#"><i class="fab fa-sistrix"></i></a>
                </div>

                <div class="language-list">
                    <ul class="language-top">
                        <li>
                            <a href="#"><i class="fab fa-java"></i><br><span class="language-icon">JAVA</span></a>
                        </li>
                        <li>
                            <a href="#"><i class="fab fa-python"></i><br><span class="language-icon">PYTHON</span></a>
                        </li>
                        <li>
                            <a href="#"><i class="fab fa-js-square"></i><br><span class="language-icon">JAVASCRIPT</span></a>
                        </li>
                        <li>
                            <a href="#"><i class="fab fa-react"></i><br><span class="language-icon">REACT</span></a>
                        </li>
                        <li>
                            <a href="#"><i class="fab fa-css3-alt"></i><br><span class="language-icon">CSS3</span></a>
                        </li>
                    </ul>
                    <ul class="language-bottom">
                        <li>
                            <a href="#"><i class="fab fa-vuejs"></i><br><span class="language-icon">VUE.JS</span></a>
                        </li>
                        <li>
                            <a href="#"><i class="fab fa-sass"></i><br><span class="language-icon">SASS</span></a>
                        </li>
                        <li>
                            <a href="#"><i class="fab fa-php"></i><br><span class="language-icon">PHP</span></a>
                        </li>
                        <li>
                            <a href="#"><i class="fab fa-node"></i><br><span class="language-icon">NODE.JS</span></a>
                        </li>
                        <li>
                            <a href="#"><i class="fas fa-ellipsis-h"></i><br><span class="language-icon">ETC</span></a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="main-right">
                <img src="/resources/assets/Main03.png" alt="메인 이미지">
            </div>
<%--</div>--%>
        </section>
    </main>
</div>

<!-- 인기있는 모임 -->
<div class="card-container" id="card-container">
    <article>
        <h1 class="mainContainerTitle">인기있는 모임</h1>
        <div class="flex-flow"></div>
        <h2>
            <a href="/group/list">전체보기 &#62;</a>
        </h2>
    </article>

    <div style="display: flex; justify-content: space-evenly">

        <a onclick="slider.prev()" class="button-box"><i class="fas fa-chevron-left"></i></a>
        <div class="card-wrap" id="slider">

<%--            <div>--%>
<%--                <div class="cardCon">--%>
<%--                    <div class="card-img1"></div>--%>
<%--                    <div class="card-content">--%>
<%--                        <span>서울 강남</span>--%>
<%--                        <h3>자바의 정석</h3>--%>
<%--                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.<br> Voluptates, quos enim.</p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <a href="#">--%>
<%--                <div class="cardCon">--%>
<%--                    <div class="card-img1"></div>--%>
<%--                    <div class="card-content">--%>
<%--                        <span>서울 강남</span>--%>
<%--                        <h3>자바의 정석</h3>--%>
<%--                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.<br> Voluptates, quos enim.</p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a href="#">--%>
<%--                <div class="cardCon">--%>
<%--                    <div class="card-img1"></div>--%>
<%--                    <div class="card-content">--%>
<%--                        <span>서울 종로</span>--%>
<%--                        <h3>파이썬의 고수</h3>--%>
<%--                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.<br> Voluptates, quos enim.</p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </a>--%>

<%--            <a href="#">--%>
<%--                <div class="cardCon">--%>
<%--                    <div class="card-img1"></div>--%>
<%--                    <div class="card-content">--%>
<%--                        <span>서울 시청</span>--%>
<%--                        <h3>JAVA DESIGN PATTERNS</h3>--%>
<%--                        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.<br> Voluptates, quos enim.</p>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </a>--%>

        </div>

        <a onclick="slider.next(this)" class="button-box"><i class="fas fa-chevron-right"></i></a>

    </div>
</div>

<%--<script>--%>
<%--    $("#nextBtn").on("click", function (e) {--%>
<%--        e.preventDefault();--%>
<%--        slider.next();--%>
<%--    })--%>
<%--</script>--%>

<%--<div class="card-container">--%>
<%--    <article>--%>
<%--        <h1 class="mainContainerTitle">인기있는 스터디</h1>--%>
<%--        <div class="flex-flow"></div>--%>
<%--        <h2>--%>
<%--            <a href="#">전체보기 &#62;</a>--%>
<%--        </h2>--%>
<%--    </article>--%>
<%--    <div style="display: flex; justify-content: space-evenly">--%>

<%--    <a onclick="slidertwo.prev()" class="button-box"><i class="fas fa-chevron-left"></i></a>--%>
<%--    <div class="card-wrap" id="slider2">--%>
<%--        <a href="#">--%>
<%--            <div class="cardCon">--%>
<%--                <div class="card-img1"></div>--%>
<%--                <div class="card-content">--%>
<%--                    <span>자바의 정석</span>--%>
<%--                    <h3>객체지향</h3>--%>
<%--                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.<br> Voluptates, quos enim.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </a>--%>
<%--        <a href="#">--%>
<%--            <div class="cardCon">--%>
<%--                <div class="card-img1"></div>--%>
<%--                <div class="card-content">--%>
<%--                    <span>JAVA DESIGN PATTERNS</span>--%>
<%--                    <h3>디자인 패턴 기초</h3>--%>
<%--                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.<br> Voluptates, quos enim.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </a>--%>
<%--        <a href="#">--%>
<%--            <div class="cardCon">--%>
<%--                <div class="card-img1"></div>--%>
<%--                <div class="card-content">--%>
<%--                    <span>MODERN JAVASCRIPT</span>--%>
<%--                    <h3>함수와 클래스</h3>--%>
<%--                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.<br> Voluptates, quos enim.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </a>--%>
<%--        <a href="#">--%>
<%--            <div class="cardCon">--%>
<%--                <div class="card-img1"></div>--%>
<%--                <div class="card-content">--%>
<%--                    <span>MODERN JAVASCRIPT22</span>--%>
<%--                    <h3>함수와 클래스</h3>--%>
<%--                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit.<br> Voluptates, quos enim.</p>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </a>--%>
<%--    </div>--%>
<%--    <a onclick="slidertwo.next(this)" class="button-box"><i class="fas fa-chevron-right"></i></a>--%>
<%--    </div>--%>
<%--</div>--%>

<script>
    const Slider = function (id, _web, _tab, _mobile, spacingParam) {
        let containerWidth = 0;
        let sliderItemWidth = 0;
        let totalCount = 0;
        let spacing = spacingParam || 10;
        let display = _web;
        let left = 0;
        let interval;

        let DOM = {
            container: function (id) {
                console.log(sliderItemWidth);
                let dom = document.querySelector('#' + id);
                dom.className = 's-container';
                dom.style.position = 'relative';
                dom.style.overflow = 'hidden';
                return dom;
            },
            slider: function (container) {
                console.log(sliderItemWidth);

                totalCount = container.children.length;

                var dom = document.createElement('div');
                dom.className = 'slider'
                dom.style.position = 'relative';
                dom.style.overflow = 'hidden';
                dom.style.height = '100%';
                dom.style.left = 0;
                dom.style.transition = 'left .5s';
                return dom;
            }
        }

        // DOM 만들기
        let container = DOM.container(id);
        let slider = DOM.slider(container);
        let temp = container.innerHTML;
        container.innerHTML = '';
        slider.innerHTML = temp;
        container.appendChild(slider);
        let items = document.querySelector('#' + id + ' .slider').children;
        for (let i = 0; i < items.length; i++) {
            items[i].style.float = 'left';
            items[i].style.height = '100%';
            items[i].style.width = (sliderItemWidth - spacing) + 'px';
            items[i].style['margin-right'] = spacing + 'px'; // 간격
        }

        // 화면 사이즈 수정시 발생하는 이벤트
        function resize() {
            console.log(sliderItemWidth + "1");

            left = 0;
            document.querySelector('#' + id + ' .slider').style.left = left + 'px';

            let innerWidth = window.innerWidth;
            if (innerWidth >= 1000) {
                setDisplayCount(_web);
            } else if (innerWidth < 1000 && innerWidth >= 768) {
                setDisplayCount(_tab);
            } else if (innerWidth < 768) {
                setDisplayCount(_mobile);
            }

            if (display === 1) {
                spacing = 0;
                let items = document.querySelector('#' + id + ' .slider').children;
                for (var i = 0; i < items.length; i++) {
                    items[i].style.width = sliderItemWidth + 'px';
                    items[i].style['margin-right'] = 0 + 'px'; // 간격
                }

            }
            console.log(sliderItemWidth + "2");

        }

        // 디스플레이 갯수 설정 함수
        function setDisplayCount(count) {
            console.log(sliderItemWidth === 0);

            display = count;

            let size = $("#card-container")[0].offsetWidth;
            // containerWidth = container.offsetWidth + spacing;
            containerWidth = (containerWidth === 0 ? 960 : container.offsetWidth + spacing);
            sliderItemWidth = containerWidth / display;
            console.log("offset" + container.offsetWidth);
            console.log("spacing" + spacing);

            console.log(containerWidth)
            console.log(display)

            document.querySelector('#' + id + ' .slider').style.width = totalCount * sliderItemWidth + spacing * totalCount + 'px';
            let items = document.querySelector('#' + id + ' .slider').children;
            for (let i = 0; i < items.length; i++) {
                items[i].style.width = (sliderItemWidth - spacing) + 'px';
            }
            console.log(sliderItemWidth === 0);

        }

        // 반응형 디스플레이 갯수 조절
        let isResponsive = _tab !== undefined && _mobile !== undefined;
        if (isResponsive) {
            window.onresize = resize;
        }
        resize();


        return {
            setDisplayCount: setDisplayCount,
            move: function (index) {
                left = (-1) * sliderItemWidth * index;
                document.querySelector('#' + id + ' .slider').style.left = left + 'px';
            },
            prev: function () {
                left += sliderItemWidth;
                let limit = 0;
                if (left > limit) {
                    left = limit;
                }
                document.querySelector('#' + id + ' .slider').style.left = left + 'px';
            },
            next: function () {
                left -= sliderItemWidth;
                let limit = (-1) * sliderItemWidth * (totalCount - display);
                if (left < limit) {
                    left = limit;
                }
                $("#" + id + "> .slider")[0].style.left = left + 'px';
                // document.querySelector('#'+ id + ' .slider').style.left = left + 'px';
            },
            // auto: function(){
            //   clearInterval(interval);
            //   interval = setInterval(function(){
            //     left -= sliderItemWidth;
            //     var limit = (-1) * sliderItemWidth * (totalCount - display);
            //     if(left < limit){
            //       left = 0;
            //     }
            //     document.querySelector('#'+ id + ' .slider').style.left = left + 'px';
            //   }, 2000)
            // },
            // stop: function(){
            //   clearInterval(interval);
            // }
        }
    };

    let slider = undefined;
    let slidertwo = new Slider('slider2',3,3,1,20);
    // slider.auto();

</script>


<script>
    requestAjax($("#slider"));

    function requestAjax(place) {
        $.ajax({
            url : "/getPopularGroupList",
            dataType: "json",
            data : {
                pageNum : 1,
                amount : 6
            }
        })
            .done(function (result) {
                let a = resultConvertHtml(result);
                $(place).html(a);
                slider = new Slider('slider', 3, 3, 1, 20);
                cardOnclick();
            })
            .fail(function () {
                console.log("error");
            })
    }
    
    function resultConvertHtml(result) {
        console.log(result);
        let str = "";

        for (let i = 0; i < result.length; i++) {
            let description = result[i].description;
            let name = result[i].name;
            let sn = result[i].sn;


            str += "" +
                "            <div class='index-card' data-sn='" + sn + "' style='cursor: pointer;'>\n" +
                "                <div class=\"cardCon\">\n" +
                "                    <div class=\"card-img1\" style='height: 50%;'></div>\n" +
                "                    <div class=\"card-content\" style='height: 50%; overflow: hidden;'>\n" +
                "                        <span>서울 강남</span>\n" +
                "                        <h3>" + name + "</h3>\n" +
                "                        <p>" + description + "</p>\n" +
                "                    </div>\n" +
                "                </div>\n" +
                "            </div>";
        }
        return str;
    }

    function cardOnclick() {
        $(".index-card").on("click", function () {
            location.href = '/group/get?sn=' + this.dataset.sn;
        })
    }
</script>