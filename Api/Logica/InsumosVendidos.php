<?php

//include_once 'Datos/DUsuarios';
include_once($_SERVER['DOCUMENT_ROOT'] . '/ShakeIt_Admin/Api/Datos/InsumosVendidos.php');

class InsumosVendidos {

    public function get_InsumosXProd($id, $sede) {

        $datos = new DInsumosVendidos();

        $result = $datos->get_RelacionXProd($id);
        $cont = 0;

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {

                $subresult = $this->insert_InsummoVendido($row["fk_insumo"], $row["insumoUnidad_rel"], $sede);
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

    public function insert_InsummoVendido($ins, $cant, $sed) {

        $datos = new DInsumosVendidos();

        $result = $datos->insert_InsumoVendido($ins, $cant, $sed);

        if ($result == TRUE) {
            $rows = 1;
        } else {
            $rows = 0;
        }
        return $rows;
    }

    public function Recorrer_Producto($dat) {

        $datos = new DInsumosVendidos();
        $dt = json_decode($dat);
        $cont = 0;

        foreach ($dt as $data) {
            $pro = $data->pro;
            $sede = $data->sede;

            $result = $this->get_InsumosXProd($pro, $sede);

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


}
