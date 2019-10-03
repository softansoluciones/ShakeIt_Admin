<?php

//include_once 'Datos/DUsuarios';
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Datos/Inventario.php');

class Inventario {

    public function get_Inventario() {

        $datos = new DInventario();

        $rows = array();

        $result = $datos->get_Inventario();


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_InventarioXSede($id) {

        $datos = new DInventario();

        $rows = array();

        $result = $datos->get_InventarioXSede($id);


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_InventarioOne($id) {

        $datos = new DInventario();

        $result = $datos->get_InventarioOne($id);

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

     public function get_InventarioIden($id) {

        $datos = new DInventario();

        $rows = array();

        $result = $datos->get_InventarioIden($id);


        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                $rows[] = $row;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function get_InsumosXProd($id, $cant, $sede) {

        $datos = new DInventario();

        $result = $datos->get_RelacionXProd($id);
        $cont = 0;

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {

                $subresult = $this->update_RestarInventarioXProd($row["fk_insumo"], $row["insumoUnidad_rel"], $cant, $sede);
                if ($subresult == 0) {
                    $cont++;
                }
            }
            if ($cont > 0) {
                $rows = 0;
            } else {
                $rows = 1;
            }
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function delete_Inventario($id) {

        $datos = new DInventario();

        $result = $datos->Delete_Inventario($id);

        if ($result === TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function insert_Inventario($ins, $cant, $sed) {

        $datos = new DInventario();

        $result = $datos->insert_Inventario($ins, $cant, $sed);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function insert_InventarioMas($dat) {

        $datos = new DInventario();
        $dt = json_decode($dat);
        $cont = 0;

        foreach ($dt as $data) {
            $ins = $data->ins;
            $cant = $data->cant;
            $sed = $data->sede;

            $result = $datos->insert_Inventario($ins, $cant, $sed);
//print_r($result);
            if ($result == TRUE) {
                $cont = 0;
            } else {
                $cont++;
            }
        }

        if ($cont > 0) {
            $rows = 0;
        } else {
            $rows = 1;
        }
        return $rows;
    }

    public function insert_InventarioDia($ins, $cant, $iden) {

        $datos = new DInventario();

        $result = $datos->insert_InventarioDia($ins, $cant, $iden);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function insert_InventarioIden($iden, $est, $sed) {

        $datos = new DInventario();

        $result = $datos->insert_InventarioIden($iden, $est, $sed);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function Recorrer_Producto($dat) {

        $datos = new DInventario();
        $dt = json_decode($dat);
        $cont = 0;

        foreach ($dt as $data) {
            $pro = $data->pro;
            $cant = $data->cant;
            $sede = $data->sede;

            $result = $this->get_InsumosXProd($pro, $cant, $sede);

            if ($result == 1) {
                $cont = 0;
            } else {
                $cont++;
            }
        }
        if ($cont > 0) {
            $rows = 0;
        } else {
            $rows = 1;
        }
        return $rows;
    }

    public function update_Inventario($id, $ins, $cant, $sed) {

        $datos = new DInventario();

        $result = $datos->Update_Inventario($id, $ins, $cant, $sed);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function update_RestarInventarioXProd($ins, $cant, $cantp, $sed) {

        $datos = new DInventario();

        $result = $datos->update_RestarInventarioXProd($ins, $cant, $cantp, $sed);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }

        return $rows;
    }

}
