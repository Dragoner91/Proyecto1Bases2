<?php
include("db.php");
$prueba = "holi";
$query = "select * from empleado";
$stmt = $sql->prepare($query);
$stmt->execute();
$empleados = $stmt->fetchAll(); //buscamos todos los empleados

foreach ($empleados as $empleado) {
    $query = "SELECT * from contrato_empleado where fk_emp = ?";
    $stmt = $sql->prepare($query);
    $stmt->bindParam(1, $empleado['cedula_emp'], PDO::PARAM_STR); //buscamos el contrato del empleado
    $stmt->execute();
    $contrato = $stmt->fetch();

    $query = "SELECT H.hora_entrada, H.hora_salida, H.dia_semana FROM Horario as H, C_H as CH, contrato_empleado as CE where CE.id_contrato = CH.contrato_fk AND H.id_horario = CH.fk_horario AND CE.fk_emp = ?"; //buscamos los dias que trabaja ese empleado
    $stmt = $sql->prepare($query);
    $stmt->bindParam(1, $empleado['cedula_emp'], PDO::PARAM_STR); //obetener horario del empleado
    $stmt->execute();
    $dias = $stmt->fetchAll();
    
    $dias_semana = array(
        0 => 'Domingo',
        1 => 'Lunes',
        2 => 'Martes',
        3 => 'Miércoles',
        4 => 'Jueves',
        5 => 'Viernes',
        6 => 'Sábado'
    );
    
    foreach ($dias as $dia) {
        $cadena_minusculas = mb_strtolower($dia['dia_semana'], 'UTF-8');
        $diaTrabajo = ucfirst($cadena_minusculas);
        $inicio = new DateTime($contrato['fecha_ingreso']);
        $fin = new DateTime($contrato['fecha_egreso']);
        if($contrato['fecha_egreso'] == NULL){
            $fin = "2024-12-31";
            $fin = new DateTime($fin);
        }
        
        for ($fecha = clone $inicio; $fecha <= $fin; $fecha->modify('+1 day')) {
            if ($fecha->format('m') > 4 AND $fecha->format('Y') == 2024) {
                break; // Salir del bucle si la fecha es posterior a 2023
            }
            
            // Obtener la fecha en formato 'YYYY-MM-DD'
            $fecha_actual = $fecha->format('Y-m-d');

            // Obtener el día de la semana (0 para Domingo, 1 para Lunes, etc.)
            $dia_semana = $fecha->format('w');
            $dia_semana = $dias_semana[$dia_semana];
            if($contrato['fk_emp'] == "21131494"){
                echo "<h5> $diaTrabajo y $dia_semana</h5>";
            }
            if ($diaTrabajo == $dia_semana) {

                $fechaVerificar = clone $fecha;
                $horaEntrada = DateTime::createFromFormat('H:i:s', $dia['hora_entrada']);
                $horaSalida = DateTime::createFromFormat('H:i:s', $dia['hora_salida']);
                if($horaSalida < $horaEntrada){
                    $fechaVerificar->modify('+1 day');
                }
                $horaEntrada = $fecha->format('Y-m-d')." ".$dia['hora_entrada'];
                $horaSalida = $fechaVerificar->format('Y-m-d')." ".$dia['hora_salida'];

                

                $query = "INSERT INTO `entrada_salida`(`hora_entrada`, `hora_salida`, `fk_contrato`, `semana_dia`) VALUES (?, ?, ?, ?)"; 
                $stmt = $sql->prepare($query);
                $stmt->bindParam(1, $horaEntrada, PDO::PARAM_STR); 
                $stmt->bindParam(2, $horaSalida, PDO::PARAM_STR); 
                $stmt->bindParam(3, $contrato['id_contrato'], PDO::PARAM_STR); 
                $stmt->bindParam(4, $dia['dia_semana'], PDO::PARAM_STR); 
                $stmt->execute();
            }
        }
        
    }
}
