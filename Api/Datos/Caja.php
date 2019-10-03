<?php

include_once 'MetodosDatos.php';

class DCaja{

    public function get_Caja() {

        $sql = "CALL Caja_Get();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_CajaXId($id) {

        $sql = "call Caja_GetXId('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function get_CajaXSede($sede) {

        $sql = "call Caja_GeXSede('$sede');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_Caja($id, $val, $est, $sede) {

        $sql = "CALL Caja_Update('$id', '$val', '$est', '$sede');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_Caja($val, $est, $sede) {

        $sql = "CALL Caja_Add('$val', '$est', '$sede');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function delete_Caja($id) {

        $sql = "CALL Caja_Delete('$id');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }


}
