<?php

//include_once 'Datos/DUsuarios';
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Datos/Ventas.php');

class Ventas {

  public function get_Detalle($id) {

      $datos = new DVentas();

      $rows = array();

      $result = $datos->get_Detalle($id);


      if ($result->num_rows > 0) {
          while ($row = $result->fetch_assoc()) {
              $rows[] = $row;
          }
      } else {
          $rows = 0;
      }
      return $rows;
  }

  public function get_Venta($id) {

      $datos = new DVentas();
      $rows = array();
      $result = $datos->get_Venta($id);

      if ($result->num_rows > 0) {
          while ($row = $result->fetch_assoc()) {
              $rows[] = $row;
          }
      } else {
          $rows = 0;
      }
      return $rows;
  }

  public function get_Ventas($fecha, $dia, $mes, $anio, $sede) {

      $datos = new DVentas();

      $rows = array();

      $result = $datos->get_Ventas($fecha, $dia, $mes, $anio, $sede);


      if ($result->num_rows > 0) {
          while ($row = $result->fetch_assoc()) {
              $rows[] = $row;
          }
      } else {
          $rows = 0;
      }
      return $rows;
  }

  public function get_VentasTotal($fecha, $dia, $mes, $anio, $sede) {

      $datos = new DVentas();

      $rows = array();

      $result = $datos->get_VentasTotal($fecha, $dia, $mes, $anio, $sede);


      if ($result->num_rows > 0) {
          while ($row = $result->fetch_assoc()) {
              $rows[] = $row;
          }
      } else {
          $rows = 0;
      }
      return $rows;
  }

  public function get_VentasFilt($mes, $anio, $sede) {

      $datos = new DVentas();

      $rows = array();

      $result = $datos->get_VentasFilt($mes, $anio, $sede);


      if ($result->num_rows > 0) {
          while ($row = $result->fetch_assoc()) {
              $rows[] = $row;
          }
      } else {
          $rows = 0;
      }
      return $rows;
  }

  public function get_VentasFiltTotal($mes, $anio, $sede) {

      $datos = new DVentas();

      $rows = array();

      $result = $datos->get_VentasFiltTotal($mes, $anio, $sede);


      if ($result->num_rows > 0) {
          while ($row = $result->fetch_assoc()) {
              $rows[] = $row;
          }
      } else {
          $rows = 0;
      }
      return $rows;
  }

    public function insert_Venta($cant, $fac, $sede, $consumo, $pago, $ent, $val) {

        $datos = new DVentas();

        $result = $datos->insert_Venta($cant, $fac, $sede, $consumo, $pago, $ent, $val);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

}
