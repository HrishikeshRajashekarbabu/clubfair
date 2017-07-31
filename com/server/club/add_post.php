<?php
include("dbconnection.php");
        
	//variables to receive from flash
	$club_name = $_POST['club_name'];
	$post_title = $_POST['post_title'];
	$post_content = $_POST['post_content'];
	
	$date = getdate(date("U"));
	$post_date = "$date[weekday], $date[month] $date[mday], $date[year]";
      
	//this query inserts the values into the post_info table
	$query = "INSERT INTO post_info (club_name, post_title, post_date, post_content) VALUES('$club_name', '$post_title', '$post_date', '$post_content')";
	mysqli_query($link, $query) or exit("result_message=Error sending the information!");
	
	//if all else is successful, then tell the user
    exit("result_message=Successfully added post for $club_name" . "!");
?>