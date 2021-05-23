<%--
  Created by IntelliJ IDEA.
  User: tht12
  Date: 2021-05-16
  Time: 오후 3:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>

<%--<script src='../../../resources/js/a076d05399.js' crossorigin='anonymous'></script>--%>
<%--<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">--%>
<%--<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">--%>
<%--<link rel="stylesheet" href="../../../resources/css/mdbootstrap.css"/>--%>



<a class="btn btn-primary waves-effect waves-light" data-toggle="modal" data-target="#sideModalTRSuccessDemo" data-backdrop="true">Top
    Right</a>

<div class="modal fade " id="sideModalTRSuccessDemo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-backdrop="true" style="display: none;" data-gtm-vis-first-on-screen-2340190_1302="13349" data-gtm-vis-total-visible-time-2340190_1302="100" data-gtm-vis-has-fired-2340190_1302="1" aria-hidden="true">
    <div class="modal-dialog modal-side modal-top-right modal-notify modal-success" role="document">
        <!--Content-->
        <div class="modal-content">
            <!--Header-->
            <div class="modal-header">
                <p class="heading lead">Modal Success</p>

                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true" class="white-text">×</span>
                </button>
            </div>

            <!--Body-->
            <div class="modal-body">
                <div class="text-center">
                    <i class="fas fa-check fa-4x mb-3 animated rotateIn"></i>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Impedit iusto nulla aperiam blanditiis ad
                        consequatur
                        in dolores culpa, dignissimos, eius non possimus fugiat. Esse ratione fuga, enim, ab officiis totam.
                    </p>
                </div>
            </div>

            <!--Footer-->
            <div class="modal-footer justify-content-center">
                <a type="button" class="btn btn-success waves-effect waves-light">Get it now
                    <i class="far fa-gem ml-1"></i>
                </a>
                <a type="button" class="btn btn-outline-success waves-effect" data-dismiss="modal">No, thanks</a>
            </div>
        </div>
        <!--/.Content-->
    </div>
</div>

<%--<button type="button" id="success" class="btn btn-success m-1 ripple-surface">Success</button>--%>
<%--<div class="alert fade alert-success alert-fixed" id="alert-success" role="alert" data-mdb-color="success" data-mdb-position="top-right" data-mdb-stacking="true" data-mdb-width="535px" data-mdb-append-to-body="true" data-mdb-hidden="true" data-mdb-autohide="true" data-mdb-delay="2000" style="display: none; width: 535px; top: 10px; right: 10px; bottom: unset; left: unset; transform: unset;">--%>
<%--    A simple success alert with--%>
<%--    <a href="#" class="alert-link">an example link</a>. Give it a click if you like.--%>
<%--</div>--%>


request.getRemoteAddr() =<%= request.getRemoteAddr() %> <br>
request.getContentLength() =<%= request.getContentLength() %> <br>
request.getCharacterEncoding() =<%= request.getCharacterEncoding() %> <br>
request.getContentType() =<%= request.getContentType() %> <br>
request.getProtocol() =<%= request.getProtocol() %> <br>
request.getMethod() =<%= request.getMethod() %> <br>
request.getQueryString() =<%= request.getQueryString() %> <br>
request.getRequestURI() =<%= request.getRequestURI() %> <br>
request.getRequestURL() =<%= request.getRequestURL() %> <br>
request.getContextPath() =<%= request.getContextPath() %> <br>
request.getServletPath() =<%= request.getServletPath() %> <br>
request.getServerName() =<%= request.getServerName() %> <br>
request.getServerPort() =<%= request.getServerPort() %> <br>
