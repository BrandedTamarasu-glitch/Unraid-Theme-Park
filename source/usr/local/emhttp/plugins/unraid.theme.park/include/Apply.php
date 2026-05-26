<?php
header('Content-Type: application/json');

require_once __DIR__ . '/ThemePark.php';

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
    http_response_code(405);
    echo json_encode(['ok' => false, 'error' => 'POST required.']);
    exit;
}

$enabled = ($_POST['enabled'] ?? 'no') === 'yes' ? 'yes' : 'no';
$theme_id = $_POST['theme'] ?? 'dark';
$theme = utp_theme($theme_id);

if (!$theme) {
    http_response_code(400);
    echo json_encode(['ok' => false, 'error' => 'Unknown theme.']);
    exit;
}

$cfg = utp_config();
$cfg['enabled'] = $enabled;
$cfg['theme'] = $theme_id;

if (!utp_write_config($cfg)) {
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => 'Unable to write plugin configuration.']);
    exit;
}

if (!utp_generate_css($cfg)) {
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => 'Unable to generate active stylesheet.']);
    exit;
}

$message = $enabled === 'yes'
    ? 'Theme enabled. Refreshing the WebGUI will apply the selected stylesheet.'
    : 'Theme disabled. Refreshing the WebGUI will return to stock styling.';

echo json_encode(['ok' => true, 'message' => $message]);
?>
