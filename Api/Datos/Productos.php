<?php

include_once 'MetodosDatos.php';

class DProductos {

    public function get_Productos() {

        $sql = "CALL Productos_Get();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_nuevoid() {

        $sql = "call Productos_GetNuevoId();";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function get_Producto($id) {

        $sql = "call Productos_GetXId('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function get_ProductoXCat($id) {

        $sql = "CALL Productos_GetXCategoria('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_Producto($id, $nom, $nomG, $prec, $cat, $desc) {

        $sql = "CALL Productos_Update('$id', '$nom', '$nomG', '$prec', '$cat', '$desc');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_Producto($id, $nom, $nomG, $prec, $cat, $desc) {

        $sql = "CALL Productos_Add('$id', '$nom', '$nomG', '$prec', '$cat', '$desc');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function Delete_Producto($id) {

        $sql = "call Productos_Delete('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

}
