<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>
<c:set var="defaultImg" value="https://streamyard.com/resources/assets/images/docs/connect-a-facebook-group/connect-a-facebook-group.jpg"/>

<!-- Page Content -->
    <div class="container">
        <h2>모임 찾기</h2>
        <hr>

        <!-- 검색필터 -->
        <div class="filter">
            <h4 style="font-family: 'Roboto', sans-serif;">Filter</h4><br>
        <form class="form">
            <div class="form__group">
                <label for="country">카테고리</label>
                <select id="country" name="country" data-dropdown>
                    <option value="">전체</option>
                    <option value="GRCA01">프론트엔드</option>
                    <option value="GRCA02">백엔드</option>
                    <option value="GRCA03">앱 개발</option>
                    <option value="GRCA04">게임 개발</option>
                    <option value="GRCA05">프로그래밍 언어</option>
                    <option value="GRCA06">알고리즘</option>
                    <option value="GRCA07">데이터 사이언스</option>
                    <option value="GRCA08">데이터베이스</option>
                    <option value="GRCA09">컴퓨터 사이언스</option>
                    <option value="GRCA10">개발 도구</option>
                    <option value="GRCA11">교양 · 기타</option>
                </select>
            </div>
            <div class="form__group">
                <label for="location">지역</label>
                <select id="location" name="location" data-dropdown>
                    <option value="">전체</option>
                    <option value="LOGU01" hidden="hidden">서울시 강남구</option>
                    <option value="LOGU02" hidden="hidden">서울시 강동구</option>
                    <option value="LOGU03" hidden="hidden">서울시 강북구</option>
                    <option value="LOGU04" hidden="hidden">서울시 강서구</option>
                    <option value="LOGU05" hidden="hidden">서울시 관악구</option>
                    <option value="LOGU06" hidden="hidden">서울시 광진구</option>
                    <option value="LOGU07" hidden="hidden">서울시 구로구</option>
                    <option value="LOGU08" hidden="hidden">서울시 금천구</option>
                    <option value="LOGU09" hidden="hidden">서울시 노원구</option>
                    <option value="LOGU10" hidden="hidden">서울시 도봉구</option>
                    <option value="LOGU11" hidden="hidden">서울시 동대문구</option>
                    <option value="LOGU12" hidden="hidden">서울시 동작구</option>
                    <option value="LOGU13" hidden="hidden">서울시 마포구</option>
                    <option value="LOGU14" hidden="hidden">서울시 서대문구</option>
                    <option value="LOGU15" hidden="hidden">서울시 서초구</option>
                    <option value="LOGU16" hidden="hidden">서울시 성동구</option>
                    <option value="LOGU17" hidden="hidden">서울시 성북구</option>
                    <option value="LOGU18" hidden="hidden">서울시 송파구</option>
                    <option value="LOGU19" hidden="hidden">서울시 양천구</option>
                    <option value="LOGU20" hidden="hidden">서울시 영등포구</option>
                    <option value="LOGU21" hidden="hidden">서울시 용산구</option>
                    <option value="LOGU22" hidden="hidden">서울시 은평구</option>
                    <option value="LOGU23" hidden="hidden">서울시 종로구</option>
                    <option value="LOGU24" hidden="hidden">서울시 중구</option>
                    <option value="LOGU25" hidden="hidden">서울시 중랑구</option>
                    <option value="LOSI01" hidden="hidden">경기도 고양시</option>
                    <option value="LOSI02" hidden="hidden">경기도 과천시</option>
                    <option value="LOSI03" hidden="hidden">경기도 광명시</option>
                    <option value="LOSI04" hidden="hidden">경기도 광주시</option>
                    <option value="LOSI05" hidden="hidden">경기도 구리시</option>
                    <option value="LOSI06" hidden="hidden">경기도 군포시</option>
                    <option value="LOSI07" hidden="hidden">경기도 김포시</option>
                    <option value="LOSI08" hidden="hidden">경기도 남양주시</option>
                    <option value="LOSI09" hidden="hidden">경기도 동두천시</option>
                    <option value="LOSI10" hidden="hidden">경기도 미금시</option>
                    <option value="LOSI11" hidden="hidden">경기도 부천시</option>
                    <option value="LOSI12" hidden="hidden">경기도 성남시</option>
                    <option value="LOSI13" hidden="hidden">경기도 송탄시</option>
                    <option value="LOSI14" hidden="hidden">경기도 수원시</option>
                    <option value="LOSI15" hidden="hidden">경기도 시흥시</option>
                    <option value="LOSI16" hidden="hidden">경기도 안산시</option>
                    <option value="LOSI17" hidden="hidden">경기도 안성시</option>
                    <option value="LOSI18" hidden="hidden">경기도 안양시</option>
                    <option value="LOSI19" hidden="hidden">경기도 양주시시</option>
                    <option value="LOSI20" hidden="hidden">경기도 양주시</option>
                    <option value="LOSI21" hidden="hidden">경기도 여주시</option>
                    <option value="LOSI22" hidden="hidden">경기도 여주시</option>
                    <option value="LOSI23" hidden="hidden">경기도 오산시</option>
                    <option value="LOSI24" hidden="hidden">경기도 용인시</option>
                    <option value="LOSI25" hidden="hidden">경기도 의왕시</option>
                    <option value="LOSI26" hidden="hidden">경기도 의정부</option>
                    <option value="LOSI27" hidden="hidden">경기도 이천시</option>
                    <option value="LOSI28" hidden="hidden">경기도 파주시</option>
                    <option value="LOSI29" hidden="hidden">경기도 평택시</option>
                    <option value="LOSI30" hidden="hidden">경기도 포천시</option>
                    <option value="LOSI31" hidden="hidden">경기도 포천시</option>
                    <option value="LOSI32" hidden="hidden">경기도 하남시</option>
                    <option value="LOSI33" hidden="hidden">경기도 화성시</option>
                </select>
            </div>
            <div class="form__group">
                <label for="groupName">모임명</label>
                <input id="groupName" name="groupName" placeholder="모임명">
            </div>

            <button type="submit" class="btn">검색&nbsp;&nbsp;&nbsp;<i class="fas fa-search"></i></button>
        </form>
        </div>
        <!-- /검색필터 -->

        <script>
            // Get dropdowns and form
            const dropdowns = document.querySelectorAll('[data-dropdown]');
            const form = document.querySelector('form');

            // Check if dropdowns exist on page
            if(dropdowns.length > 0) {
                // Loop through dropdowns and create custom dropdown for each select element
                dropdowns.forEach(dropdown => {
                    createCustomDropdown(dropdown);
                });
            }

            // Check if form element exist on page
            if(form !== null) {
                // When form is submitted console log the value of the select field
                form.addEventListener('submit', (e) => {
                    e.preventDefault();
                    console.log('Selected country:', form.querySelector('[name="country"]').value);
                });
            }

            // Create custom dropdown
            function createCustomDropdown(dropdown) {
                // Get all options and convert them from nodelist to array
                const options = dropdown.querySelectorAll('option');
                const optionsArr = Array.prototype.slice.call(options);

                // Create custom dropdown element and add class dropdown to it
                // Insert it in the DOM after the select field
                const customDropdown = document.createElement('div');
                customDropdown.classList.add('dropdown');
                dropdown.insertAdjacentElement('afterend', customDropdown);

                // Create element for selected option
                // Add class to this element, text from the first option in select field and append it to custom dropdown
                const selected = document.createElement('div');
                selected.classList.add('dropdown__selected');
                selected.textContent = optionsArr[0].textContent;
                customDropdown.appendChild(selected);

                // Create element for dropdown menu, add class to it and append it to custom dropdown
                // Add click event to selected element to toggle dropdown menu
                const menu = document.createElement('div');
                menu.classList.add('dropdown__menu');
                customDropdown.appendChild(menu);
                selected.addEventListener('click', toggleDropdown.bind(menu));

                // Create serach input element
                // Add class, type and placeholder to this element and append it to menu element
                const search = document.createElement('input');
                search.placeholder = 'Search...';
                search.type = 'text';
                search.classList.add('dropdown__menu_search');
                menu.appendChild(search);

                // Create wrapper element for menu items, add class to it and append to menu element
                const menuItemsWrapper = document.createElement('div');
                menuItemsWrapper.classList.add('dropdown__menu_items');
                menu.appendChild(menuItemsWrapper);

                // Loop through all options and create custom option for each option and append it to items wrapper element
                // Add click event for each custom option to set clicked option as selected option
                optionsArr.forEach(option => {
                    const item = document.createElement('div');
                    item.classList.add('dropdown__menu_item');
                    item.dataset.value = option.value;
                    item.textContent = option.textContent;
                    menuItemsWrapper.appendChild(item);

                    item.addEventListener('click', setSelected.bind(item, selected, dropdown, menu));
                });

                // Add selected class to first custom option
                menuItemsWrapper.querySelector('div').classList.add('selected');

                // Add input event to search input element to filter items
                // Add click event to document element to close custom dropdown if clicked outside of it
                // Hide original dropdown(select)
                search.addEventListener('input', filterItems.bind(search, optionsArr, menu));
                document.addEventListener('click', closeIfClickedOutside.bind(customDropdown, menu));
                dropdown.style.display = 'none';
            }

            // Toggle dropdown
            function toggleDropdown() {
                // Check if dropdown is opened and if it is close it, otherwise open it and focus search input
                if(this.offsetParent !== null) {
                    this.style.display = 'none';
                }else {
                    this.style.display = 'block';
                    this.querySelector('input').focus();
                }
            }

            // Set selected option
            function setSelected(selected, dropdown, menu) {
                // Get value and label from clicked custom option
                const value = this.dataset.value;
                const label = this.textContent;

                // Change the text on selected element
                // Change the value on select field
                selected.textContent = label;
                dropdown.value = value;

                // Close the menu
                // Reset search input value
                // Remove selected class from previously selected option and show all divs if they were filtered
                // Add selected class to clicked option
                menu.style.display = 'none';
                menu.querySelector('input').value = '';
                menu.querySelectorAll('div').forEach(div => {
                    if(div.classList.contains('selected')) {
                        div.classList.remove('selected');
                    }
                    if(div.offsetParent === null) {
                        div.style.display = 'block';
                    }
                });
                this.classList.add('selected');
            }

            // Filter items
            function filterItems(itemsArr, menu) {
                // Get all custom options
                // Get the value of search input and convert it to all lowercase characters
                // Get filtered items
                // Get the indexes of filtered items
                const customOptions = menu.querySelectorAll('.dropdown__menu_items div');
                const value = this.value.toLowerCase();
                const filteredItems = itemsArr.filter(item => item.outerHTML.toLowerCase().includes(value));
                const indexesArr = filteredItems.map(item => itemsArr.indexOf(item));

                // Check if option is not inside indexes array and hide it and if it is inside indexes array and it is hidden show it
                itemsArr.forEach(option => {
                    if(!indexesArr.includes(itemsArr.indexOf(option))) {
                        customOptions[itemsArr.indexOf(option)].style.display = 'none';
                    }else {
                        if(customOptions[itemsArr.indexOf(option)].offsetParent === null) {
                            customOptions[itemsArr.indexOf(option)].style.display = 'block';
                        }
                    }
                });
            }

            // Close dropdown if clicked outside dropdown element
            function closeIfClickedOutside(menu, e) {
                if(e.target.closest('.dropdown') === null && e.target !== this && menu.offsetParent !== null) {
                    menu.style.display = 'none';
                }
            }
        </script>

        <hr class="centerHr">


    <!-- Content Row -->
    <div>
        <h4>N개의 모임</h4>
        <select>
            <option>최신순</option>
            <option>평점순</option>
            <option>모임원순</option>
        </select>
    </div>
    <div class="row">
        <c:forEach items="${list}" var="group">
            <div class="col-md-4 mb-5">
                <div class="card h-100">
                    <div class="card-body">
                        <div class="uploadResult">
                            <img class="img-fluid rounded mb-4 mb-lg-0" src="${!empty group.picture ? '/display?fileName=' += group.picture : defaultImg}" alt="">
                        </div>
                        <div class="flex-container" style="display: flex;">
                        <c:forEach items="${group.tags}" var="tag">
                            <div style="background-color: #f1f1f1;margin: 2px;padding: 2px;font-size: 15px;border-radius: 0.5rem;width: 80px;height: 25px; text-align:center;">
                            <b><c:out value="${tag}"/></b>
                            </div>
                        </c:forEach>
                        </div>
                        <h2 class="card-title"><c:out value="${group.name}"/><span style="color:gray;font-size:20px;">[<c:out value="${group.category}"/>]</span></h2>
                        <p class="card-text ratingPlace" id="stars${group.sn}" data-rating='<c:out value="${group.rating}"/>' data-ratingcount="<c:out value="${group.ratingCount}"/>"></p>
                        <p class="card-text"><i class="fas fa-map-marker-alt"></i> <c:out value="${group.sido}"/> <c:out value="${group.sigungu}"/></p>
                        <p><i class="fas fa-users"></i> <c:out value="${group.attendCount}"/>명</p>
                        <p class="card-text"><c:out value="${group.description}"/></p>

                    </div>
                    <div class="card-footer">
                        <a href="<c:out value="${group.sn}"/>" class="btn btn-primary btn-sm move">More Info</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <!-- /.row -->

    <!-- pagination -->
    <div class="pagination">
        <c:if test="${pageMaker.prev}">
            <li class="paginate_button previous">
            <a href="${pageMaker.startPage - 1}">&laquo;</a>
            </li>
        </c:if>

        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <li class="paginate_button">
                <a href="${num}" class="${pageMaker.cri.pageNum == num ? "active" : ""}">${num}</a>
            </li>
        </c:forEach>

        <c:if test="${pageMaker.next}">
            <li class="paginate_button next">
            <a href="${pageMaker.endPage + 1}">&raquo;</a>
            </li>
        </c:if>
    </div>
    <form id="actionForm" action="/group/list" method="get">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
    </form>

    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
    aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">모임</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <p>처리가 완료되었습니다.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /.container -->

