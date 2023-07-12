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
/* http.listen(port, "0.0.0.0", () => {
    console.log("server started");
    }); */