<?php
include 'dbconnect.php';
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");

$page_id = $_POST['page_id'] ?? '';
$bookmark = $_POST['bookmark'] ?? 'no';

if ($page_id == '') {
    echo json_encode(['status' => 'error', 'message' => 'Page ID missing']);
    exit;
}

$query = "UPDATE stem_learning_page SET bookmark = ? WHERE page_id = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("si", $bookmark, $page_id);
if ($stmt->execute()) {
    echo json_encode(['status' => 'success', 'bookmark' => $bookmark]);
} else {
    echo json_encode(['status' => 'error', 'message' => $stmt->error]);
}
$conn->close();
?>