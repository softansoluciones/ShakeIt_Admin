<?php

//include_once 'Datos/DUsuarios';
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Datos/Caja.php');

class Caja {

    public function get_Caja() {

        $datos = new DCaja();
        $rows = array();

        $result = $datos->get_Caja();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_CajaXId($id) {

        $datos = new DCaja();

        $result = $datos->get_CajaXId($id);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_CajaXSede($sede) {

        $datos = new DCaja();

        $result = $datos->get_CajaXSede($sede);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function insert_Caja($val, $est, $sede) {

        $datos = new DCaja();

        $result = $datos->insert_Caja($val, $est, $sede);

        if ($result === TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_Caja($id, $val, $est, $sede) {

        $datos = new DCaja();

        $result = $datos->update_Caja($id, $val, $est, $sede);

        if ($result === TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function delete_Caja($id) {

        $datos = new DCaja();

        $result = $datos->delete_Caja($id);

        if ($result === TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

}
