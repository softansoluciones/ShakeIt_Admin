<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/ProductosVendidos.php');


$datos = new ProductosVendidos();
$res = new \stdClass();
$result = new \stdClass();

if (isset($_GET["productosv"])) {

  $entrada = $_GET["productosv"];
  $entradadec = utf8_encode(base64_decode($entrada));
  $datosparciales = explode("|", $entradadec);

  $fecha = $datosparciales[0];
  $dia = $datosparciales[1];
  $mes = $datosparciales[2];
  $anio = $datosparciales[3];
  $sede = $datosparciales[4];

    $resultado = $datos->get_ProductosV($fecha, $dia, $mes, $anio, $sede);
    $total = $datos->get_ProductosVTotal($fecha, $dia, $mes, $anio, $sede);

    if ($resultado != 0) {

      $result->Data = $resultado;
      $result->Total = $total;
        $res->Respuesta = $result;
        $res->Mensaje = "Ok";
        echo json_encode($res);
    } else {
        $res->Respuesta = 0;
        $res->Mensaje = "No existen datos.";
        echo json_encode($res);
    }
}

if (isset($_GET["productosvfilt"])) {

  $entrada = $_GET["productosvfilt"];
  $entradadec = utf8_encode(base64_decode($entrada));
  $datosparciales = explode("|", $entradadec);

  $mes = $datosparciales[0];
  $anio = $datosparciales[1];
  $sede = $datosparciales[2];

    $resultado = $datos->get_ProductosVFilt($mes, $anio, $sede);
    $total = $datos->get_ProductosVFiltTotal($mes, $anio, $sede);

    if ($resultado != 0) {

$result->Data = $resultado;
$result->Total = $total;
        $res->Respuesta = $result;
        $res->Mensaje = "Ok";
        echo json_encode($res);
    } else {
        $res->Respuesta = 0;
        $res->Mensaje = "No existen datos.";
        echo json_encode($res);
    }
}

if (isset($_POST["insertar"])) {

    $data = $_POST["insertar"];

    $resultado = $datos->insert_ProductosV($data);

    if ($resultado != 0) {

        $res->Respuesta = $resultado;
        $res->Mensaje = "Se ha registrado la información con éxito.";
        echo json_encode($res);
    } else {
        $res->Respuesta = 0;
        $res->Mensaje = "Error al registrar la información.";
        echo json_encode($res);
    }
}
