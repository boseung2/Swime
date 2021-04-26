<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<h1>member page</h1>

<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<link href="/resources/css/spinner.css" rel="stylesheet">

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        body {
            display: grid;
            font-family: Roboto;
            -webkit-text-size-adjust: 100%;
            -webkit-font-smoothing: antialiased;
        }

        * {
            box-sizing: border-box;
        }

        .inp {
            position: relative;
            margin: auto;
            width: 100%;
            max-width: 280px;
            border-radius: 3px;
            overflow: hidden;
        }
        .inp .label {
            position: absolute;
            top: 20px;
            left: 12px;
            font-size: 16px;
            color: rgba(0, 0, 0, 0.5);
            font-weight: 500;
            transform-origin: 0 0;
            transform: translate3d(0, 0, 0);
            transition: all 0.2s ease;
            pointer-events: none;
        }
        .inp .focus-bg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.05);
            z-index: -1;
            transform: scaleX(0);
            transform-origin: left;
        }
        .inp input {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            width: 100%;
            border: 0;
            font-family: inherit;
            padding: 16px 12px 0 12px;
            height: 56px;
            font-size: 16px;
            font-weight: 400;
            background: rgba(0, 0, 0, 0.02);
            box-shadow: inset 0 -1px 0 rgba(0, 0, 0, 0.3);
            color: #000;
            transition: all 0.15s ease;
        }
        .inp input:hover {
            background: rgba(0, 0, 0, 0.04);
            box-shadow: inset 0 -1px 0 rgba(0, 0, 0, 0.5);
        }
        .inp input:not(:-moz-placeholder-shown) + .label {
            color: rgba(0, 0, 0, 0.5);
            transform: translate3d(0, -12px, 0) scale(0.75);
        }
        .inp input:not(:-ms-input-placeholder) + .label {
            color: rgba(0, 0, 0, 0.5);
            transform: translate3d(0, -12px, 0) scale(0.75);
        }
        .inp input:not(:placeholder-shown) + .label {
            color: rgba(0, 0, 0, 0.5);
            transform: translate3d(0, -12px, 0) scale(0.75);
        }
        .inp input:focus {
            background: rgba(0, 0, 0, 0.05);
            outline: none;
            box-shadow: inset 0 -2px 0 #0077FF;
        }
        .inp input:focus + .label {
            color: #0077FF;
            transform: translate3d(0, -12px, 0) scale(0.75);
        }
        .inp input:focus + .label + .focus-bg {
            transform: scaleX(1);
            transition: all 0.1s ease;
        }
</style>
</head>
<body>
    <label for="inp" class="inp">
        <input type="text" id="inp" placeholder="&nbsp;">
        <span class="label">Label</span>
        <span class="focus-bg"></span>
    </label>

    <style>


    </style>
    <%--    <div class="spinner-border" role="status">--%>
    <%--        <span class="sr-only">Loading...</span>--%>
    <%--    </div>--%>


    aaa

    <button id="submitBtn" class="w-100 btn btn-lg btn-primary">Sign up</button>

    <div id="spinnerBox">
        <div class="loader">
            <svg class="circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"></circle>
            </svg>
        </div>
    </div>
    <div id="shadow-box"/>

    <script>
        $("#submitBtn").on("click", function (e) {
            console.log("클릭");
        });
    </script>
</body>
</html>
