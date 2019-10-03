<?php

include_once 'MetodosDatos.php';

class DInventario {

    public function get_Inventario() {

        $sql = "CALL Inventario_Get();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_InventarioOne($id) {

        $sql = "call Inventario_GetXId('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function get_InventarioIden($id) {

        $sql = "call InventarioIden_GetXIden('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function get_InventarioXSede($id) {

        $sql = "call Inventario_GetXSede('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function Update_Inventario($id, $ins, $cant, $sed) {

        $sql = "CALL Inventario_Update('$id', '$ins', '$cant', '$sed');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_RestarInventarioXProd($ins, $cant, $cantp, $sed) {

        $sql = "CALL Inventario_RestarCant('$ins', '$cant', '$cantp', '$sed');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function get_RelacionXProd($id) {

        $sql = "call Relacion_GetXProd('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_Inventario($ins, $cant, $sed) {

        $sql = "CALL Inventario_Add('$ins', '$cant', '$sed');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function insert_InventarioDia($ins, $cant, $iden) {

        $sql = "CALL InventarioDia_Add('$ins', '$cant', '$iden');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function insert_InventarioIden($iden, $est, $sed) {

        $sql = "CALL InventarioIden_Add('$iden', '$est', '$sed');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function Delete_Inventario($id) {

        $sql = "call Inventario_Delete('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

}
