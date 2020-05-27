
// Step 1: connect to database join_us
var mysql = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  database : 'join_us',
});

connection.connect();

// Step 2: run query

// CREATE TABLE users ( email VARCHAR(255) PRIMARY KEY, created_at TIMESTAMP DEFAULT NOW());
// INSERT INTO users (email) VALUES('Katie34@yahoo.com'), ('Tunde@gmail.com');
// SELECTING using Node

var q ='SELECT * FROM users';  // To select all users from database
connection.query(q, function(error, results, fields) {
   if (error) throw error
   console.log(results)
});


var q = 'SELECT COUNT(*) AS total FROM users '; // To count the number of users in the database
connection.query(q, function (error, results, fields) {
  if (error) throw error;
  console.log(results[0].total);
});


// INSERTING using Node
var q = 'INSERT INTO users (email) VALUES ("rusty_the_dog@gmail.com")';
connection.query(q, function (error, results, fields) {
  if (error) throw error;
  console.log(results);
});


var person = {
    email: faker.internet.email(),
    created_at: faker.date.past()
};
 
var end_result = connection.query('INSERT INTO users SET ?', person, function(err, result) {
  if (err) throw err;
  console.log(result);
});
connection.end();



// To insert 500 random users
var mysql = require('mysql');
var faker = require('faker');
 
 
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  database : 'join_us'
});
 
 
var data = [];
for(var i = 0; i < 500; i++){
    data.push([
        faker.internet.email(),
        faker.date.past()
    ]);
}
 
 
var q = 'INSERT INTO users (email, created_at) VALUES ?';
 
connection.query(q, [data], function(err, result) {
  console.log(err);
  console.log(result);
});
 
connection.end();