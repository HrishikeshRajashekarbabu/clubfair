<?php
include("dbconnection.php");

	date_default_timezone_set('America/Chicago');

	//load flash var for club_name
    $close_time = $_POST["close_time"]; //in flash: (new Date()).time
    $open_time = $_POST["open_time"];  //in flash: (new Date()).time
	$club_names = $_POST["club_names"];
	$club_id = 0;
	$json_data = array();

	//gets length of $club_names array
    $count = count($club_names);

    //goes through the club_names and gets the club_id and posts
    for($i=0; $i<$count; $i++)
    {
        $query = "SELECT * FROM club_info WHERE club_name='$club_names[$i]'";
        $result = mysqli_query($link, $query);
        if(mysqli_num_rows($result) > 0) 
        {
            $row = mysqli_fetch_array($result); //fetch the array result of the row
            $club_id = $row["club_id"]; //get the club_id of the row
        }
        
        //gets all posts with the $club_id and between the close and open time
        $query = "SELECT * FROM post_info WHERE club_id='$club_id' AND sec_post_date<='$open_time' AND sec_post_date>='$close_time'";
        $result = mysqli_query($link, $query);
        //push a new index for each row from post_info for the specific club_id
        while($row = mysqli_fetch_object($result)) 
        {
            $json_data[] = $row;
        }
    }
	
	//we need to reverse the json array in order to get the posts that were recently created as first
	$reversed_json_data = array_reverse($json_data);
	
	print('{"post_info":'.json_encode($reversed_json_data).'}');
?>