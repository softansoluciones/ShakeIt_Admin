<?php

//include_once 'Datos/DUsuarios';
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Datos/Insumos.php');

class Insumos {

    public function get_Insumos() {

        $datos = new DInsumos();

        $rows = array();

        $result = $datos->get_Insumos();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_Insumo($id) {

        $datos = new DInsumos();

        $result = $datos->get_Insumo($id);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_InsumoXNom($nom) {

        $datos = new DInsumos();

        $rows = array();

        $result = $datos->get_InsumosXNom($nom);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function delete_Insumo($id) {

        $datos = new DInsumos();

        $result = $datos->Delete_Insumo($id);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function insert_Insumo($nom, $uni, $cmin) {

        $datos = new DInsumos();

        $result = $datos->insert_Insumo($nom, $uni, $cmin);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_Insumo($id, $nom, $uni, $cmin) {

        $datos = new DInsumos();

        $result = $datos->update_Insumo($id, $nom, $uni, $cmin);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

}
