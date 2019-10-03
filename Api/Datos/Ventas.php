<?php

include_once 'MetodosDatos.php';

class DVentas {

  public function get_Detalle($id) {

      $sql = "CALL Ventas_GetDetalle('$id');";
      $db = new dbmanager();

      return $db->executeQuery($sql);
  }

  public function get_Venta($id) {

      $sql = "CALL Ventas_GetXId('$id');";
      $db = new dbmanager();

      return $db->executeQuery($sql);
  }

  public function get_Ventas($fecha, $dia, $mes, $anio, $sede) {

      $sql = "CALL Ventas_Get('$fecha', '$dia', '$mes', '$anio', '$sede');";
      $db = new dbmanager();

      return $db->executeQuery($sql);
  }

  public function get_VentasTotal($fecha, $dia, $mes, $anio, $sede) {

      $sql = "CALL Ventas_GetTotal('$fecha', '$dia', '$mes', '$anio', '$sede');";
      $db = new dbmanager();

      return $db->executeQuery($sql);
  }

  public function get_VentasFilt($mes, $anio, $sede) {

      $sql = "CALL Ventas_GetXFilt('$mes', '$anio', '$sede');";
      $db = new dbmanager();

      return $db->executeQuery($sql);
  }

  public function get_VentasFiltTotal($mes, $anio, $sede) {

      $sql = "CALL Ventas_GetXFiltTotal('$mes', '$anio', '$sede');";
      $db = new dbmanager();

      return $db->executeQuery($sql);
  }

    public function insert_Venta($cant, $fac, $sede, $consumo, $pago, $ent, $val) {

        $sql = "CALL Ventas_Add('$cant', '$fac', '$sede', '$consumo', '$pago', '$ent', '$val', 1);";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

}
