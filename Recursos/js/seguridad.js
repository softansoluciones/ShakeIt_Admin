/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function verificacionI() {
    var login = sessionStorage.getItem("ses_estado");

    if (login != "ShakeItAdmin") {
      sessionStorage.clear();
        window.location = 'index';
    }else{
        $("body").show();
    }
}

function verificacionL() {
    var login = sessionStorage.getItem("ses_estado");

    if (login == "ShakeItAdmin") {
        window.location = 'principal';
    }else {
      sessionStorage.clear();
    }
}

function LogOut() {
   sessionStorage.clear();
   window.location = 'index';
}
