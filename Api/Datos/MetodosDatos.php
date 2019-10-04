<?php



date_default_timezone_set('America/Bogota');


include_once 'Configuracion.php';



class dbmanager {



  public function executeQuery($sql) {


    $con = mysqli_connect(configurL::getserver(), configurL::getuser(), configurL::getpass(), configurL::getbd());


    $acentos = $con->query("SET NAMES 'utf8'");


    if (!$acentos) {


      die('No Se Pudo Conectar: ' . mysqli_connect_error());


    }


    $result = $con->query($sql);




    mysqli_close($con);


    return $result;


  }




}


