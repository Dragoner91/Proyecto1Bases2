<?php
include("db.php");
for($i = 0; $i < 10; $i++){
    $query = "CALL InsertDetalleFactura()";
    $stmt = $sql->prepare($query);
    $stmt->execute();
}

echo "LISTOS";