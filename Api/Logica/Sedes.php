<?php

//include_once 'Datos/DUsuarios';
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Datos/Sedes.php');

class Sedes {

    public function get_Sedes() {

        $datos = new DSedes();

        $rows = array();

        $result = $datos->get_Sedes();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_Sede($id) {

        $datos = new DSedes();

        $result = $datos->get_Sede($id);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_SedeXNom($nom) {

        $datos = new DSedes();

        $result = $datos->get_SedeXNom($nom);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function delete_Sede($id) {

        $datos = new DSedes();

        $result = $datos->Delete_Sede($id);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function insert_Sede($nit, $nom, $dir, $mun, $tel1, $tel2, $tel3, $long, $lat) {

        $datos = new DSedes();

        $result = $datos->insert_Sede($nit, $nom, $dir, $mun, $tel1, $tel2, $tel3, $long, $lat);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_Sede($id, $nit, $nom, $dir, $mun, $tel1, $tel2, $tel3, $long, $lat) {

        $datos = new DSedes();

        $result = $datos->update_Sede($id, $nit, $nom, $dir, $mun, $tel1, $tel2, $tel3, $long, $lat);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

}
