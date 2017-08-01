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
	
	//this query deletes values from the post_info table where we have the correct club_id and post_title
	$query = "DELETE FROM post_info WHERE club_id='$club_id' AND post_title='$post_title'";
	mysqli_query($link, $query) or exit("result_message=Error deleting the post!");
	
    print("result_message=Successfully deleted the post!");
?> 