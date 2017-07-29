<?php
$host = "";
$sqluser = "";
$sqlpassword = "";
$dbusername = "";

//variables to receive from flash
$club_name = $_POST["club_name"];
$club_password = $_POST["club_password"];
$club_bio = $_POST["club_bio"];

$link = mysqli_connect($host, $sqluser, $sqlpassword, $dbusername);

    //check if the club name has already been used. if it is, then don't allow them to use it!
	$query = "SELECT * FROM admin_login WHERE club_name='$club_name'";
    $result = mysqli_query($link, $query);
    while(mysqli_num_rows($result) > 0) {
        exit("result_message=This club name has already been used!");
    }

	//this query inserts the values into the admin_login table
	$query = "INSERT INTO admin_login (club_name, club_bio, club_password) VALUES('$club_name', '$club_bio', '$club_password')";
	mysqli_query($link, $query) or exit("result_message=Failed to send to the database!");
    
    //if all else is successful, then tell the user
    exit("result_message=The information has been successfully sent to the database!");

?>