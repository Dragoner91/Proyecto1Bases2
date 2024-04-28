<?php
include "db.php";
require __DIR__ . '/vendor/autoload.php';

$mpdf = new \Mpdf\Mpdf();
$ano = $_GET['ano'];
$logo = file_get_contents('Assets/logo.jpg');
$htmlNav = '<nav>
<img src="data:image/jpg;base64,' . base64_encode($logo) . '" width="90" height="90" style="margin: 2% 30% 2% 2%">
<h4 style="text-align: center;"> Reporte #7</h4>
<h5 style="text-align: center;"> Categorias mas vendidas por cada mes del año </h5>
<h5> Año: '.$ano.'</h5>
</nav>
<body>
<div style="margin: 3%">
    <table class="table table-striped table-dark">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">Mes</th>
            <th scope="col">Categoria</th>
            <th scope="col">Total Ventas</th>
          </tr>
        </thead>
        <tbody>
          ';

$stylesheet = file_get_contents('Assets/kv-mpdf-bootstrap.css');
$mpdf->WriteHTML($stylesheet, 1); // CSS Script goes here.
$mpdf->WriteHTML($htmlNav, 2); //HTML Content goes here.



$query = "CALL reporte7(".$ano.")";
$stmt = $sql->prepare($query);
$stmt->execute();
$rows = $stmt->fetchAll();
$i = 1;
$consulta = '';
foreach ($rows as $row) {
  $consulta ='
    <tr>
        <th scope="row" style="vertical-align: middle;">' . $i . '</th>
        <td style="vertical-align: middle;">' . $row['Mes_Venta'] . '</td>
        <td style="vertical-align: middle;">' . $row['nombre_categoria'] . '</td>
        <td style="vertical-align: middle;">' . $row['Total_Ventas'] . '</td>
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
