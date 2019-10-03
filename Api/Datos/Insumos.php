<?php

include_once 'MetodosDatos.php';

class DInsumos {

    public function get_Insumos() {

        $sql = "CALL Insumos_Get();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_Insumo($id) {

        $sql = "call Insumos_GetXId('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

     public function get_InsumosXNom($nom) {

        $sql = "call Insumos_GetXNom('$nom');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_Insumo($id, $nom, $uni, $cmin) {

        $sql = "CALL Insumos_Update('$id', '$nom', '$uni', '$cmin');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_Insumo($nom, $uni, $cmin) {

        $sql = "CALL Insumos_Add('$nom', '$uni', '$cmin');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function Delete_Insumo($id) {

        $sql = "call Insumos_Delete('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

}