<script type="text/javascript">
    $(document).ready(function(){
        let result = '<c:out value="${result}"/>';

        checkModal(result);

        history.replaceState({}, null, null);

        function checkModal(result) {

            if (result === '' || history.state) {
                return;
            }

            if (parseInt(result) > 0) {
                $('.modal-body').html('모임 ' + parseInt(result) + "번이 등록되었습니다.");
            }

            $("#myModal").modal("show");
        }

        $("#regBtn").on("click", function() {
            self.location = "/group/register";
        })

        let actionForm = $("#actionForm");

        $(".paginate_button a").on("click", function(e) {

            e.preventDefault();

            console.log('click');

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        })

        $('.move').on("click", function(e) {
            e.preventDefault();
            actionForm.append("<input type='hidden' name='sn' value='" + $(this).attr("href") + "'>");
            actionForm.attr("action", "/group/get");
            actionForm.submit();
        })
    })
</script>

<!-- 별 찍기 -->
<script>
    $(document).ready(function() {
        let list = $('.ratingPlace');
        for (let i = 0; i < list.length; i++) {
            $(list[i]).html(star($(list[i]).data("rating")) + '<b>' + $(list[i]).data("rating") + ' </b>(' + $(list[i]).data("ratingcount") + '개)');
        }
    })
    function star(rating){
        let width = 80 * (rating / 5);
        let tag = ''
            +'<span class="star_score" id="netizen_point_tab_inner">'
            +'  <span class="st_off">'
            +'      <span class="st_on" style="width:' + width + 'px;">'
            +'      </span>'
            +'  </span>'
            +'</span>';
        return tag;
    }
</script>


<%@include file="../includes/footer.jsp" %>