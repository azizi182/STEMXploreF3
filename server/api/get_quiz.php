<?php
include 'dbconnect.php';

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$query = "SELECT quiz_id, quiz_title_en, quiz_title_ms, quiz_subject_en, quiz_subject_ms, quiz_total_question FROM stem_quiz";

$result = mysqli_query($conn, $query);
$data = [];

while ($row = mysqli_fetch_assoc($result)) {
    $data[] = $row;
}

echo json_encode($data);
$conn->close();
?>