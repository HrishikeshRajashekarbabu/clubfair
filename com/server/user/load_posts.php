<?php
include("dbconnection.php");

	//load flash var for club_name
	$club_name = $_POST["club_name"];
	$club_id = 0;
	$json_data = array();

	//finds the row of the club_name
	$query = "SELECT * FROM club_info WHERE club_name='$club_name'";
	$result = mysqli_query($link, $query);
	if(mysqli_num_rows($result) > 0) {
		$row = mysqli_fetch_array($result); //fetch the array result of the row
		$club_id = $row["club_id"]; //get the club_id of the row
    }
	
	$query = "SELECT * FROM post_info WHERE club_id='$club_id'";
	$result = mysqli_query($link, $query);
	//push a new index for each row from post_info for the specific club_id
	while($row = mysqli_fetch_object($result)) {
		$json_data[] = $row;
	}
	
	//we need to reverse the json array in order to get the posts that were recently created as first
	$reversed_json_data = array_reverse($json_data);
	
	print('{"post_info":'.json_encode($reversed_json_data).'}');
?>