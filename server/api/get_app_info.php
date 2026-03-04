<?php
include 'dbconnect.php';

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$base_url = "http://" . $_SERVER['HTTP_HOST'] . "/stemxplore/";

$sql = "SELECT app_id, app_question, app_answer FROM app_info";
$result = $conn->query($sql);

$faqs = [];

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $faqs[] = $row;
    }
}

echo json_encode($faqs);
$conn->close();
?>
