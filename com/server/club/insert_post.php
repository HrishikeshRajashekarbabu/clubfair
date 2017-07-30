<?php
include("dbconnection.php");
      
      $connection= mysqli_connect('clubfair.000webhostapp.com', 'root', '', 'id2004787_clubfair');      
      
      $post_title = $_POST['post_title'];
      $post_date = date('d-m-y');
      $post_content = $_POST['post_content'];
      
      $query = "INSERT INTO post_info(post_title,post_date,post_content) ";
      
      $query .= "VALUES({$post_title},now(),'{$post_content}') ";
           
      $create_post_query = mysqli_query($connection, $query);
   
?>