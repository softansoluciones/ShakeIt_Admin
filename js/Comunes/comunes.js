/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//Sedes
function Get_SedesSel(select) {

  var sedes = {
    "sedes": "sedes"
  };

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Comunes.php',
    data: sedes,
    dataType: 'json',
    success: function(response) {
      $(select).html("")
      $(select).html("<option value='' selected>Seleccione Sede</option>")
      if (response.Respuesta != 0) {
        $.each(response.Respuesta, function(i, item) {
          $(select).append('\
                  <option value="' + item.id + '">' + item.nom + '</option>\n\
                  ');
        });
      } else {
        $(select).append('\
                  <option value="">No existe información</option>\n\
                  ');
      }
    }
  });
}
// Años
function Get_AniosSel(select) {

  var sedes = {
    "anios": "anios"
  };

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Comunes.php',
    data: sedes,
    dataType: 'json',
    success: function(response) {
      $(select).html("")
      $(select).html("<option value='' selected>Seleccione Año</option>")
      if (response.Respuesta != 0) {
        $.each(response.Respuesta, function(i, item) {
          $(select).append('\
                  <option value="' + item.id + '">' + item.nom + '</option>\n\
                  ');
        });
      } else {
        $(select).append('\
                  <option value="">No existe información</option>\n\
                  ');
      }
    }
  });
}
//meses
function Get_MesesSel(select) {

  var sedes = {
    "meses": "meses"
  };

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Comunes.php',
    data: sedes,
    dataType: 'json',
    success: function(response) {
      $(select).html("")
      $(select).html("<option value='' selected>Seleccione Mes</option>")
      if (response.Respuesta != 0) {
        $.each(response.Respuesta, function(i, item) {
          $(select).append('\
                  <option value="' + item.id + '">' + item.nom + '</option>\n\
                  ');
        });
      } else {
        $(select).append('\
                  <option value="">No existe información</option>\n\
                  ');
      }
    }
  });
}
//insumos
function Get_InsumosSel(select) {

  var insumos = {
    "insumos": "insumos"
  };

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Comunes.php',
    data: insumos,
    dataType: 'json',
    success: function(response) {
      $(select).html("")
      $(select).html("<option value='' selected>Seleccione Insumo</option>")
      if (response.Respuesta != 0) {
        $.each(response.Respuesta, function(i, item) {
          $(select).append('\
                  <option value="' + item.id + '">' + item.nom + '</option>\n\
                  ');
        });
      } else {
        $(select).append('\
                  <option value="">No existe información</option>\n\
                  ');
      }
    }
  });
}
//insumos por id
function Get_InsiumoXId(select, input) {

  var id = $(select).val();

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Insumos.php/id/'+id,
    dataType: 'json',
    headers: {
      "authtoken": sessionStorage.getItem("token")
    },
    success: function(response) {
      if (response.Respuesta != 0) {
        $(input).val(response.Respuesta[0].nomSI_unidad);
      } else {
        $(input).val('');
      }
    }
  })
}
//unidades
function Get_UnidadesSel(select) {

  var unidades = {
    "unidades": "unidades"
  };

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Comunes.php',
    data: unidades,
    dataType: 'json',
    success: function(response) {
      $(select).html("")
      $(select).html("<option value='' selected>Seleccione Unidad</option>")
      if (response.Respuesta != 0) {
        $.each(response.Respuesta, function(i, item) {
          $(select).append('\
                  <option value="' + item.id + '">' + item.nom + '</option>\n\
                  ');
        });
      } else {
        $(select).append('\
                  <option value="">No existe información</option>\n\
                  ');
      }
    }
  });
}
//categorias
function Get_CategoriasSel(select) {

  var categorias = {
    "categorias": "categorias"
  };

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Comunes.php',
    data: categorias,
    dataType: 'json',
    success: function(response) {
      $(select).html("")
      $(select).html("<option value='' selected>Seleccione Categoría</option>")
      if (response.Respuesta != 0) {
        $.each(response.Respuesta, function(i, item) {
          $(select).append('\
                  <option value="' + item.id + '">' + item.nom + '</option>\n\
                  ');
        });
      } else {
        $(select).append('\
                  <option value="">No existe información</option>\n\
                  ');
      }
    }
  });
}
//tipo de usuario
function Get_UsuarioTipoSel(select) {

  var userltip = parseInt(sessionStorage.getItem("tipo_user"))
  var usuariotipo = {
    "usuariotipo": "usuariotipo"
  };

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Comunes.php',
    data: usuariotipo,
    dataType: 'json',
    success: function(response) {
      $(select).html("")
      $(select).html("<option value='' selected>Seleccione Tipo De Usuario</option>")
      if (response.Respuesta != 0) {
        if (userltip == 3) {
          $.each(response.Respuesta, function(i, item) {
            $(select).append('\
                  <option value="' + item.id + '">' + item.nom + '</option>\n\
                  ');
          });
        }
          if (userltip == 2) {
            $.each(response.Respuesta, function(i, item) {
              if (item.id != 3) {
                $(select).append('\
                    <option value="' + item.id + '">' + item.nom + '</option>\n\
                    ');
              }
            });
          }

          if (userltip == 4) {
            $.each(response.Respuesta, function(i, item) {
              if (item.id != 3 && item.id != 2) {
                $(select).append('\
                    <option value="' + item.id + '">' + item.nom + '</option>\n\
                    ');
              }
            });
          }

      } else {
        $(select).append('\
                  <option value="">No existe información</option>\n\
                  ');
      }
    }
  });
}
//estados generales
function Get_EstadosSel(select) {

  var estados = {
    "estados": "estados"
  };

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Comunes.php',
    data: estados,
    dataType: 'json',
    success: function(response) {
      $(select).html("")
      $(select).html("<option value='' selected>Seleccione Estado</option>")
      if (response.Respuesta != 0) {
        $.each(response.Respuesta, function(i, item) {
          if (item.id > 0 && item.id < 4) {
            $(select).append('\
                    <option value="' + item.id + '">' + item.nom + '</option>\n\
                    ');
          }
        });
      } else {
        $(select).append('\
                  <option value="">No existe información</option>\n\
                  ');
      }
    }
  });
}
//departamentos
function Get_DepartamentosSel(select) {

  var departamentos = {
    "departamentos": "departamentos"
  };

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Comunes.php',
    data: departamentos,
    dataType: 'json',
    success: function(response) {
      $(select).html("")
      $(select).html("<option value='' selected>Seleccione Departamento</option>")
      if (response.Respuesta != 0) {
        $.each(response.Respuesta, function(i, item) {
          $(select).append('\
                  <option value="' + item.id + '">' + item.nom + '</option>\n\
                  ');
        });
      } else {
        $(select).append('\
                  <option value="">No existe información</option>\n\
                  ');
      }
    }
  });
}
//municipios
function Get_MunicipiosSel(select, input) {

  var id = $(input).val();
  var dataserver = id + "| data"
  var dataserverb = window.btoa(dataserver);
  var municipios = {
    "municipios": dataserverb
  };

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Comunes.php',
    data: municipios,
    dataType: 'json',
    success: function(response) {
      $(select).html("")
      $(select).html("<option value='' selected>Seleccione Munnicipio</option>")
      if (response.Respuesta != 0) {
        $.each(response.Respuesta, function(i, item) {
          $(select).append('\
                  <option value="' + item.id + '">' + item.nom + '</option>\n\
                  ');
        });
      } else {
        $(select).append('\
                  <option value="">No existe información</option>\n\
                  ');
      }
    }
  });
}
//todos los municipios
function Get_MunicipiosSelAll(select) {

  var municipios = {
    "municipiostodos": "municipiostodos"
  };

  $.ajax({
    type: 'GET',
    url: 'Api/v1/Comunes.php',
    data: municipios,
    dataType: 'json',
    success: function(response) {
      $(select).html("")
      $(select).html("<option value='' selected>Seleccione Departamento</option>")
      if (response.Respuesta != 0) {
        $.each(response.Respuesta, function(i, item) {
          $(select).append('\
                  <option value="' + item.id + '">' + item.nom + '</option>\n\
                  ');
        });
      } else {
        $(select).append('\
                  <option value="">No existe información</option>\n\
                  ');
      }
    }
  });
}
