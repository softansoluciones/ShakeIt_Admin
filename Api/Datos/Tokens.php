<?php

include_once 'MetodosDatos.php';

class DTokens {

    public function get_Tokens($ip, $so, $browser, $user) {

        $fecha =  date("Y-m-d H:i:s");
        $sql = "call Tokens_Get('$ip', '$so', '$browser', '$user', '$fecha');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

    public function get_TokenEstado($token) {
        
        $fecha =  date("Y-m-d H:i:s");
        $sql = "call Tokens_GetEstado('$token', '$fecha');";
        $db = new dbmanager( );

        return $db->executeQuery($sql);
    }

}
