<?php
include "db.php";
require __DIR__ . '/vendor/autoload.php';

$mpdf = new \Mpdf\Mpdf();
$cat = $_GET['cat'];
$logo = file_get_contents('Assets/logo.jpg');
$htmlNav = '<nav>
<img src="data:image/jpg;base64,' . base64_encode($logo) . '" width="90" height="90" style="margin: 2% 30% 2% 2%">
<h4 style="text-align: center;"> Reporte #4</h4>
<h5 style="text-align: center;"> Productos filtrados por una categoría determinada y su cantidad en inventario </h5>
<h5> Categoría: '.$cat.'</h5>
</nav>
<body>
<div style="margin: 3%">
    <table class="table table-striped table-dark">
        <thead>
          <tr>
            <th scope="col" style="vertical-align: middle;">#</th>
            <th scope="col" style="vertical-align: middle;">Foto</th>
            <th scope="col" style="vertical-align: middle;">Nombre</th>
            <th scope="col" style="vertical-align: middle;">Cantidad<br>Disponible</th>
          </tr>
        </thead>
        <tbody>
          ';

$stylesheet = file_get_contents('Assets/kv-mpdf-bootstrap.css');
$mpdf->WriteHTML($stylesheet, 1); // CSS Script goes here.
$mpdf->WriteHTML($htmlNav, 2); //HTML Content goes here.



$query = "CALL reporte4('".$cat."')";
$stmt = $sql->prepare($query);
$stmt->execute();
$rows = $stmt->fetchAll();
$i = 1;
$consulta = '';
foreach ($rows as $row) {
  $consulta ='
    <tr>
        <th scope="row" style="vertical-align: middle;">' . $i . '</th>
        <td style="vertical-align: middle;"><img src="data:image/jpeg;base64,' . base64_encode($row['imagen_p']) . '" width="45px" height="45px"></td>
        <td style="vertical-align: middle;">' . $row['nombre_p'] . '</td>
        <td style="vertical-align: middle;">' . $row['Cantidad_Disponible'] . '</td>
    </tr>
    ';
    $mpdf->WriteHTML($consulta, 2);
  $i++;
}

$htmlEnd = '</tbody>
</table>
</div>

</body>';
$mpdf->WriteHTML($htmlEnd, 2);


$mpdf->Output();
