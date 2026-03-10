<?php

include 'dbconnect.php';

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$base_url = "http://" . $_SERVER['HTTP_HOST'] . "/stemxplore/";

$field_id = $_GET['field_id'];

$query = "SELECT * FROM career_job WHERE field_id = '$field_id'";

$result = mysqli_query($conn,$query);

$data = [];

while($row = mysqli_fetch_assoc($result)){

    if(!empty($row['image'])){
        $row['image'] = $base_url . $row['image'];
    }

    $data[] = $row;
}

echo json_encode($data);

$conn->close();

?>