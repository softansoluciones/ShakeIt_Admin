<?php

include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Datos/Reportes.php');

class Reportes {

    public function get_Reportes() {

        $datos = new DReportes();
        $rows = array();

        $result = $datos->get_Reportes();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function insert_Reporte($iden, $val, $sede) {

        $datos = new DReportes();

        $result = $datos->insert_Reporte($iden, $val, $sede);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_Reporte($iden, $val, $sede) {

        $datos = new DReportes();

        $result = $datos->update_Reporte($iden, $val, $sede);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

}
