<?php

include_once 'MetodosDatos.php';

class DParametrizador {

    public function get_Parametrizador() {
        $sql = "call Parametrizador_Get();";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

//-------------------Categorias------------------------------------------------------------//

    public function get_Categorias() {

        $sql = "call Categorias_Get();";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function get_CategoriasPrincipales() {

        $sql = "call Categorias_GetPrincipales();";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function get_CategoriasScundarias() {

        $sql = "call Categorias_GetSecundarias();";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_Categoria($nombre, $tipo) {

        $sql = "CALL Categorias_Add('$nombre', '$tipo')";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_Categoria($id, $nombre, $tipo) {

        $sql = "CALL Categorias_Update('$id', '$nombre', '$tipo')";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }
    
//-------------------Consumo------------------------------------------------------------//

    public function get_Consumo() {

        $sql = "call Consumo_GetSel();";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_Consumo($nombre) {

        $sql = "CALL Consumo_Add('$nombre')";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_Consumo($id, $nombre) {

        $sql = "CALL Consumo_Update('$id', '$nombre')";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }
    
//-------------------Entidades de pago------------------------------------------------------------//

    public function get_Entidades() {

        $sql = "call Entidades_GetSel();";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_Entidades($nombre) {

        $sql = "CALL Entidades_Add('$nombre')";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_Entidades($id, $nombre) {

        $sql = "CALL Entidades_Update('$id', '$nombre')";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }
    
//-------------------Medios de pago------------------------------------------------------------//

    public function get_MedioPago() {

        $sql = "call MedioPago_Get();";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_MedioPago($nombre) {

        $sql = "CALL MedioPago_Add('$nombre')";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_MedioPago($id, $nombre) {

        $sql = "CALL MedioPago_Update('$id', '$nombre')";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }
    
//-------------------Unidades------------------------------------------------------------//

    public function get_Unidades() {

        $sql = "call Unidades_Get();";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function insert_Unidades($nombre, $simbolo) {

        $sql = "CALL Unidades_Add('$nombre', '$simbolo')";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function update_Unidades($id, $nombre, $simbolo) {

        $sql = "CALL Unidades_Update('$id', '$nombre', '$simbolo')";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

}
