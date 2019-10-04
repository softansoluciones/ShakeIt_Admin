<?php

include_once 'MetodosDatos.php';

class DClientes {

    public function get_Clientes() {

        $sql = "CALL Clientes_Get();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_Cliente($id) {

        $sql = "call Clientes_GetXId('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }
    
    public function get_ClienteXTel($tel) {

        $sql = "call Clientes_GetXTel('$tel');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_Cliente($id, $nom, $ape, $dir, $barr, $mun, $tel, $us, $pass, $email, $nac) {

        $sql = "CALL Clientes_Update('$id', '$nom', '$ape', '$dir', '$barr', '$mun', '$tel', '$us', '$pass', '$email', '$nac');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }
    
    public function insert_Cliente($nom, $ape, $dir, $barr, $mun, $tel, $us, $pass, $email, $nac, $registro) {

        $fecha = date("Y-m-d H:i:s");
        $sql = "CALL Clientes_Add('$nom', '$ape', '$dir', '$barr', '$mun', '$tel', '$us', '$pass', '$email', '$nac', '$registro', '$fecha');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }


}
