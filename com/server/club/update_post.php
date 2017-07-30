<?php
include("dbconnection.php");

    $connection= mysqli_connect('clubfair.000webhostapp.com', 'root', '', 'id2004787_clubfair');

    $query = "SELECT * FROM posts WHERE post_id = $the_post_id ";
    $select_posts_by_id = mysqli_query($connection, $query);  

    //Use this to use as placeholder/value in the form
    while($row = mysqli_fetch_assoc($select_posts_by_id))
    {
        $post_id = $row['post_id'];  
        $post_title = $row['post_title'];
        $post_date = $row['post_date'];
        $post_content = $row['post_content'];

    }

    //This is after you click update
    if(isset($_POST['update']))
    {
        $post_title = $_POST['post_title'];
        $post_content = $_POST['post_content'];

        $query = "UPDATE posts SET ";
        $query .= "post_title = '{$post_title}', ";
        $query .= "post_content = '{$post_content}' ";
        $query .= "WHERE post_id = {$the_post_id} ";

        $update_post = mysqli_query($connection, $query);

        //confirmQuery($update_post);
    
}

    
?> 