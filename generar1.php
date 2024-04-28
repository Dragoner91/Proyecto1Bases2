<?php
include "db.php";
require __DIR__ . '/vendor/autoload.php';

$mpdf = new \Mpdf\Mpdf();

$query = "CALL reporte1()";
$stmt = $sql->prepare($query);
$stmt->execute();
$rows = $stmt->fetchAll();
$i = 1;
$consulta = '';
foreach ($rows as $row) {
  $consulta = $consulta . '
    <tr>
        <th scope="row">' . $i . '</th>
        <td>' . $row['cedula_emp'] . '</td>
        <td>' . $row['nombre_emp'] . '</td>
        <td>' . $row['apellido_emp'] . '</td>
        <td>' . $row['nombre_cargo'] . '</td>
        <td>' . $row['Horas_Trabajadas'] . '</td>
    </tr>
    ';
  $i++;
}
$logo = file_get_contents('Assets/logo.jpg');
$html = '<nav>
<img src="data:image/jpg;base64,' . base64_encode($logo) . '" width="90" height="90" style="margin: 2% 30% 2% 2%">
<h4 style="text-align: center;"> Reporte #1</h4>
<h5 style="text-align: center;"> Reporte de empleados por horas trabajadas </h5>
</nav>
<body>
<div style="margin: 3%">
    <table class="table table-striped table-dark">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">Cedula</th>
            <th scope="col">Nombre</th>
            <th scope="col">Apellido</th>
            <th scope="col">Cargo</th>
            <th scope="col">Horas</th>
          </tr>
        </thead>
        <tbody>
          ' .
  $consulta
  . '</tbody>
        </table>
</div>

</body>';

$stylesheet = file_get_contents('Assets/kv-mpdf-bootstrap.css');
$mpdf->WriteHTML($stylesheet, 1); // CSS Script goes here.
$mpdf->WriteHTML($html, 2); //HTML Content goes here.
$mpdf->Output();
