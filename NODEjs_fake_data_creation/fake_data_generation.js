// Libraries
var faker = require("faker");
var mysql = require("mysql");

// Connection to database
var connection = mysql.createConnection({
	host : "localhost",
	user : "root",
	database : "join_us"
});

// Data creation
var data = [];
for(var i = 0; i<500; i++){
	data.push([faker.internet.email(), faker.date.past()])
}

// Query to database
var q = "INSERT INTO users (email, created_at) VALUES ?"
connection.query(q, [data], function (error, results, fields) {
   	if (error) throw error;
   	console.log(results);
});

// Connection closure
connection.end()
