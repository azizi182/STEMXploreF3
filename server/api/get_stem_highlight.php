<?php
include 'dbconnect.php';

// side of database
$base_url = "http://".$_SERVER['HTTP_HOST']."/stemxplore/";

$query = "
SELECT 
h.highlight_id, 
h.highlight_title_en,
h.highlight_title_ms, 
h.highlight_desc_en, 
h.highlight_desc_ms,
h.highlight_type,
GROUP_CONCAT(m.media_url) AS media
FROM stem_highlight h
LEFT JOIN stem_highlight_media m ON h.highlight_id = m.highlight_id
GROUP BY h.highlight_id
";

$result = mysqli_query($conn, $query);
$data = [];

while ($row = mysqli_fetch_assoc($result)) {
    // Split multiple media paths into array
    $media_array = explode(',', $row['media']);
    
    // Prepend base URL to each media file
    $row['media'] = array_map(function($path) use ($base_url) {
        return $base_url . $path;
    }, $media_array);
    
    $data[] = $row;
}

// Return JSON
header('Content-Type: application/json');
echo json_encode($data);

    // sql insert highlight sample data

    // INSERT INTO stem_highlight (highlight_title, highlight_desc, highlight_type)
    // VALUES
    // ('STEM in rural area', 'Orang asli didedahkan tentang STEM', 'image');

    // -- STEM Highlight media table (image URLs)
    // INSERT INTO stem_highlight_media (highlight_id, media_url)
    // VALUES
    // (3, 'assets/highlight/highlight3.jpg');
?>
