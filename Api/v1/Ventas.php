<?php
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('content-type: application/json; charset=utf-8');

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Logica/Ventas.php');


$datos = new Ventas();
$res = new \stdClass();
$result = new \stdClass();

if (isset($_GET["detalle"])) {

  $entrada = $_GET["detalle"];
  $entradadec = utf8_encode(base64_decode($entrada));
  $datosparciales = explode("|", $entradadec);

  $id = $datosparciales[0];

    $resultado = $datos->get_Detalle($id);

    if ($resultado != 0) {

        $res->Respuesta = $resultado;
        $res->Mensaje = "Ok";
        echo json_encode($res);
    } else {
        $res->Respuesta = 0;
        $res->Mensaje = "No existen datos.";
        echo json_encode($res);
    }
}

if (isset($_GET["venta"])) {

  $entrada = $_GET["venta"];
  $entradadec = utf8_encode(base64_decode($entrada));
  $datosparciales = explode("|", $entradadec);

  $id = $datosparciales[0];

    $resultado = $datos->get_Venta($id);

    if ($resultado != 0) {

        $res->Respuesta = $resultado;
        $res->Mensaje = "Ok";
        echo json_encode($res);
    } else {
        $res->Respuesta = 0;
        $res->Mensaje = "No existen datos.";
        echo json_encode($res);
    }
}

if (isset($_GET["ventas"])) {

  $entrada = $_GET["ventas"];
  $entradadec = utf8_encode(base64_decode($entrada));
  $datosparciales = explode("|", $entradadec);

  $fecha = $datosparciales[0];
  $dia = $datosparciales[1];
  $mes = $datosparciales[2];
  $anio = $datosparciales[3];
  $sede = $datosparciales[4];

    $resultado = $datos->get_Ventas($fecha, $dia, $mes, $anio, $sede);
    $total = $datos->get_VentasTotal($fecha, $dia, $mes, $anio, $sede);

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

if (isset($_GET["ventasfilt"])) {

  $entrada = $_GET["ventasfilt"];
  $entradadec = utf8_encode(base64_decode($entrada));
  $datosparciales = explode("|", $entradadec);

  $mes = $datosparciales[0];
  $anio = $datosparciales[1];
  $sede = $datosparciales[2];

    $resultado = $datos->get_VentasFilt($mes, $anio, $sede);
    $total = $datos->get_VentasFiltTotal($mes, $anio, $sede);

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

    $entrada = $_POST["insertar"];
    $entradadec = utf8_encode(base64_decode($entrada));
    $datosparciales = explode("|", $entradadec);

    $cant = $datosparciales[0];
    $fac = $datosparciales[1];
    $sede = $datosparciales[2];
    $consumo = $datosparciales[3];
    $pago = $datosparciales[4];
    $ent = $datosparciales[5];
    $val = $datosparciales[6];

    $resultado = $datos->insert_Venta($cant, $fac, $sede, $consumo, $pago, $ent, $val);

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
