// Step 1: connect to database join_us
var mysql = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  database : 'join_us',
});

connection.connect();

// Step 2: run query

// Using the MySQL Node Package:
connection.query('SELECT 1 + 1 AS solution', function(error, results, fields) {
   if (error) throw error;
   console.log('The solution is: ', results)
});

var q = 'SELECT CURTIME() as time, CURDATE() as date, NOW() as now';
connection.query(q, function (error, results, fields) {
  if (error) throw error;
  console.log(results[0].time);
  console.log(results[0].date);
  console.log(results[0].now);
});

connection.end();
