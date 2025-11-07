<?php
header('Content-Type: application/json');
include 'db.php';

$method = $_SERVER['REQUEST_METHOD'];

switch($method) {
    case 'GET':
        $sql = "SELECT p.*, 
                       GROUP_CONCAT(i.nombre SEPARATOR ', ') AS ingredientes
                FROM pasteles p
                LEFT JOIN pastel_ingrediente pi ON p.id_pastel = pi.id_pastel
                LEFT JOIN ingredientes i ON pi.id_ingrediente = i.id_ingrediente
                GROUP BY p.id_pastel";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"), true);

        // Inserta solo fecha_vencimiento; fecha_creado se genera automáticamente
        $stmt = $conn->prepare("INSERT INTO pasteles (nombre, descripcion, preparado_por, fecha_vencimiento)
                                VALUES (?, ?, ?, ?)");
        // Asegúrate de que fecha_vencimiento tenga formato 'YYYY-MM-DD HH:MM:SS'
        $fechaVenc = date('Y-m-d H:i:s', strtotime($data['fecha_vencimiento']));
        $stmt->execute([$data['nombre'], $data['descripcion'], $data['preparado_por'], $fechaVenc]);

        $idPastel = $conn->lastInsertId();

        // Insertar ingredientes en la tabla puente
        if (!empty($data['ingredientes'])) {
            $stmtIng = $conn->prepare("INSERT INTO pastel_ingrediente (id_pastel, id_ingrediente) VALUES (?, ?)");
            foreach ($data['ingredientes'] as $idIng) {
                $stmtIng->execute([$idPastel, $idIng]);
            }
        }

        echo json_encode(["message" => "Pastel creado correctamente"]);
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"), true);

        // Actualizar pastel, sin modificar fecha_creado
        $stmt = $conn->prepare("UPDATE pasteles SET nombre=?, descripcion=?, preparado_por=?, fecha_vencimiento=? WHERE id_pastel=?");
        $fechaVenc = date('Y-m-d H:i:s', strtotime($data['fecha_vencimiento']));
        $stmt->execute([$data['nombre'], $data['descripcion'], $data['preparado_por'], $fechaVenc, $data['id_pastel']]);

        // Actualizar ingredientes
        $conn->prepare("DELETE FROM pastel_ingrediente WHERE id_pastel=?")->execute([$data['id_pastel']]);
        if (!empty($data['ingredientes'])) {
            $stmtIng = $conn->prepare("INSERT INTO pastel_ingrediente (id_pastel, id_ingrediente) VALUES (?, ?)");
            foreach ($data['ingredientes'] as $idIng) {
                $stmtIng->execute([$data['id_pastel'], $idIng]);
            }
        }

        echo json_encode(["message" => "Pastel actualizado"]);
        break;

    case 'DELETE':
        $data = json_decode(file_get_contents("php://input"), true);
        $stmt = $conn->prepare("DELETE FROM pasteles WHERE id_pastel=?");
        $stmt->execute([$data['id_pastel']]);
        echo json_encode(["message" => "Pastel eliminado"]);
        break;
}
?>
