<?php
include("dbconnection.php");

$json_data = array();
$query = "SELECT * FROM club_info";
$result = mysqli_query($link, $query);

//push a new index for each row in club_info
while($row = mysqli_fetch_object($result)) {
$json_data[] = $row;
}

print('{"club_info":'.json_encode($json_data).'}');

?>