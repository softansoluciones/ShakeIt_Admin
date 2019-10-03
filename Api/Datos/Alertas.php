<?php

include_once 'MetodosDatos.php';

class DAlertas {

    public function get_AlertasCant($us) {

        $sql = "CALL Alertas_GetCantXUsuario('$us');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_Alertas($us) {

        $sql = "CALL Alertas_GetXUsuario('$us');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_Alerta($id) {

        $sql = "call Alertas_GetXId('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_Alertas($id) {

        $sql = "CALL Alertas_Update('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_Alertas($nom, $des, $us) {

        $sql = "CALL Alertas_Add('$nom', '$des', '$us');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

}
