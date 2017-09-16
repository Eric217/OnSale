<%--
  Created by IntelliJ IDEA.
  User: omsfuk
  Date: 2017/7/23
  Time: 19:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <title></title>
    <link rel="stylesheet" href="css/amazeui.min.css" />
</head>

<body class="am-container">
<div class="am-panel am-panel-default">
    <div class="am-panel-hd">Chat Room</div>
    <div class="am-panel-bd">
        ${name}
        <textarea rows="20" class="am-container"></textarea>
        <input type="text" class="" id="msg" placeholder="在此输入消息内容">
        <div class="am-container am-vertical-align">
            <div class="am-btn-group am-fr">
                <button type="button" onclick="connect()" class="am-btn am-btn-primary am-round am-vertical-align-middle">连接</button>
                <button type="button" onclick="send()" class="am-btn am-btn-primary am-round am-vertical-align-middle">发送</button>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/amazeui.min.js"></script>
<script>
    var wsUri = "ws://localhost:8080/websocket"
    function send() {
        websocket.send($("#msg").text())
    }
    function connect() {
        websocket = new WebSocket(wsUri);
        websocket.onopen = function(evt) {
            console.log(evt);
        };
        websocket.onclose = function(evt) {
            console.log(evt);
        };
        websocket.onmessage = function(evt) {
            console.log(evt);
        };
        websocket.onerror = function(evt) {
            console.log(evt);
        };
    }
</script>
</html>