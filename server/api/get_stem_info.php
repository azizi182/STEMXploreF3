<?php
include 'dbconnect.php';

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$base_url = "http://" . $_SERVER['HTTP_HOST'] . "/stemxplore/";

$query = "
SELECT 
    i.info_id,
    i.info_title_en,
    i.info_title_ms,
    i.info_desc_en,
    i.info_desc_ms,
    i.info_type,
    GROUP_CONCAT(m.media_url) AS media
FROM stem_info i
LEFT JOIN stem_info_media m ON i.info_id = m.info_id
GROUP BY i.info_id
";

$result = mysqli_query($conn, $query);
$data = [];

while ($row = mysqli_fetch_assoc($result)) {
    $media_array = [];
    // Split multiple media paths into array
    if (!empty($row['media'])) {
    $media_array = explode(',', $row['media']);
}
    
    // Prepend base URL to each media file
    $row['media'] = array_map(function($path) use ($base_url) {
        return $base_url . $path;
    }, $media_array);
    
    $data[] = $row;
}

echo json_encode($data);
$conn->close();
?>
