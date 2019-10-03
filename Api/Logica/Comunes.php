<?php

//include_once 'Datos/DUsuarios';
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Datos/Comunes.php');

class Comunes {

    public function get_Insumos() {

        $datos = new DComunes();

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

    public function get_Sedes() {

        $datos = new DComunes();

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

    public function get_Anios() {

        $datos = new DComunes();

        $rows = array();

        $result = $datos->get_Anios();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_Meses() {

        $datos = new DComunes();

        $rows = array();

        $result = $datos->get_Meses();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_Unidades() {

        $datos = new DComunes();

        $rows = array();

        $result = $datos->get_Unidades();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_Categorias() {

        $datos = new DComunes();

        $rows = array();

        $result = $datos->get_Categorias();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_UsuariosTipo() {

        $datos = new DComunes();

        $rows = array();

        $result = $datos->get_UsuariosTipo();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_Estados() {

        $datos = new DComunes();

        $rows = array();

        $result = $datos->get_Estados();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_Departamentos() {

        $datos = new DComunes();

        $rows = array();

        $result = $datos->get_Departamentos();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_Municipios($dep) {

        $datos = new DComunes();

        $rows = array();

        $result = $datos->get_Municipios($dep);


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_MunicipiosAll() {

        $datos = new DComunes();

        $rows = array();

        $result = $datos->get_MunicipiosAll();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

}
