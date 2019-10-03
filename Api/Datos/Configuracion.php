<?php


class configurL {
    
  public static function getserver()
  {


    return 'localhost';


  }


  public static function getuser()
  {


    return 'root';


  }


  public static function getpass() {


    return 'root';


  }


  public static function getbd() {


    return 'shakeitdata_des';

  }


}

class configurR {


  public static function getserver() {

    return '190.8.176.227';

  }


  public static function getuser() {

    return 'shakei_userbd';

  }

  public static function getpass() {

    return 'Usuario01';

  }


  public static function getbd() {

    return 'shakei_shakeit_prod';

  }


}

class strConfiguration {
    
    public static function strconnectionLoc() {

        $server = '"localhost"';
        $user = '"root"';
        $pass = '"root"';
        $db = '"shakeitdata_des"';

        $str = $server . ', ' . $user . ', ' . $pass . ', ' . $db;

        return $str;
    }
    
    public static function strconnectionRem() {

        $server = '"190.8.176.71"';
        $user = '"shakei_userbd"';
        $pass = '"Usuario01"';
        $db = '"shakei_shakeit_prod"';

        $str = $server . ', ' . $user . ', ' . $pass . ', ' . $db;

        return $str;
    }

}