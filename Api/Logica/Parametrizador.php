<?php

//include_once 'Datos/DUsuarios';
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Datos/Parametrizador.php');

class Parametrizador {

    public function get_Parametrizador() {
        $datos = new DParametrizador();

        $rows = array();

        $result = $datos->get_Parametrizador();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    //Categorías
    
    public function get_Categorias() {

        $datos = new DParametrizador();

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

    public function get_CategoriasPrincipales() {

        $datos = new DParametrizador();

        $result = $datos->get_CategoriasPrincipales();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }
    
    public function get_CategoriasScundarias() {

        $datos = new DParametrizador();

        $result = $datos->get_CategoriasScundarias();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }
    
    public function insert_Categoria($nombre, $tipo) {

        $datos = new DParametrizador();

        $result = $datos->insert_Categoria($nombre, $tipo);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_Categoria($id, $nombre, $tipo) {

        $datos = new DParametrizador();

        $result = $datos->update_Categoria($id, $nombre, $tipo);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    //Consumo
    public function get_Consumo() {

        $datos = new DParametrizador();

        $result = $datos->get_Consumo();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }
    
    public function insert_Consumo($nombre) {

        $datos = new DParametrizador();

        $result = $datos->insert_Consumo($nombre);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_Consumo($id, $nombre) {

        $datos = new DParametrizador();

        $result = $datos->update_Consumo($id, $nombre);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }
    
     //Entidades de pago
    public function get_Entidades() {

        $datos = new DParametrizador();

        $result = $datos->get_Entidades();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }
    
    public function insert_Entidades($nombre) {

        $datos = new DParametrizador();

        $result = $datos->insert_Entidades($nombre);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_Entidades($id, $nombre) {

        $datos = new DParametrizador();

        $result = $datos->update_Entidades($id, $nombre);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }
    
     //Medios de pago
    public function get_MedioPago() {

        $datos = new DParametrizador();

        $result = $datos->get_MedioPago();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }
    
    public function insert_MedioPago($nombre) {

        $datos = new DParametrizador();

        $result = $datos->insert_MedioPago($nombre);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_MedioPago($id, $nombre) {

        $datos = new DParametrizador();

        $result = $datos->update_MedioPago($id, $nombre);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }
    
      //Unidades
    public function get_Unidades() {

        $datos = new DParametrizador();

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
    
    public function insert_Unidades($nombre, $simbolo) {

        $datos = new DParametrizador();

        $result = $datos->insert_Unidades($nombre, $simbolo);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_Unidades($id, $nombre, $simbolo) {

        $datos = new DParametrizador();

        $result = $datos->update_Unidades($id, $nombre, $simbolo);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }
}
