<?php

include_once 'MetodosDatos.php';

class DComunes {

    public function get_Insumos() {

        $sql = "CALL Insumos_GetSel();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_Sedes() {

        $sql = "CALL Sedes_GetSel();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_Anios() {

        $sql = "CALL Anios_GetSel();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_Meses() {

        $sql = "CALL meses_GetSel();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_Unidades() {

        $sql = "CALL Unidades_GetSel();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_Categorias() {

        $sql = "CALL Categorias_Get();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_UsuariosTipo() {

        $sql = "CALL UsuariosTipo_GetSel();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_Estados() {

        $sql = "CALL Estados_GetSel();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_Departamentos() {

        $sql = "CALL Departamentos_GetSel();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_Municipios($dep) {

        $sql = "CALL Municipios_GetSel('$dep');";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

    public function get_MunicipiosAll() {

        $sql = "CALL Municipios_GetAllSel();";
        $db = new dbmanager();

        return $db->executeQuery($sql);
    }

}
