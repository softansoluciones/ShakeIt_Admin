<?php

//include_once 'Datos/DUsuarios';
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Datos/Clientes.php');

class Clientes {

    public function get_Clientes() {

        $datos = new DClientes();

        $rows = array();

        $result = $datos->get_Clientes();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_Cliente($id) {

        $datos = new DClientes();

        $result = $datos->get_Cliente($id);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_ClienteXDoc($doc) {

        $datos = new DClientes();

        $result = $datos->get_ClienteXDoc($doc);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_ClienteXTel($tel) {

        $datos = new DClientes();

        $result = $datos->get_ClienteXTel($tel);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function insert_Cliete($doc, $nom, $ape, $dir, $barr, $mun, $tel, $us, $pass, $email, $nac) {

        $datos = new DClientes();

        $result = $datos->insert_Cliente($doc, $nom, $ape, $dir, $barr, $mun, $tel, $us, $pass, $email, $nac);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function insert_ClieteLocal($doc, $nom, $ape, $dir, $barr, $mun, $tel, $email, $nac) {

        $datos = new DClientes();

        $result = $datos->insert_ClienteLocal($doc, $nom, $ape, $dir, $barr, $mun, $tel, $email, $nac);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function insert_ClieteVenta($nom, $ape, $dir, $barr, $mun, $tel) {

        $datos = new DClientes();

        $result = $datos->insert_ClienteVenta($nom, $ape, $dir, $barr, $mun, $tel);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_Cliente($id, $doc, $nom, $ape, $dir, $barr, $mun, $tel, $us, $pass, $email, $nac) {

        $datos = new DClientes();

        $result = $datos->update_Cliente($id, $doc, $nom, $ape, $dir, $barr, $mun, $tel, $us, $pass, $email, $nac);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_ClienteLocal($id, $doc, $nom, $ape, $dir, $barr, $mun, $tel, $email, $nac) {

        $datos = new DClientes();

        $result = $datos->update_ClienteLocal($id, $doc, $nom, $ape, $dir, $barr, $mun, $tel, $email, $nac);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_ClienteVenta($id, $nom, $ape, $dir, $barr, $mun, $tel) {

        $datos = new DClientes();

        $result = $datos->update_ClienteVenta($id, $nom, $ape, $dir, $barr, $mun, $tel);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

}
