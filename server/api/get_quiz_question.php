<?php
include 'dbconnect.php';

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$base_url = "http://" . $_SERVER['HTTP_HOST'] . "/stemxplore/";

$quiz_id = isset($_GET['quiz_id']) ? $_GET['quiz_id'] : null;

$query = "
SELECT 
    q.quiz_id,
    q.quiz_title_en,
    q.quiz_title_ms,
    q.quiz_subject_en,
    q.quiz_subject_ms,
    q.quiz_total_question,

    qs.question_id,
    qs.question_text_en,
    qs.question_text_ms,
    qs.question_image,

    qs.opt_a_en,
    qs.opt_a_ms,
    qs.opt_a_image,

    qs.opt_b_en,
    qs.opt_b_ms,
    qs.opt_b_image,

    qs.opt_c_en,
    qs.opt_c_ms,
    qs.opt_c_image,

    qs.opt_d_en,
    qs.opt_d_ms,
    qs.opt_d_image,

    qs.correct_answer_en,
    qs.correct_answer_ms

FROM stem_quiz q
LEFT JOIN stem_quiz_question qs 
ON q.quiz_id = qs.quiz_id
";

if($quiz_id != null){
    $query .= " WHERE q.quiz_id = '$quiz_id'";
}

$result = mysqli_query($conn, $query);
$data = [];

while ($row = mysqli_fetch_assoc($result)) {

    if (!empty($row['question_image'])) {
        $row['question_image'] = $base_url . $row['question_image'];
    }

    if (!empty($row['opt_a_image'])) {
        $row['opt_a_image'] = $base_url . $row['opt_a_image'];
    }

    if (!empty($row['opt_b_image'])) {
        $row['opt_b_image'] = $base_url . $row['opt_b_image'];
    }

    if (!empty($row['opt_c_image'])) {
        $row['opt_c_image'] = $base_url . $row['opt_c_image'];
    }

    if (!empty($row['opt_d_image'])) {
        $row['opt_d_image'] = $base_url . $row['opt_d_image'];
    }

    $data[] = $row;
}

echo json_encode($data);
$conn->close();
?>