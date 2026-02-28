<?php
include 'dbconnect.php';

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$base_url = "http://" . $_SERVER['HTTP_HOST'] . "/stemxplore/";

$sql = "SELECT faq_id, 
faq_question_en,
faq_question_ms, 
faq_answer_en,
faq_answer_ms FROM stem_faq";
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
