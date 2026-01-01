<?php
include 'dbconnect.php';

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$base_url = "http://" . $_SERVER['HTTP_HOST'] . "/stemxplore/";

$query = "
SELECT 
    i.info_id,
    i.info_title,
    i.info_desc,
    i.info_type,
    MIN(m.media_url) AS media
FROM stem_info i
LEFT JOIN stem_info_media m ON i.info_id = m.info_id
GROUP BY i.info_id
";

$result = mysqli_query($conn, $query);
$data = [];

while ($row = mysqli_fetch_assoc($result)) {
    if ($row['media']) {
        $row['media'] = $base_url . $row['media'];
    }
    $data[] = $row;
}

echo json_encode($data);
$conn->close();
?>
