<?php

//include_once 'Datos/DUsuarios';
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Datos/RelacionInsumos.php');

class RelacionInsumos {

    public function get_Relaciones() {

        $datos = new DRelInsumos();

        $rows = array();

        $result = $datos->get_Relaciones();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_RelacionXPro($id) {

        $datos = new DRelInsumos();

        $result = $datos->get_RelacionXPro($id);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function delete_Relacion($pro, $ins) {

        $datos = new DRelInsumos();

        $result = $datos->Delete_Relacion($pro, $ins);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function insert_Relacion($pro, $ins, $cant) {

        $datos = new DRelInsumos();

        $result = $datos->insert_Relacion($pro, $ins, $cant);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function insert_RelacionMas($dat) {

        $datos = new DRelInsumos();
        $dt = json_decode($dat);
        $cont = 0;

        foreach ($dt as $data) {
            $pro = $data->pro;
            $ins = $data->ins;
            $cant = $data->cant;

            $result = $datos->insert_Relacion($pro, $ins, $cant);
                $cont = 0;
                if ($result == TRUE) {
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

    public function update_Relacion($pro, $ins, $cant) {

        $datos = new DRelInsumos();

        $result = $datos->update_Relacion($pro, $ins, $cant);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

}
