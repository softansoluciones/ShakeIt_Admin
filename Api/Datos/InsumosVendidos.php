<?php

include_once 'MetodosDatos.php';

class DInsumosVendidos {

    public function get_RelacionXProd($id) {

        $sql = "call Relacion_GetXProd('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_InsumoVendido($ins, $cant, $sed) {

        $sql = "CALL InsumosV_Add('$ins', '$cant', '$sed', 1);";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }


}
