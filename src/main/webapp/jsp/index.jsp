<!DOCTYPE html>
<html>
<head>
    <title>WebChat</title>
    <script src="resources/sockjs-0.3.4.js"></script>
    <script src="resources/stomp.js"></script>
    <script type="text/javascript">
	
        var stompClient = null; 

        function setConnected(connected) {
            document.getElementById('connect').disabled = connected;
            document.getElementById('disconnect').disabled = !connected;
            document.getElementById('sendMessage').style.visibility = connected ? 'visible' : 'hidden';
            document.getElementById('calResponse').innerHTML = '';
        }

        function connect() {
            var socket = new SockJS('/add');
			stompClient = Stomp.over(socket);
            stompClient.connect({}, function(frame) {
                setConnected(true);
                console.log('Connected: ' + frame);
                stompClient.subscribe('/topic/showResult', function(calResult){
                	showResult(JSON.parse(calResult.body).result);
                });
            });
        }

        function disconnect() {
            stompClient.disconnect();
            setConnected(false);
            console.log("Disconnected");
        }

        function sendNum() {
            var message = document.getElementById('message').value;
            stompClient.send("/webChat/add", {}, JSON.stringify({ 'message' : message }));
        }

        function showResult(message) {
            var response = document.getElementById('calResponse');
            var p = document.createElement('p');
            p.style.wordWrap = 'break-word';
            p.appendChild(document.createTextNode(message));
            response.appendChild(p);
        }
    </script>
</head>
<body>
<h1>WebChat</h1>
<div>
    <div>
        <button id="connect" onclick="connect();">Connect</button>
        <button id="disconnect" disabled="disabled" onclick="disconnect();">Disconnect</button><br/><br/>
    </div>
    <div id="sendMessage">
        <label>Message:</label><label for="message"></label><br/>
        <textarea id="message"></textarea><br/><br/>
        <button id="sendNum" onclick="sendNum();">Send to Add</button>
        <p id="calResponse"></p>
    </div>
</div>
</body>
</html>