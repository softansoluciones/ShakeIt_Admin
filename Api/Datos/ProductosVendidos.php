<?php

include_once 'MetodosDatos.php';

class DProductosVendidos {

  public function get_ProductosV($fecha, $dia, $mes, $anio, $sede) {

      $sql = "CALL ProductosV_Get('$fecha', '$dia', '$mes', '$anio', '$sede');";
      $db = new dbmanager();

      return $db->executeQuery($sql);
  }

  public function get_ProductosVTotal($fecha, $dia, $mes, $anio, $sede) {

      $sql = "CALL ProductosV_GetTotal('$fecha', '$dia', '$mes', '$anio', '$sede');";
      $db = new dbmanager();

      return $db->executeQuery($sql);
  }

  public function get_ProductosVFilt($mes, $anio, $sede) {

      $sql = "CALL ProductosV_GetXFilt('$mes', '$anio', '$sede');";
      $db = new dbmanager();

      return $db->executeQuery($sql);
  }

  public function get_ProductosVFiltTotal($mes, $anio, $sede) {

      $sql = "CALL ProductosV_GetXFiltTotal('$mes', '$anio', '$sede');";
      $db = new dbmanager();

      return $db->executeQuery($sql);
  }

  public function insert_ProductoV($pro, $cant, $des, $fac, $sede) {

        $sql = "CALL ProductosV_Add('$pro', '$cant', '$des', '$fac', '$sede', 1);";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

}
