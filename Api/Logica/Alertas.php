<?php

//include_once 'Datos/DUsuarios';
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Datos/Alertas.php');

class Alertas {

    public function get_AlertasCant($us) {

        $datos = new DAlertas();

        $rows = array();

        $result = $datos->get_AlertasCant($us);


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_Alertas($us) {

        $datos = new DAlertas();

        $result = $datos->get_Alertas($us);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_Alerta($id) {

        $datos = new DAlertas();

        $rows = array();

        $result = $datos->get_Alerta($id);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function insert_Alertas($nom, $des, $us) {

        $datos = new DAlertas();

        $result = $datos->insert_Alertas($nom, $des, $us);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_Alertas($id) {

        $datos = new DAlertas();

        $result = $datos->update_Alertas($id);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

}
