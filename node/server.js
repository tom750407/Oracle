var http = require('http');
http.createServer(function (request, response) {
    //發送HTTP頭部
    //HTTP狀態值: 200 : OK
    //內容類型: text/plain 
    response.writeHead(200, {'Content-Type': 'text/plain'});
    //發送響應數據"Hello World"
    response.end('Hello World\n');
}).listen(8888);
//終端打印如下信息
console.log('Server running at http://127.0.0.1:8888/');
