<?php
//include("dbConnection.php");

?>

<!DOCTYPE html>
<html lang="es">

<head>
    <title>Reportes</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="body dark-scheme">
    <style>
        body {
            background: #1c1c1c;
        }

        #caja {
            flex: 0 0 auto;
            display: block;


            width: 1000px;
            height: 800px;

            margin: 3% auto auto;
            padding: 60px;
            text-align: center;
        }

        #titulo {
            top: -10px;
            margin: -90px 10px 0px 0px;
            color: #FFFFFF;
        }

        /*
        #boton:hover,
        #boton:active {
            background: #FF0000;
        }
        */

        #fila {
            font-size: medium;
            text-align: left;
            padding: 8px;
            width: 90%;
        }

        .linea {
            height: 85px;
            outline: 5px #007ACC solid;
            padding: 10px 15px;
            border-radius: 5px;
            border: none;
            background-color: #FFFFFF;
        }

        .fechas {
            outline: 5px #007ACC solid;
            padding: 10px 15px;
            border-radius: 5px;
            margin-right: 25px;
            width: 5em;
            border: none;
            background-color: #FFFFFF;
        }

        .categorias {
            outline: 5px #007ACC solid;
            padding: 10px 15px;
            border-radius: 5px;
            margin-right: 25px;
            width: 10em;
            border: none;
            background-color: #FFFFFF;
        }

        .espacio {
            height: 20px;
        }

        .button {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 10px 15px;
            gap: 15px;
            margin-right: 10px;
            background-color: #007ACC;
            outline: 3px #007ACC solid;
            outline-offset: -3px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: 400ms;
        }

        #boton {
            color: white;
            font-weight: 700;
            font-size: 1em;
            transition: 400ms;
        }

        .button:hover {
            background-color: transparent;
        }

        #boton:hover {
            color: #007ACC;
        }
    </style>
    <div id="caja">
        <h2 id="titulo">Generador de Reportes</h2><br>
        <table>
            <thead>
                <th></th>
                <th></th>
            </thead>
            <tbody>
                <tr class="linea">
                    <td id="fila">
                        Reporte #1: Reporte de empleados por horas trabajadas
                    </td>
                    <td></td>
                    <td>
                        <button class="button" onclick="popupwindow('generar1.php','popup',1000,800);" id="boton">Generar</button>
                    </td>
                </tr>
                <tr class="espacio"></tr>
                <tr class="linea">
                    <td id="fila">
                        Reporte #2: Productos ordenados por cantidad de ventas
                    </td>
                    <td></td>
                    <td>
                        <button class="button" onclick="popupwindow('generar2.php','popup',1000,800);" id="boton">Generar</button>
                    </td>
                </tr>
                <tr class="espacio"></tr>
                <tr class="linea">
                    <td id="fila">
                        Reporte #3: Horas cumplidas por los empleados dado un mes especifico<br> (Selecciona una fecha)
                    </td>
                    <td>
                        <table>
                            <td>
                                <select name="mesR3" id="mesR3" class="fechas">
                                    <option value="1">Enero</option>
                                    <option value="2">Febrero</option>
                                    <option value="3">Marzo</option>
                                    <option value="4">Abril</option>
                                    <option value="5">Mayo</option>
                                    <option value="6">Junio</option>
                                    <option value="7">Julio</option>
                                    <option value="8">Agosto</option>
                                    <option value="9">Septiembre</option>
                                    <option value="10">Octubre</option>
                                    <option value="11">Noviembre</option>
                                    <option value="12">Diciembre</option>
                                </select>
                            </td>
                            <td>
                                <select name="anoR3" id="anoR3" class="fechas">
                                    <option value="2023">2023</option>
                                    <option value="2022">2022</option>
                                </select>
                            </td>
                        </table>
                    </td>
                    <td>
                        <button class="button" onclick="generar3()" id="boton">Generar</button>
                    </td>
                </tr>
                <tr class="espacio"></tr>
                <tr class="linea">
                    <td id="fila">
                        Reporte #4: Productos filtrados por una categoria especifica y su cantidad en inventario (Selecciona una categoria)
                    </td>
                    <td>
                        <select name="catR4" id="catR4" class="categorias">
                            <option value="Medicamento">Medicamento</option>
                            <option value="Cuidado Personal">Cuidado Personal</option>
                            <option value="Suplementos y Vitaminas">Suplementos y Vitaminas</option>
                            <option value="Equipos y Dispositivos Médicos">Equipos y Dispositivos Médicos</option>
                            <option value="Botiquín">Botiquín</option>
                            <option value="Dietética">Dietética</option>
                            <option value="Cosmética">Cosmética</option>
                            <option value="Infantil">Infantil</option>
                            <option value="Ortopedia">Ortopedia</option>
                        </select>
                    </td>
                    <td>
                        <button class="button" onclick="generar4()" id="boton">Generar</button>
                    </td>
                </tr>
                <tr class="espacio"></tr>
                <tr class="linea">
                    <td id="fila">
                        Reporte #5: Empleados actuales ordenados por cantidad de productos vendidos
                    </td>
                    <td></td>
                    <td>
                        <button class="button" onclick="popupwindow('generar5.php','popup',1000,800);" id="boton">Generar</button>
                    </td>
                </tr>
                <tr class="espacio"></tr>
                <tr class="linea">
                    <td id="fila">
                        Reporte #6: Producto menos vendido de cada categoria
                    </td>
                    <td></td>
                    <td>
                        <button class="button" onclick="popupwindow('generar6.php','popup',1000,800);" id="boton">Generar</button>
                    </td>
                </tr>
                <tr class="espacio"></tr>
                <tr class="linea">
                    <td id="fila">
                        Reporte #7: Categorias mas vendidas por cada mes del año (Selecciona un año)
                    </td>
                    <td>
                        <select name="anoR7" id="anoR7" class="fechas">
                            <option value="2023">2023</option>
                            <option value="2022">2022</option>
                            <option value="2021">2021</option>
                        </select>
                    </td>
                    <td>
                        <button class="button" onclick="generar7()" id="boton">Generar</button>
                    </td>
                </tr>
                <tr class="espacio"></tr>
                <tr class="linea">
                    <td id="fila">
                        Reporte #8: Reporte Financiero
                    </td>
                    <td>
                        <table>
                            <td>
                            <select name="anoR8" id="anoR8" class="fechas">
                                <option value="2023">2023</option>
                                <option value="2022">2022</option>
                                <option value="2021">2021</option>
                            </select>
                            </td>
                            <td>
                                <input type="number" id="taxR8" placeholder="%" class="fechas">
                            </td>
                        </table>
                       
                    </td>
                    <td>
                        <button class="button" onclick="generar8()" id="boton">Generar</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>





</body>
<script>
    function popupwindow(url, title, w, h) {
        var left = (screen.width / 2) - (w / 2);
        var top = (screen.height / 2) - (h / 2);
        return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
    }

    function generar3() {
        let mes = document.getElementById('mesR3').value;
        let ano = document.getElementById('anoR3').value;
        popupwindow('generar3.php?mes=' + mes + '&ano=' + ano, 'popup', 1000, 800);
    }
    
    function generar4() {
        let cat = document.getElementById('catR4').value;
        popupwindow('generar4.php?cat=' + cat, 'popup', 1000, 800);
    }

    function generar7() {
        let ano = document.getElementById('anoR7').value;
        popupwindow('generar7.php?ano=' + ano, 'popup', 1000, 800);
    }

    function generar8() {
        let ano = document.getElementById('anoR8').value;
        let tax =document.getElementById('taxR8').value;
        popupwindow('generar8.php?ano=' + ano+'&tax='+tax, 'popup', 1000, 800);
    }
</script>
