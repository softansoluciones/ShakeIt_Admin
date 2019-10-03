<?php

include_once 'MetodosDatos.php';

class DClientes {

    public function get_Clientes() {

        $sql = "CALL Cliente_Get();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_Cliente($id) {

        $sql = "call Cliente_GetXId('$id');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }
    
    public function get_ClienteXDoc($doc) {

        $sql = "call Cliente_GetXDoc('$doc');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }
    
    public function get_ClienteXTel($tel) {

        $sql = "call Cliente_GetXTel('$tel');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_Cliente($id, $doc, $nom, $ape, $dir, $barr, $mun, $tel, $us, $pass, $email, $nac) {

        $sql = "CALL Cliente_Update('$id', '$doc', '$nom', '$ape', '$dir', $barr, '$mun', '$tel', '$us', '$pass', '$email', '$nac');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }
    
    public function update_ClienteLocal($id, $doc, $nom, $ape, $dir, $barr, $mun, $tel, $email, $nac) {

        $sql = "CALL Cliente_UpdateLocal('$id', '$doc', '$nom', '$ape', '$dir', $barr, '$mun', '$tel', '$email', '$nac');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }
    
    public function update_ClienteVenta($id, $nom, $ape, $dir, $barr, $mun, $tel) {

        $sql = "CALL Cliente_UpdateVenta('$id', '$nom', '$ape', '$dir', $barr, '$mun', '$tel');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_Cliente($doc, $nom, $ape, $dir, $barr, $mun, $tel, $us, $pass, $email, $nac) {

        $sql = "CALL Cliente_Add('$doc', '$nom', '$ape', '$dir', $barr, '$mun', '$tel', '$us', '$pass', '$email', '$nac');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }
    
    public function insert_ClienteVenta($nom, $ape, $dir, $barr, $mun, $tel) {

        $sql = "CALL Cliente_AddVenta('$nom', '$ape', '$dir', $barr, '$mun', '$tel');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }
    
    public function insert_ClienteLocal($doc, $nom, $ape, $dir, $barr, $mun, $tel, $email, $nac) {

        $sql = "CALL Cliente_AddLocal('$doc', '$nom', '$ape', '$dir', $barr, '$mun', '$tel', '$email', '$nac');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }


}
