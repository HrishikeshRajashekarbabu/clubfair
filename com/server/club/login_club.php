<?php
include("dbconnection.php");

	//variables to receive from flash
	$club_name = $_POST["club_name"];
	$club_password = $_POST["club_password"];

	//logs into the account, checks the query if the club_name and club_password match
	$query = "SELECT * FROM admin_login WHERE club_name='$club_name' AND club_password='$club_password'";
	$result = mysqli_query($link, $query);
	if(mysqli_num_rows($result) > 0) {
		$row = mysqli_fetch_array($result); //fetch the array result of the row
		print("club_bio=" . $row["club_bio"]);
		print("&");
		exit("result_message=Successfully logged in to $club_name" . "!");
    }
	
	//if all else fails, then tell the user
    exit("result_message=Invalid club name or password!");
?>