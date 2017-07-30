<?php
include("dbconnection.php");

    $the_user_id=$_POST['user_id'];

    $connection= mysqli_connect('clubfair.000webhostapp.com', 'root', '', 'id2004787_clubfair');

    $query = "SELECT * FROM posts WHERE user_id = $the_user_id ";
    $select_users_by_id = mysqli_query($connection, $query);  

    //Use this to use as placeholder/value in the form
    while($row = mysqli_fetch_assoc($select_users_by_id))
    {
        $subscribe_clubs = $row['subscribe_clubs'];  
    }

    $club_array = explode(',', $subscribe_clubs);
    
    foreach($club_array as $number)
    {    //make posts also have their club id    
        $query = "SELECT * FROM post_info WHERE club_id = {$number} ";
        $select_posts_id = mysqli_query($connection, $query);    
        while($row = mysqli_fetch_assoc($select_posts_id))
        {
            $post_id = $row['post_id'];  
            $post_title = $row['post_title'];
            $post_date = $row['post_date'];
            $post_content = $row['post_content'];  
        }
               
    }

?>