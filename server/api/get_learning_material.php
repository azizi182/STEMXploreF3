<?php
include 'dbconnect.php';

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$base_url = "http://" . $_SERVER['HTTP_HOST'] . "/stemxplore/";

$query = "
SELECT 
    l.learning_id,
    l.learning_title_en,
    l.learning_title_ms,
    l.learning_subject_en,
    l.learning_subject_ms,
    p.page_id,
    p.page_title_en,
    p.page_title_ms,
    p.page_desc_en,
    p.page_desc_ms,
    p.page_order,
    p.bookmark,   
    m.media_type,
    m.media_url
FROM stem_learning l
LEFT JOIN stem_learning_page p ON l.learning_id = p.learning_id
LEFT JOIN learning_media m ON p.page_id = m.page_id
ORDER BY l.learning_id, p.page_order
";

$result = mysqli_query($conn, $query);

$data = [];
while ($row = mysqli_fetch_assoc($result)) {

    $learning_id = $row['learning_id'];
    $page_id = $row['page_id'];

    if (!isset($data[$learning_id])) {
        $data[$learning_id] = [
    "learning_id" => $learning_id,
    "learning_title_en" => $row['learning_title_en'],
    "learning_title_ms" => $row['learning_title_ms'],
    "learning_subject_en" => $row['learning_subject_en'],
    "learning_subject_ms" => $row['learning_subject_ms'],
    "pages" => []
];
    }

    if ($page_id) {
        if (!isset($data[$learning_id]["pages"][$page_id])) {
            $data[$learning_id]["pages"][$page_id] = [
                "page_id" => $page_id,
                "page_title_en" => $row['page_title_en'],
                "page_title_ms" => $row['page_title_ms'],
                "page_desc_en" => $row['page_desc_en'],
                "page_desc_ms" => $row['page_desc_ms'],
                "media" => []
            ];
        }

        if ($row['media_url']) {
            $data[$learning_id]["pages"][$page_id]["media"][] = [
                "type" => $row['media_type'],
                "url" => $base_url . $row['media_url']
            ];
        }
    }
}

foreach ($data as &$learning) {

    if (isset($learning['pages'])) {

        foreach ($learning['pages'] as &$page) {

            if (isset($page['media'])) {
                $page['media'] = array_values($page['media']);
            }
        }

    
        $learning['pages'] = array_values($learning['pages']);
    }
}

echo json_encode(array_values($data));
$conn->close();
?>