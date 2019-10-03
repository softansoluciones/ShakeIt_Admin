<?php

//include_once 'Datos/DUsuarios';
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Datos/Usuarios.php');

class Usuarios {


  public function get_Usuarios() {
        $datos = new DUsuarios();

        $rows = array();

        $result = $datos->get_Usuarios();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_Usuario($iduser) {

        $datos = new DUsuarios();

        $result = $datos->get_Usuario($iduser);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_UsuarioXDoc($doc) {

        $datos = new DUsuarios();

        $result = $datos->get_UsuarioXDoc($doc);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_UsuarioLogin($doc, $pass) {

        $datos = new DUsuarios();

        $rows = array();

        $result = $datos->get_UsuarioLogin($doc, $pass);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function insert_Usuario($doc, $nom, $ape, $tel, $email, $pass, $tipo, $estado) {

        $datos = new DUsuarios();

        $result = $datos->insert_Usuario($doc, $nom, $ape, $tel, $email, $pass, $tipo, $estado);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_Usuario($id, $doc, $nom, $ape, $tel, $email, $pass, $tipo, $estado) {

        $datos = new DUsuarios();

        $result = $datos->update_Usuario($id, $doc, $nom, $ape, $tel, $email, $pass, $tipo, $estado);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function delete_Usuario($iduser) {

        $datos = new DUsuarios();

        $result = $datos->delete_Usuario($iduser);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

}
