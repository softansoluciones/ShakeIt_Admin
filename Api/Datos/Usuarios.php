<?php

include_once 'MetodosDatos.php';

class DUsuarios {

    public function get_Usuarios() {
        $sql = "call Usuarios_Get();";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function get_Usuario($iduser) {

        $sql = "call Usuarios_GetXId('$iduser');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function get_UsuarioXDoc($doc) {

        $sql = "call Usuarios_GetXDoc('$doc');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function get_UsuarioLogin($doc, $pass) {

        $sql = "call Usuarios_Login('$doc', '$pass');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_Usuario($doc, $nom, $ape, $tel, $email, $pass, $tipo, $estado) {

        $sql = "CALL Usuarios_Add('$doc', '$nom', '$ape', '$tel', '$email', '$pass', '$tipo', '$estado')";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_Usuario($id, $doc, $nom, $ape, $tel, $email, $pass, $tipo, $estado) {

        $sql = "CALL Usuarios_Update('$id', '$doc', '$nom', '$ape', '$tel', '$email', '$pass', '$tipo', '$estado')";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function delete_Usuario($id) {

        $sql = "CALL Usuarios_Delete('$id')";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

}
