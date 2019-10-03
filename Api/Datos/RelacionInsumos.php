<?php

include_once 'MetodosDatos.php';

class DRelInsumos {

    public function get_Relaciones() {

        $sql = "CALL Relacion_Get();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_RelacionXPro($id) {

        $sql = "call Relacion_GetXProd('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_Relacion($pro, $ins, $cant) {

        $sql = "CALL Relacion_Update('$pro', '$ins', '$cant');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_Relacion($pro, $ins, $cant) {

        $sql = "CALL Relacion_Add('$pro', '$ins', '$cant');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function Delete_Relacion($pro, $ins) {

        $sql = "call Relacion_Delete('$pro', '$ins');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

}
