<?php
include("dbconnection.php");

$json_data = array();

$query = "SELECT * FROM club_info";
$result = mysqli_query($link, $query);

//push a new index for each row in club_info
while($row = mysqli_fetch_object($result)) {
$json_data[] = $row;
}

//we need to reverse the json array in order to get the clubs that were recently created as first
$reversed_json_data = array_reverse($json_data);

print('{"club_info":'.json_encode($reversed_json_data).'}');

?>