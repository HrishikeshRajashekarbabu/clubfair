<?php
include("dbconnection.php");
        
	//variables to receive from flash
	$club_name = $_POST["club_name"];
	$post_title = $_POST["post_title"];
	$post_content = $_POST["post_content"];
	$club_id = 0;
	
	//finds the row of the club_name
	$query = "SELECT * FROM club_info WHERE club_name='$club_name'";
	$result = mysqli_query($link, $query);
	if(mysqli_num_rows($result) > 0) {
		$row = mysqli_fetch_array($result); //fetch the array result of the row
		$club_id = $row["club_id"]; //get the club_id of the row
    } else {
		exit("result_message=Error, does the club $club_name exist?");
	}
	
	date_default_timezone_set('America/Chicago');
	$post_date = date("D, F j, Y - g:i a", time()); 
      
	//this query inserts the values into the post_info table
	$query = "INSERT INTO post_info (club_id, post_title, post_date, post_content) VALUES('$club_id', '$post_title', '$post_date', '$post_content')";
	mysqli_query($link, $query) or exit("result_message=Error sending the information!");
	
	//if all else is successful, then tell the user
    exit("result_message=Successfully added post for $club_name" . "!");
?>