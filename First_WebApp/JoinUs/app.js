var express = require("express");
var app = express();
var mysql = require("mysql");
var bodyParser = require("body-parser");

app.set("view engine", "ejs");
app.use(bodyParser.urlencoded({extended: true}));
app.use(express.static(__dirname + "/public"));

// DATABASE CONNECTION
var connection = mysql.createConnection({
	host : "localhost",
	user : "root",
	database : "join_us"
});

// HOME PAGE
app.get("/", function(req, res){
	var q = "SELECT COUNT(*) as count FROM users"
	connection.query(q, function(error, results){
		if (error) throw error;
		var n_users = results[0].count;
		console.log("HOME PAGE REQUESTED!");
		res.render("home", {n_users: n_users});
	});
});

app.post("/register", function(req, res){
	console.log("Email: " + req.body.email);
	var new_email = {email: req.body.email}; 
	var q = "INSERT INTO users SET ?";
	connection.query(q, new_email, function(error, results){
		if (error) throw error;
		res.redirect("/thanks");
	});
});

app.get("/thanks", function(req, res){
	res.render("thanks");
	console.log("THANKS PAGE REQUESTED!");
});

app.get("/more_about", function(req, res){
	res.render("more_about");
	console.log("MORE ABOUT PAGE REQUESTED!");
});


app.listen(3000, function(){
	console.log("Server running on 3000!");
});



