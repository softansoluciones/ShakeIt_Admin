<?php

include_once 'MetodosDatos.php';

class DSedes {

    public function get_Sedes() {

        $sql = "CALL Sedes_Get();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_Sede($id) {

        $sql = "call Sedes_GetXId('$id');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_SedeXNom($nom) {

        $sql = "call Sedes_GetXNom('$nom');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_Sede($id, $nit, $nom, $dir, $mun, $tel1, $tel2, $tel3, $long, $lat) {

        $sql = "CALL Sedes_Update('$id', '$nit', '$nom', '$dir', '$mun', '$tel1', '$tel2', '$tel3', '$long', '$lat');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_Sede($nit, $nom, $dir, $mun, $tel1, $tel2, $tel3, $long, $lat) {

        $sql = "CALL Sedes_Add('$nit', '$nom', '$dir', '$mun', '$tel1', '$tel2', '$tel3', '$long', '$lat');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function Delete_Sede($id) {

        $sql = "call Sedes_Delete('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

}
