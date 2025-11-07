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
        $stmt = $conn->prepare("INSERT INTO ingredientes (nombre, descripcion, fecha_vencimiento)
                                VALUES (?, ?, ?)");
        $stmt->execute([$data['nombre'], $data['descripcion'], $data['fecha_vencimiento']]);
        echo json_encode(["message" => "Ingrediente agregado"]);
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"), true);
        $stmt = $conn->prepare("UPDATE ingredientes SET nombre=?, descripcion=?, fecha_vencimiento=? WHERE id_ingrediente=?");
        $stmt->execute([$data['nombre'], $data['descripcion'], $data['fecha_vencimiento'], $data['id_ingrediente']]);
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

