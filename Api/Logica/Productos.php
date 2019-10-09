<?php

//include_once 'Datos/DUsuarios';
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Datos/Productos.php');

class Productos {

    public function get_Productos() {

        $datos = new DProductos();

        $rows = array();

        $result = $datos->get_Productos();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_nuevoid() {

        $datos = new DProductos();

        $result = $datos->get_nuevoid();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_Producto($id) {

        $datos = new DProductos();

        $result = $datos->get_Producto($id);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_ProductosXCat($id) {

        $datos = new DProductos();

        $result = $datos->get_ProductoXCat($id);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function delete_Producto($id) {

        $datos = new DProductos();

        $result = $datos->Delete_Producto($id);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function insert_Producto($id, $nom, $nomG, $prec, $cat, $desc, $img) {

        $datos = new DProductos();

        if ($img == 0) {
            $file = 0;
        } else {
            $file = $this->save_File($img, $cat, $id);
        }

        $result = $datos->insert_Producto($id, $nom, $nomG, $prec, $cat, $desc, $file);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_Producto($id, $nom, $nomG, $prec, $cat, $desc, $img) {

        $datos = new DProductos();

        if ($img == 0) {
            $file = 0;
        } else {
            $file = $this->save_File($img, $cat, $id);
        }

        $result = $datos->update_Producto($id, $nom, $nomG, $prec, $cat, $desc, $file);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function save_File($file, $cat, $id) {

        $info = pathinfo($file['name']);
        $ext = $info['extension']; // get the extension of the file
        $newname = date("Y") . "_" . date("m") . "_" . date("d") . "_" . $id . "_" . $cat . "." . $ext;

        $target = $_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/media/Productos/' . $newname;
        move_uploaded_file($file['tmp_name'], $target);
        return $newname;
    }

}
