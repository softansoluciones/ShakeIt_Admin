<?php

//include_once 'Datos/DUsuarios';
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Datos/ProductosVendidos.php');

class ProductosVendidos {

  public function get_ProductosV($fecha, $dia, $mes, $anio, $sede) {

      $datos = new DProductosVendidos();

      $rows = array();

      $result = $datos->get_ProductosV($fecha, $dia, $mes, $anio, $sede);


      if ($result->num_rows > 0) {
          while ($row = $result->fetch_assoc()) {
              $rows[] = $row;
          }
      } else {
          $rows = 0;
      }
      return $rows;
  }

  public function get_ProductosVTotal($fecha, $dia, $mes, $anio, $sede) {

      $datos = new DProductosVendidos();

      $rows = array();

      $result = $datos->get_ProductosVTotal($fecha, $dia, $mes, $anio, $sede);


      if ($result->num_rows > 0) {
          while ($row = $result->fetch_assoc()) {
              $rows[] = $row;
          }
      } else {
          $rows = 0;
      }
      return $rows;
  }

  public function get_ProductosVFiltTotal($mes, $anio, $sede) {

      $datos = new DProductosVendidos();

      $rows = array();

      $result = $datos->get_ProductosVFiltTotal($mes, $anio, $sede);


      if ($result->num_rows > 0) {
          while ($row = $result->fetch_assoc()) {
              $rows[] = $row;
          }
      } else {
          $rows = 0;
      }
      return $rows;
  }

  public function get_ProductosVFilt($mes, $anio, $sede) {

      $datos = new DProductosVendidos();

      $rows = array();

      $result = $datos->get_ProductosVFilt($mes, $anio, $sede);


      if ($result->num_rows > 0) {
          while ($row = $result->fetch_assoc()) {
              $rows[] = $row;
          }
      } else {
          $rows = 0;
      }
      return $rows;
  }

  public function insert_ProductosV($dat) {

        $datos = new DProductosVendidos();
        $dt = json_decode($dat);
        $cont = 0;

        foreach ($dt as $data) {

            $pro = $data->pro;
            $cant = $data->cant;
            $fac = $data->fac;
            $sede = $data->sede;
            $des = $data->desc;

            $result = $datos->insert_ProductoV($pro, $cant, $des, $fac, $sede);
            if ($result == TRUE) {
                $cont = 0;
            } else {
                $cont++;
            }
        }

        if ($cont > 0) {
            $rows = 0;
        } else {
            $rows = 1;
        }
        return $rows;
    }

}
