<?php
include "db.php";
require __DIR__ . '/vendor/autoload.php';

$mpdf = new \Mpdf\Mpdf();
if(isset($_GET)){
    $ano = $_GET['ano'];
    $tax = $_GET['tax'];
}
$query = "CALL reporte8(".$ano.",".$tax.")";
$stmt = $sql->prepare($query);
$stmt->execute();
$rows = $stmt->fetchAll();
$i = 0;
$total=0;
$consulta = '';
$meses = ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
foreach ($rows as $row) {
  $consulta = $consulta . '
    <tr>
        <td>' . $meses[$i] . '</td>
        <td>' . $row['Ventas_Totales'] . '</td>
        <td>' . $row['Gastos_Totales'] . '</td>
        <td>' . $row['Ganancia_neta'] . '</td>
        <td>' . $row['impuestos'] . '</td>
        <td>-</td>
    </tr>
    ';
  $i++;
  $total= $total+ $row['Ganancia_neta']-$row['impuestos'];
}

$html = '<nav>
<img src="Assets/logo.png" width="170" height="90" style="margin: 2% 30% 2% 2%">
<h4 style="text-align: center;"> Reporte #1</h4>
<h5 style="text-align: center;"> Nombre de superhéroe o supervillano que poseen poderes artificiales y que han sido líderes </h5>
</nav>
<body>
<div style="margin: 3%">
    <table class="table table-striped table-dark">
        <thead>
          <tr>
            <th scope="col">Mes</th>
            <th scope="col">Ventas Totales</th>
            <th scope="col">Gastos Totales</th>
            <th scope="col">Ganancia neta</th>
            <th scope="col">Impuestos</th>
            <th scope="col">Resultado</th>
          </tr>
        </thead>
        <tbody>
          ' .
  $consulta
  . '
  <tr>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>'.$total.'</td>
    </tr>
  </tbody>
        </table>
</div>

</body>';

$stylesheet = file_get_contents('Assets/kv-mpdf-bootstrap.css');
$mpdf->WriteHTML($stylesheet, 1); // CSS Script goes here.
$mpdf->WriteHTML($html, 2); //HTML Content goes here.
$mpdf->Output();
