# FluttersocketIoWithServerside

 - This example is chat vai to socketIO front side flutter and backend node both code in this repo.

- Front-End side 
 - Run app before get your local ip and change SocketService file and replace your ip there 192.168.1.33
```
socket = IO.io(
        'http://192.168.1.33:8080',
        OptionBuilder()
            .disableAutoConnect()
            .enableForceNew()
            .setTransports(['websocket', 'polling'])
            //.setTimeout(200000)
            .build());
```

-Server side setUp
# Environment
To get started with developing using the Socket.IO, you need to have Node and npm (node package manager) installed. If you do not have these, head over to Node setup to install node on your local system. Confirm that node and npm are installed by running the following commands in your terminal.
```
node --version
npm --version
You should get an output similar to −
v14.17.0

```
 - Open your terminal and enter the following in your terminal to create a new folder and enter the following commands −
   
```
 mkdir socket-project
 cd socket-proect
 npm init -y //this commond create defualt package json file  
```
- One final thing is that we should keep restarting the server. When we make changes, we will need a tool called nodemon. To install nodemon, open your terminal and enter the following command

```
npm i express nodemon socket.io
```
below change in pacakge json file
```
default
"scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
 
change
 "scripts": {
    "start": "nodemon main.js --w"
  },

```
-- create main js file and write below code(this file is server side) 

```
const express=require('express');
const app =express();
const path=require('path');
const http=require('http').createServer(app);

//middlewre
app.use(express.json());


const port=process.env.port || 8080;

//attached http server to the socket.io
const io=require('socket.io')(http);
/*  const io = require("socket.io")({
    http,
    allowEIO3: true // false by default
  });  */


//route
 app.get('/',(req,res)=>{
    res.sendFile(path.join(__dirname,'src/index.html'))
 //res.json("get request");
}); 

//create a new connection
io.on('connection',socket=>{
console.log("A user connected");



socket.on('chatmessage', (msg) => {
  const obj = JSON.parse(msg);
    console.log("====server get roomId==="+obj.roomId);
    console.log("====server get message==="+msg);

    // someroom this uniquue id,all user is join this id get message  
    io.to(obj.roomId).emit("chatmessage",msg);
  });

socket.on('createRoom', function(roomId) {
  
       //  this is uniquue id
    socket.join(roomId);
  
    console.log("---createRoom---id----"+roomId)
  });

socket.on('disconnect',()=>{
    console.log("A user diconnected");
})
socket.on("message",msg=>{
console.log("Client messaeg:"+msg);

});





// emit event
socket.emit("server","Receive From Server")
socket.emit("server1","Receive From Server second")

});


 http.listen(port,()=>{
    console.log('app listeing on port ${port}');
}) 

```
- Create index html file and write below code(this file is user side) 
create src folder and create there index.html file
(if you useing visual studio code creat html file and type  `!`  and enter to auto generate html code)

```
<html>
  <head>
    <title>Socket.IO chat</title>
    <style>
      body { margin: 0; padding-bottom: 3rem; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; }

      #form { background: rgba(0, 0, 0, 0.15); padding: 0.25rem; position: fixed; bottom: 0; left: 0; right: 0; display: flex; height: 3rem; box-sizing: border-box; backdrop-filter: blur(10px); }
      #input { border: none; padding: 0 1rem; flex-grow: 1; border-radius: 2rem; margin: 0.25rem; }
      #input:focus { outline: none; }
      #form > button { background: #333; border: none; padding: 0 1rem; margin: 0.25rem; border-radius: 3px; outline: none; color: #fff; }

      #messages { list-style-type: none; margin: 0; padding: 0; }
      #messages > li { padding: 0.5rem 1rem; }
      #messages > li:nth-child(odd) { background: #efefef; }
    </style>
  </head>
  <body>
    <ul id="messages"></ul>
    <form id="form" action="">
      <input id="input" autocomplete="off" /><button>Send</button><button id="join">join</button>
     
    </form>
  </body>
  <script src="/socket.io/socket.io.js"></script>
<script>
  var socket = io();
  var roomID="";
  var messages = document.getElementById('messages');
  var form = document.getElementById('form');
  var input = document.getElementById('input');

   form.addEventListener('submit', function(e) {
    e.preventDefault();
    if (input.value) {
 var myObject={"message":input.value,"senderId":"2","receiverId":"1","roomId":roomID}
    // var sendData= JSON.stringify(myObject);
      socket.emit('chatmessage',JSON.stringify(myObject));
      input.value = '';
    }
  }); 
  
  let joinClick=document.getElementById("join");
  joinClick.addEventListener("click",()=>{
    if (input.value) {
      roomID=input.value;
       socket.emit("createRoom",input.value); 
        input.value = '';
    }
        });


  socket.on('chatmessage', function(msg) {
    var item = document.createElement('li');
    console.log(msg);
    const obj = JSON.parse(msg);
    item.textContent = obj.message;
    messages.appendChild(item);
    window.scrollTo(0, document.body.scrollHeight);
  });
</script>
</html>

```
```
- Run command and see in terminal event listener:(user do any action you can see in terminal log)
  
```
npm start
```
- Open browser port 8080 and open console, you can see server event listener in console log
- firs create room we must enter same room id and join chat

- Thii demo required V3 socket

```npm i socket.io@3
```
 -Below commond for V5
 
```npm i socket.io-redis@5
```
```
http://localhost:8080/  
```
-Io socket official site:
[https://socket.io/docs/v3/](https://socket.io/docs/v3/)
