<?php

include_once 'MetodosDatos.php';

class DReportes{

    public function get_Reportes() {

        $sql = "CALL Reportes_Get();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }
   
    public function update_Reporte($iden, $val, $sede) {

        $sql = "CALL Reportes_Update('$iden', '$val', '$sede');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_Reporte($iden, $val, $sede) {

        $sql = "CALL Reportes_Add('$iden', '$val', '$sede');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }
    

}
