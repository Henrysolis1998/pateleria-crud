<?php
header('Content-Type: application/json');
include 'db.php';

$method = $_SERVER['REQUEST_METHOD'];

switch($method) {
    case 'GET':
        $stmt = $conn->prepare("SELECT * FROM ingredientes");
        $stmt->execute();
        echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"), true);
        $stmt = $conn->prepare("INSERT INTO ingredientes (nombre)
                                VALUES (? )");
        $stmt->execute([$data['nombre']]);
        echo json_encode(["message" => "Ingrediente agregado"]);
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"), true);
        $stmt = $conn->prepare("UPDATE ingredientes SET nombre=? WHERE id_ingrediente=?");
        $stmt->execute([$data['nombre'], $data['id_ingrediente']]);
        echo json_encode(["message" => "Ingrediente actualizado"]);
        break;

    case 'DELETE':
        $data = json_decode(file_get_contents("php://input"), true);
        $stmt = $conn->prepare("DELETE FROM ingredientes WHERE id_ingrediente=?");
        $stmt->execute([$data['id_ingrediente']]);
        echo json_encode(["message" => "Ingrediente eliminado"]);
        break;
}
?>

