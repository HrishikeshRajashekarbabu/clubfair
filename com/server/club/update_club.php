<?php
include("dbconnection.php");

	//variables to receive from flash
	$original_club_name = $_POST["original_club_name"];
	$club_name = $_POST["club_name"];
	$club_password = $_POST["club_password"];
	$club_bio = $_POST["club_bio"];

    //check if the club name has already been used. if it is, then don't allow them to use it (unless if its the same as the original name)
	$query = "SELECT * FROM club_info WHERE club_name='$club_name'";
	$result = mysqli_query($link, $query);
    if(mysqli_num_rows($result) > 0 && $original_club_name != $club_name) {
        exit("result_message=This club name has already been used!");
    }

	//this query updates the values into the club_info table
	$query = "UPDATE club_info SET club_name='$club_name', club_password='$club_password', club_bio='$club_bio' WHERE club_name='$original_club_name'";
	mysqli_query($link, $query) or exit("result_message=Error sending the information!");
    
    //if all else is successful, then tell the user
    exit("result_message=Successfully updated $club_name" . "!");

?>