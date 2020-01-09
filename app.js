var express = require('express');
var mysql = require('mysql');
const util = require('util');

var app = express();

var connection = mysql.createConnection({
   host     : process.env.host,
   user     : process.env.user,
   password : process.env.password,
   database : process.env.database
 });

main = async () => {
   let query = "SELECT count_view FROM view"
   let query_engine =  util.promisify(connection.query).bind(connection);
   let result = await query_engine(query)
   if (!result[0]){
     query = "INSERT INTO view (count_view) VALUES (1)"
     result = 1
   } else {
     result = result[0]['count_view'] + 1
     query = `UPDATE view SET count_view = ${result};`
   }
   query_engine(query)
   
   return result
  
 }

app.get('/', function (req, res) {
  main().then(data => {
    res.send('count is'+ `${data}`);
   });
})

var server = app.listen(8081, function () {
  var host = server.address().address
  var port = server.address().port 
  console.log("Example app listening at http://%s:%s", host, port)
})
