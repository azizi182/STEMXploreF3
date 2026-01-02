<?php
include 'dbconnect.php';

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$base_url = "http://" . $_SERVER['HTTP_HOST'] . "/stemxplore/";

$sql = "SELECT faq_id, faq_question, faq_answer FROM stem_faq";
$result = $conn->query($sql);

$faqs = [];

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $faqs[] = $row;
    }
}

//INSERT INTO faq_stem (faq_question, faq_answer) VALUES
//('Does KV have STEM stream?', 'Yes, most Kolej Vokasional (KV) schools offer a STEM stream where students learn Science, Technology, Engineering, and Mathematics subjects.'),

echo json_encode($faqs);
$conn->close();
?>



