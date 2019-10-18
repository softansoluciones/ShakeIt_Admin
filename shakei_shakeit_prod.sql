-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-10-2019 a las 18:37:31
-- Versión del servidor: 8.0.15
-- Versión de PHP: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sdes`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`admin`@`localhost` PROCEDURE `Alertas_Add` (IN `nom` VARCHAR(100), IN `des` VARCHAR(100), IN `us` INT)  BEGIN
if  us = 0 then
INSERT INTO `alertas`
(`nom_alerta`,
`desc_alerta`,
`fk_estado`,
`fk_usuario`)
values
(nom,
des,
'1',
0);
else
INSERT INTO `alertas`
(`nom_alerta`,
`desc_alerta`,
`fk_estado`,
`fk_usuario`,
fecha_alerta)
select
nom,
des,
'1',
usuarios.id_usuario,
now()
from
usuarios
where
usuarios.tipo_usuario = us;
end if;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Alertas_GetCantXUsuario` (IN `us` INT)  BEGIN
Select
count(id_alerta) as alertas_cantidad
from
alertas
where
(fk_usuario = us or fk_usuario = us)
and
fk_estado = 1;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Alertas_GetXId` (IN `id` INT)  BEGIN
Select
alertas.id_alerta,
alertas.nom_alerta,
alertas.desc_alerta,
alertas.fk_estado,
alertas.fk_usuario,
alertas.fecha_alerta
from
alertas
where
alertas.id_alerta=id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Alertas_GetXUsuario` (IN `us` INT)  BEGIN
Select
alertas.id_alerta,
alertas.nom_alerta,
alertas.desc_alerta,
alertas.fk_estado,
alertas.fk_usuario
from
alertas
where
(fk_usuario = us or fk_usuario = us)
order by id_alerta desc
limit 15;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Alertas_Update` (IN `id` INT)  BEGIN
UPDATE alertas
SET
alertas.fk_estado = 0
WHERE alertas.id_alerta = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Anios_GetSel` ()  BEGIN
select distinct
year(productos_vendidos.fecha_vendido) as id,
year(productos_vendidos.fecha_vendido) as nom
from
productos_vendidos
order by id asc;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Caja_Add` (IN `val` DOUBLE, IN `estado` INT, IN `sede` INT)  BEGIN
declare sid int;
declare scont int;
declare nsede varchar(100);
select
sedes.nom_sede
into
nsede
from
sedes
where
sedes.id_sede = sede;
select
count(caja.sede_caja),
ifnull(caja.id_caja, 0)
into
scont,
sid
from caja
where caja.sede_caja = sede;
if scont > 0 then
CALL Caja_Update(sid, val, estado, sede);
else
INSERT INTO `caja`
(
`valor_caja`,
`estado_caja`,
`sede_caja`
)
VALUES
(
val,
estado,
sede
);
end if;
if estado = 4 then
call Alertas_Add('Movimiento de caja', concat('se ha abierto caja de ', nsede, ' con dinero en caja de ', val), 2);
call Alertas_Add('Movimiento de caja', concat('se ha abierto caja de ', nsede, ' con dinero en caja de ', val), 3);
else
call Alertas_Add('Movimiento de caja', concat('se ha cerrado caja de ', nsede, ' con dinero en caja de ', val), 2);
call Alertas_Add('Movimiento de caja', concat('se ha cerrado caja de ', nsede, ' con dinero en caja de ', val), 3);
end if;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Caja_Delete` (IN `id` INT)  BEGIN
DELETE FROM `caja`
WHERE caja.id_caja = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Caja_Get` ()  BEGIN
SELECT caja.id_caja,
    caja.valor_caja,
    caja.estado_caja,
    estados_generales.nom_estado,
    caja.sede_caja
FROM `caja`
inner join estados_generales on estados_generales.idestado = caja.estado_caja;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Caja_GetXId` (IN `id` INT)  BEGIN
SELECT caja.id_caja,
    caja.valor_caja,
    caja.estado_caja,
    caja.sede_caja
FROM `caja`
inner join estados_generales on estados_generales.idestado = caja.estado_caja
where caja.id_caja = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Caja_GetXSede` (IN `sede` INT)  BEGIN
SELECT caja.id_caja,
    caja.valor_caja,
    caja.estado_caja,
    caja.sede_caja
FROM `caja`
inner join estados_generales on estados_generales.idestado = caja.estado_caja
where caja.sede_caja = sede;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Caja_GeXSede` (IN `sed` INT)  BEGIN
SELECT caja.id_caja,
    caja.valor_caja,
    caja.estado_caja,
    estados_generales.nom_estado,
    caja.sede_caja,
    sedes.nom_sede
FROM `caja`
inner join estados_generales on estados_generales.idestado = caja.estado_caja
inner join sedes on sedes.id_sede = caja.sede_caja
where caja.sede_caja = sed;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Caja_Update` (IN `id` INT, IN `val` DOUBLE, IN `estado` INT, IN `sede` INT)  BEGIN
UPDATE `caja`
SET
`valor_caja` = val,
`estado_caja` = estado
WHERE `id_caja` = id AND `sede_caja` = sede;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Categorias_Add` (IN `NOMBRE` VARCHAR(100), IN `TIPO` INT)  BEGIN

INSERT INTO categorias
(nomcategoria,
tipcategoria)
VALUES
(
NOMBRE,
TIPO);

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Categorias_Get` ()  BEGIN
select
categorias.idcategoria as id,
categorias.nomcategoria as nom
from categorias;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Categorias_GetPrincipales` ()  BEGIN
select
categorias.idcategoria,
categorias.nomcategoria
from categorias
where
categorias.tipcategoria = 1;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Categorias_GetSecundarias` ()  BEGIN
select
categorias.idcategoria,
categorias.nomcategoria
from categorias
where
categorias.tipcategoria != 1;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Categorias_Update` (IN `ID` INT, IN `NOMBRE` VARCHAR(100), IN `TIPO` INT)  BEGIN

UPDATE categorias
SET
nomcategoria = NOMBRE,
tipcategoria = TIPO
WHERE idcategoria = ID;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Clientes_Add` (IN `nom` VARCHAR(100), IN `ape` VARCHAR(100), IN `dir` VARCHAR(100), IN `barr` VARCHAR(100), IN `mun` INT, IN `tel` DOUBLE, IN `us` VARCHAR(100), IN `pass` VARCHAR(1000), IN `email` VARCHAR(1000), IN `nac` DATETIME, IN `registro` VARCHAR(50), IN `fecha` DATETIME)  BEGIN

declare scont int;
declare idus int;

select
count(clientes.id_cliente),
ifnull(clientes.id_cliente, 0)
into
scont,
idus
from clientes
where clientes.tel_cliente = tel or clientes.email_cliente = email
limit 1;

if scont > 0 then

CALL Clientes_Update(idus, nom, ape, dir, barr, mun, tel, us, pass, email, nac);

else

INSERT INTO `clientes`
(
`nom_cliente`,
`ape_cliente`,
`dir_cliente`,
`barrio_cliente`,
`fk_municipio`,
`tel_cliente`,
`us_cliente`,
`pass_cliente`,
`email_cliente`,
`nac_cliente`,
`registro_cliente`,
`fecha_registro`
)
VALUES
(
nom,
ape,
dir,
barr,
mun,
tel,
us,
pass,
email,
nac,
registro,
fecha
);
end if;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Clientes_Get` ()  BEGIN
SELECT 
`clientes`.`id_cliente`,
     clientes.`nom_cliente` as nombres_cliente,
    `clientes`.`ape_cliente` as apellidos_cliente,
    `clientes`.`dir_cliente` as direccion_cliente,
    `clientes`.`barrio_cliente`,
    `clientes`.`fk_municipio` as id_municipio_cliente,
    municipios.nom_municipio as municipio_cliente,
    departamentos.nom_departamento as departamento_cliente,
    `clientes`.`tel_cliente` as telefono_cliente,
    `clientes`.`us_cliente` as usuario_cliente,
    `clientes`.`pass_cliente` as password_cliente,
    `clientes`.`email_cliente`,
    `clientes`.`nac_cliente` as fecha_nacimiento,
    `clientes`.`registro_cliente`,
    `clientes`.`fecha_registro`
FROM `clientes`
left join municipios on municipios.id_municipio = clientes.fk_municipio
left join departamentos on departamentos.id_departamento = municipios.fk_departamento;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Clientes_GetXId` (IN `id` INT)  BEGIN
SELECT `clientes`.`id_cliente`,
     clientes.`nom_cliente` as nombres_cliente,
    `clientes`.`ape_cliente` as apellidos_cliente,
    `clientes`.`dir_cliente` as direccion_cliente,
    `clientes`.`barrio_cliente`,
    `clientes`.`fk_municipio` as municipio_cliente,
    `clientes`.`tel_cliente` as telefono_cliente,
    `clientes`.`us_cliente` as usuario_cliente,
    `clientes`.`pass_cliente` as password_cliente,
    `clientes`.`email_cliente`,
    `clientes`.`nac_cliente` as fecha_nacimiento,
    `clientes`.`registro_cliente`,
    `clientes`.`fecha_registro`
FROM `clientes`
WHERE clientes.id_cliente = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Clientes_GetXTel` (IN `tel` DOUBLE)  BEGIN
SELECT `clientes`.`id_cliente`,
   `clientes`.`nom_cliente` as nombres_cliente,
    `clientes`.`ape_cliente` as apellidos_cliente,
    `clientes`.`dir_cliente` as direccion_cliente,
    `clientes`.`barrio_cliente`,
    `clientes`.`fk_municipio` as municipio_cliente,
    `clientes`.`tel_cliente` as telefono_cliente,
    `clientes`.`us_cliente` as usuario_cliente,
    `clientes`.`pass_cliente` as password_cliente,
    `clientes`.`email_cliente`,
    `clientes`.`nac_cliente` as fecha_nacimiento,
    `clientes`.`registro_cliente`,
    `clientes`.`fecha_registro`
FROM `clientes`
WHERE clientes.doc_cliente like concat('"%', tel, '%"');
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Clientes_Update` (IN `id` INT, IN `nom` VARCHAR(100), IN `ape` VARCHAR(100), IN `dir` VARCHAR(100), IN `barr` VARCHAR(100), IN `mun` INT, IN `tel` DOUBLE, IN `us` VARCHAR(45), IN `pass` VARCHAR(1000), IN `email` VARCHAR(1000), IN `nac` DATETIME)  BEGIN
UPDATE `clientes`
SET
`nom_cliente` = nom,
`ape_cliente` = ape,
`dir_cliente` = dir,
`barrio_cliente` = barr,
`fk_municipio` = mun,
`tel_cliente` = tel,
`us_cliente` = us,
`pass_cliente` = pass,
`email_cliente` = email,
`nac_cliente` = nac
WHERE `id_cliente` = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `CmsArchivos_Add` (IN `PATH_` VARCHAR(1000), IN `POSICION` INT, IN `IDENCONTENIDO` VARCHAR(100))  BEGIN

INSERT INTO cms_archivos
(path_archivo,
posicion_archivo,
fk_idencontenido)
VALUES
(PATH_,
POSICION,
IDENCONTENIDO);

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `CmsArchivos_Delete` (IN `ID` INT)  BEGIN

DELETE FROM cms_archivos
WHERE
cms_archivos.id_archivo = ID;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `CmsArchivos_Get` ()  BEGIN

SELECT cms_archivos.id_archivo,
    cms_archivos.path_archivo,
    cms_archivos.posicion_archivo,
    cms_archivos.fk_idencontenido,
    cms_contenido.titulo_cms,
    cms_contenido.fk_estado,
    cat_estados.nom_estado
FROM cms_archivos
INNER JOIN cms_contenido ON cms_contenido.iden_cms = cms_archivos.fk_idencontenido
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
ORDER BY cms_archivos.id_archivo ASC;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `CmsArchivos_GetXContenido` (IN `ID` INT)  BEGIN

SELECT cms_archivos.id_archivo,
    cms_archivos.path_archivo,
    cms_archivos.posicion_archivo,
    cms_archivos.fk_idencontenido,
    cms_contenido.titulo_cms,
    cms_contenido.fk_estado,
    cat_estados.nom_estado
FROM cms_archivos
INNER JOIN cms_contenido ON cms_contenido.iden_cms = cms_archivos.fk_idencontenido
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
WHERE cms_contenido.id_cms = ID
ORDER BY cms_archivos.id_archivo ASC;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `CmsArchivos_GetXId` (IN `ID` INT)  BEGIN

SELECT cms_archivos.id_archivo,
    cms_archivos.path_archivo,
    cms_archivos.posicion_archivo,
    cms_archivos.fk_idencontenido,
    cms_contenido.titulo_cms,
    cms_contenido.fk_estado,
    cat_estados.nom_estado
FROM cms_archivos
INNER JOIN cms_contenido ON cms_contenido.iden_cms = cms_archivos.fk_idencontenido
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
WHERE cms_archivos.id_archivo = ID
ORDER BY cms_archivos.id_archivo ASC;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `CmsCategorias_Get` ()  BEGIN

SELECT cms_categorias.id_categoria as id,
    cms_categorias.nom_categoria as nom
FROM cms_categorias;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `CmsSecciones_Add` (IN `NOMBRE` VARCHAR(100))  BEGIN

INSERT INTO cms_seccion
(nom_seccion)
VALUES
(NOMBRE);

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `CmsSecciones_Delete` (IN `ID` INT)  BEGIN

DELETE FROM cms_seccion
WHERE cms_seccion.id_seccion = ID;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `CmsSecciones_GetSel` ()  BEGIN

SELECT cms_seccion.id_seccionas id,
    cms_seccion.nom_seccion as nom
FROM cms_seccion;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_Add` (IN `TITULO` VARCHAR(200), IN `CONTENIDO` VARCHAR(5600), IN `INFOADICIONAL` VARCHAR(1000), IN `INFOEXTRA` VARCHAR(1000), IN `PATH` VARCHAR(100), IN `FECHA` DATETIME, IN `TCONTENIDO` INT, IN `SECCION` INT, IN `JERARQUIA` INT, IN `ESTADO` INT, IN `AMBIENTE` INT, IN `CATEGORIA` INT)  BEGIN

declare ident int;

INSERT INTO cms_contenido
(titulo_cms,
contenido_cms,
infoadcional_cms,
infoextra_cms,
path_cms,
fecha_cms,
fk_tipocontenido,
fk_seccion,
jerarquia_cms,
fk_estado,
fk_ambiente,
fk_categoria,
iden_cms)
VALUES
(TITULO,
CONTENIDO,
INFOADICIONAL,
INFOEXTRA,
PATH,
FECHA,
TCONTENIDO,
SECCION,
JERARQUIA, 
ESTADO,
AMBIENTE,
CATEGORIA,
uuid());

select
count(iden_cms)
into
ident
from
cms_contenido
where titulo_cms = TITULO
and fecha_cms = FECHA
and fk_tipocontenido = TCONTENIDO
and fk_categoria = CATEGORIA;

if ident > 0 then
select
iden_cms
from
cms_contenido
where titulo_cms = TITULO
and fecha_cms = FECHA
and fk_tipocontenido = TCONTENIDO
and fk_categoria = CATEGORIA;
end if;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_Delete` (IN `ID` INT)  BEGIN

DELETE FROM cms_contenido
WHERE id_cms = ID;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_Get` ()  BEGIN

SELECT
cms_contenido.id_cms,
cms_contenido.titulo_cms,
cms_contenido.contenido_cms,
cms_contenido.infoadcional_cms,
cms_contenido.infoextra_cms,
cms_contenido.path_cms,
date(cms_contenido.fecha_cms) as fecha_cms,
cms_contenido.fk_tipocontenido,
cms_tipoconenido.nom_tipoconenido,
cms_contenido.fk_seccion,
cms_seccion.nom_seccion,
cms_contenido.jerarquia_cms,
cms_contenido.fk_estado,
cat_estados.nom_estado,
cms_contenido.fk_ambiente,
cms_ambientes.nom_ambiente,
cms_contenido.fk_categoria,
cms_categorias.nom_categoria
FROM
cms_contenido
INNER JOIN cms_tipoconenido ON cms_tipoconenido.id_tipoconenido = cms_contenido.fk_tipocontenido
INNER JOIN cms_seccion ON cms_seccion.id_seccion = cms_contenido.fk_seccion
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
INNER JOIN cms_ambientes on cms_ambientes.id_ambiente = cms_contenido.fk_ambiente
INNER JOIN cms_categorias ON cms_categorias.id_categoria = cms_contenido.fk_categoria;


END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_GetXCategoria` (IN `CATEGORIA` INT)  BEGIN

SELECT
cms_contenido.id_cms,
cms_contenido.titulo_cms,
cms_contenido.contenido_cms,
cms_contenido.infoadcional_cms,
cms_contenido.infoextra_cms,
cms_contenido.path_cms,
cms_contenido.fecha_cms,
cms_contenido.fk_tipocontenido,
cms_tipoconenido.nom_tipoconenido,
cms_contenido.fk_seccion,
cms_seccion.nom_seccion,
cms_contenido.jerarquia_cms,
cms_contenido.fk_estado,
cat_estados.nom_estado,
cms_contenido.fk_ambiente,
cms_ambientes.nom_ambiente,
cms_contenido.fk_categoria,
cms_categorias.nom_categoria
FROM
cms_contenido
INNER JOIN cms_tipoconenido ON cms_tipoconenido.id_tipoconenido = cms_contenido.fk_tipocontenido
INNER JOIN cms_seccion ON cms_seccion.id_seccion = cms_contenido.fk_seccion
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
INNER JOIN cms_ambientes on cms_ambientes.id_ambiente = cms_contenido.fk_ambiente
INNER JOIN cms_categorias ON cms_categorias.id_categoria = cms_contenido.fk_categoria
WHERE cms_contenido.fk_categoria = CATEGORIA;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_GetXId` (IN `ID` INT)  BEGIN

SELECT
cms_contenido.id_cms,
cms_contenido.titulo_cms,
cms_contenido.contenido_cms,
cms_contenido.infoadcional_cms,
cms_contenido.infoextra_cms,
cms_contenido.path_cms,
cms_contenido.fecha_cms,
cms_contenido.fk_tipocontenido,
cms_tipoconenido.nom_tipoconenido,
cms_contenido.fk_seccion,
cms_seccion.nom_seccion,
cms_contenido.jerarquia_cms,
cms_contenido.fk_estado,
cat_estados.nom_estado,
cms_contenido.fk_ambiente,
cms_ambientes.nom_ambiente,
cms_contenido.fk_categoria,
cms_categorias.nom_categoria
FROM
cms_contenido
INNER JOIN cms_tipoconenido ON cms_tipoconenido.id_tipoconenido = cms_contenido.fk_tipocontenido
INNER JOIN cms_seccion ON cms_seccion.id_seccion = cms_contenido.fk_seccion
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
INNER JOIN cms_ambientes on cms_ambientes.id_ambiente = cms_contenido.fk_ambiente
INNER JOIN cms_categorias ON cms_categorias.id_categoria = cms_contenido.fk_categoria
WHERE cms_contenido.id_cms = ID;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_GetXSeccion` (IN `SECCION` INT)  BEGIN

SELECT
cms_contenido.id_cms,
cms_contenido.titulo_cms,
cms_contenido.contenido_cms,
cms_contenido.infoadcional_cms,
cms_contenido.infoextra_cms,
cms_contenido.path_cms,
cms_contenido.fecha_cms,
cms_contenido.fk_tipocontenido,
cms_tipoconenido.nom_tipoconenido,
cms_contenido.fk_seccion,
cms_seccion.nom_seccion,
cms_contenido.jerarquia_cms,
cms_contenido.fk_estado,
cat_estados.nom_estado,
cms_contenido.fk_ambiente,
cms_ambientes.nom_ambiente,
cms_contenido.fk_categoria,
cms_categorias.nom_categoria
FROM
cms_contenido
INNER JOIN cms_tipoconenido ON cms_tipoconenido.id_tipoconenido = cms_contenido.fk_tipocontenido
INNER JOIN cms_seccion ON cms_seccion.id_seccion = cms_contenido.fk_seccion
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
INNER JOIN cms_ambientes on cms_ambientes.id_ambiente = cms_contenido.fk_ambiente
INNER JOIN cms_categorias ON cms_categorias.id_categoria = cms_contenido.fk_categoria
WHERE cms_contenido.fk_seccion = SECCION;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_GetXTContenido` (IN `TCONTENIDO` INT)  BEGIN

SELECT
cms_contenido.id_cms,
cms_contenido.titulo_cms,
cms_contenido.contenido_cms,
cms_contenido.infoadcional_cms,
cms_contenido.infoextra_cms,
cms_contenido.path_cms,
cms_contenido.fecha_cms,
cms_contenido.fk_tipocontenido,
cms_tipoconenido.nom_tipoconenido,
cms_contenido.fk_seccion,
cms_seccion.nom_seccion,
cms_contenido.jerarquia_cms,
cms_contenido.fk_estado,
cat_estados.nom_estado,
cms_contenido.fk_ambiente,
cms_ambientes.nom_ambiente,
cms_contenido.fk_categoria,
cms_categorias.nom_categoria
FROM
cms_contenido
INNER JOIN cms_tipoconenido ON cms_tipoconenido.id_tipoconenido = cms_contenido.fk_tipocontenido
INNER JOIN cms_seccion ON cms_seccion.id_seccion = cms_contenido.fk_seccion
INNER JOIN cat_estados ON cat_estados.id_estado = cms_contenido.fk_estado
INNER JOIN cms_ambientes on cms_ambientes.id_ambiente = cms_contenido.fk_ambiente
INNER JOIN cms_categorias ON cms_categorias.id_categoria = cms_contenido.fk_categoria
WHERE cms_contenido.fk_tipocontenido = TCONTENIDO;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Cms_Update` (IN `ID` INT, IN `TITULO` VARCHAR(100), IN `CONTENIDO` VARCHAR(1000), IN `INFOADICIONAL` VARCHAR(1000), IN `INFOEXTRA` VARCHAR(1000), IN `PATH` VARCHAR(1000), IN `FECHA` DATETIME, IN `TCONTENIDO` INT, IN `SECCION` INT, IN `JERARQUIA` INT, IN `ESTADO` INT, IN `AMBIENTE` INT, IN `CATEGORIA` INT)  BEGIN

UPDATE cms_contenido
SET
titulo_cms = TITULO,
contenido_cms = CONTENIDO,
infoadcional_cms = INFOADICIONAL,
infoextra_cms = INFOEXTRA,
path_cms = PATH,
fecha_cms = FECHA,
fk_tipocontenido = TCONTENIDO,
fk_seccion = SECCION,
jerarquia_cms = JERARQUIA,
fk_estado = ESTADO,
fk_ambiente = AMBIENTE,
fk_categoria = CATEGORIA
WHERE id_cms = ID;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Consumo_Add` (IN `NOMBRE` VARCHAR(100))  BEGIN

INSERT INTO consumo
(nom_consumo)
VALUES
(NOMBRE);

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Consumo_GetSel` ()  BEGIN
SELECT
consumo.id_consumo as id,
consumo.nom_consumo as nom
FROM consumo;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Consumo_Update` (IN `ID` INT, IN `NOMBRE` VARCHAR(100))  BEGIN

UPDATE consumo
SET
nom_consumo = NOMBRE
WHERE id_consumo = ID;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Contacto_Add` (IN `NOMBRE` VARCHAR(100), IN `EMAIL` VARCHAR(100), IN `MENSAJE` VARCHAR(3000), IN `FECHA` DATE)  BEGIN

INSERT INTO sdes.contacto
(con_nombre,
con_email,
con_mensaje,
con_fecha,
con_estado)
VALUES
(NOMBRE,
EMAIL,
MENSAJE,
FECHA,
ESTADO);

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Contacto_Update` (IN `ID` INT, IN `ESTADO` INT)  BEGIN

UPDATE contacto
SET

con_estado = ESTADO
WHERE con_id = ID;


END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Departamentos_GetSel` ()  BEGIN
select
departamentos.id_departamento as id,
departamentos.nom_departamento as nom
from departamentos
order by departamentos.nom_departamento asc;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Entidades_Add` (IN `NOMBRE` VARCHAR(100))  BEGIN

INSERT INTO entidadespago
(nom_entidad)
VALUES
(NOMBRE);

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Entidades_GetSel` ()  BEGIN
select
entidadespago.id_entidad as id,
entidadespago.nom_entidad as nom
from entidadespago
order by entidadespago.nom_entidad asc;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Entidades_Update` (IN `ID` INT, IN `NOMBRE` VARCHAR(100))  BEGIN

UPDATE entidadespago
SET
nom_entidad = NOMBRE
WHERE id_entidad = ID;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Estados_GetSel` ()  BEGIN
select
estados_generales.idestado as id,
estados_generales.nom_estado as nom
from estados_generales
order by estados_generales.nom_estado asc;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Facturas_Add` (IN `nproductos` INT, IN `valor` DOUBLE, IN `mediopago` INT, IN `consumo` INT, IN `sede` INT, IN `numero` INT)  BEGIN
insert into
facturas
(
facturas.num_productos,
facturas.val_factura,
facturas.fk_mediopago,
facturas.fk_consumo,
facturas.fk_sede,
facturas.num_factura
)
values
(
nproductos,
valor,
mediopago,
consumo,
sede,
numero
);
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `InsumosV_Add` (IN `ins` INT, IN `cant` INT, IN `sede` INT, IN `web` INT)  BEGIN
insert into
insumos_vendidos 
(
insumos_vendidos.fk_insumo,
insumos_vendidos.cant_insumosv,
insumos_vendidos.fecha_insumosv,
insumos_vendidos.fk_sede,
insumos_vendidos.web
)values
(
ins,
cant,
now(),
sede,
web
);
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Insumos_Add` (IN `nom` VARCHAR(100), IN `uni` INT, IN `cmin` DECIMAL(10,2))  BEGIN
insert
into
insumos
(insumos.nom_insumo, insumos.fk_unidad, insumos.cantmin_insumo)
values
(nom, uni, cmin);
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Insumos_Delete` (IN `id` INT)  BEGIN
delete
from
insumos
where insumos.id_insumo = id;
delete
from
insumos_rel
where insumos_rel.fk_insumo = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Insumos_Get` ()  BEGIN
Select
insumos.id_insumo,
insumos.nom_insumo,
insumos.cantmin_insumo,
unidades.nomSI_unidad
from
insumos
inner join unidades on unidades.id_unidad = insumos.fk_unidad;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Insumos_GetSel` ()  BEGIN
select
insumos.id_insumo as id,
insumos.nom_insumo as nom
from insumos
order by insumos.nom_insumo asc;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Insumos_GetXId` (IN `id` INT)  BEGIN
Select
insumos.id_insumo,
insumos.nom_insumo,
unidades.id_unidad,
insumos.cantmin_insumo,
unidades.nomSI_unidad
from
insumos
inner join unidades on unidades.id_unidad = insumos.fk_unidad
where insumos.id_insumo = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Insumos_GetXNom` (IN `nom` VARCHAR(100))  BEGIN
Select
insumos.id_insumo,
insumos.nom_insumo,
unidades.nomSI_unidad
from
insumos
inner join unidades on unidades.id_unidad = insumos.fk_unidad
where insumos.nom_insumo LIKE CONCAT('%', nom , '%')
limit 5;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Insumos_Update` (IN `id` INT, IN `nom` VARCHAR(100), IN `uni` INT, IN `cmin` DECIMAL(10,2))  BEGIN
update
insumos
set
insumos.nom_insumo = nom,
insumos.fk_unidad = uni,
insumos.cantmin_insumo = cmin
where insumos.id_insumo = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `InventarioDia_Add` (IN `ins` INT, IN `cant` INT, IN `iden` VARCHAR(100))  BEGIN
declare scont int;
select
count(inventario_dia.fk_inventarioiden)
into
scont
from inventario_dia
where inventario_dia.fk_inventarioiden = iden and inventario_dia.fk_insumo = ins;
if scont > 0 then
CALL`InventarioDia_Update`(ins, cant, iden);
else
INSERT INTO `inventario_dia`
(
inventario_dia.fk_insumo,
inventario_dia.cantidad1_inventario,
inventario_dia.fecha1_inventario,
inventario_dia.fecha_inventario,
inventario_dia.fk_inventarioiden
)
VALUES
(
ins,
cant,
now(),
now(),
iden
);
end if;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `InventarioDia_Update` (IN `ins` INT, IN `cant` INT, IN `iden` VARCHAR(100))  BEGIN
UPDATE `inventario_dia`
SET
inventario_dia.cantidad2_inventario = cant,
inventario_dia.fecha2_inventario = now()
WHERE inventario_dia.fk_insumo = ins and inventario_dia.fk_inventarioiden = iden;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `InventarioIden_Add` (IN `iden` VARCHAR(45), IN `est` INT, IN `sede` INT)  BEGIN
declare scont int;
select
count(inventario_identificador.iden_identificador)
into
scont
from inventario_identificador
where inventario_identificador.iden_identificador = iden;
if scont > 0 then
CALL`InventarioIden_Update`(iden, est);
else
INSERT INTO `inventario_identificador`
(
`iden_identificador`,
`fk_estado`,
`fecha_identificador`,
fk_sede
)
VALUES
(
iden,
est,
now(),
sede
);
end if;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `InventarioIden_GetXIden` (IN `iden` VARCHAR(45))  BEGIN
SELECT `inventario_identificador`.`id_identificador`,
    `inventario_identificador`.`iden_identificador`,
    `inventario_identificador`.`fk_sede`,
    `inventario_identificador`.`fk_estado`,
    date(inventario_identificador.fecha_identificador) as fecha_identificador
FROM `inventario_identificador`
where inventario_identificador.iden_identificador = iden
and
date(inventario_identificador.fecha_identificador) = date(now());
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `InventarioIden_Update` (IN `iden` VARCHAR(45), IN `est` INT)  BEGIN
UPDATE `inventario_identificador`
SET
`fk_estado` = est
WHERE inventario_identificador.iden_identificador = iden;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Inventario_Add` (IN `ins` INT, IN `cant` DECIMAL(10,2), IN `sede` INT)  BEGIN
declare scant int;
declare sid int;
select
ifnull(inventario.id_inventario, 0),
count(inventario.fk_insumo)
into
sid,
scant
from
inventario
where inventario.fk_insumo = ins
and
inventario.sede_inventario = sede;
if scant = 0 then
INSERT INTO inventario
(`fk_insumo`,
`cantidad_inventario`,
`fecha_inventario`,
`sede_inventario`)
VALUES
(ins,
cant,
now(),
sede);
select 'saved', scant;
else
CALL Inventario_Update(sid, ins, cant, sede);
select 'updated', scant;
end if;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Inventario_AddPrueba` (IN `ins` INT, IN `cant` DECIMAL(10,2), IN `sede` INT)  BEGIN
declare scant int;
declare sid int;
select
ifnull(inventario.id_inventario, 0),
count(inventario.fk_insumo)
into
sid,
scant
from
inventario
where inventario.fk_insumo = ins
and
inventario.sede_inventario = sede;
if scant = 0 then
INSERT INTO inventario
(`fk_insumo`,
`cantidad_inventario`,
`fecha_inventario`,
`sede_inventario`)
VALUES
(ins,
cant,
now(),
sede);
select 'saved', scant;
else
CALL Inventario_Update(sid, ins, cant, sede);
select 'updated', scant;
end if;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Inventario_Delete` (IN `id` INT)  BEGIN
DELETE FROM `inventario`
WHERE inventario.id_inventario = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Inventario_Get` ()  BEGIN
SELECT
inventario.id_inventario,
insumos.nom_insumo,
inventario.cantidad_inventario,
concat(unidades.nomSI_unidad, '(', unidades.simbolo_unidad, ')') as unidad,
sedes.nom_sede
FROM
inventario
inner join insumos on insumos.id_insumo = inventario.fk_insumo
inner join unidades on unidades.id_unidad = insumos.fk_unidad
inner join sedes on sedes.id_sede = inventario.sede_inventario;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Inventario_GetXId` (IN `id` INT)  BEGIN
SELECT `inventario`.`id_inventario`,
    `inventario`.`fk_insumo`,
    `inventario`.`cantidad_inventario`,
    `inventario`.`fecha_inventario`,
    `inventario`.`sede_inventario`,
    concat(unidades.nomSI_unidad, '(', unidades.simbolo_unidad, ')') as unidad
FROM `inventario`
inner join insumos on insumos.id_insumo = inventario.fk_insumo
inner join unidades on unidades.id_unidad = insumos.fk_unidad
where inventario.id_inventario = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Inventario_GetXSede` (IN `idsede` INT)  BEGIN
SELECT
inventario.id_inventario,
insumos.nom_insumo,
inventario.cantidad_inventario,
concat(unidades.nomSI_unidad, '(', unidades.simbolo_unidad, ')') as unidad,
sedes.nom_sede
FROM
inventario
inner join insumos on insumos.id_insumo = inventario.fk_insumo
inner join unidades on unidades.id_unidad = insumos.fk_unidad
inner join sedes on sedes.id_sede = inventario.sede_inventario
where sedes.id_sede = idsede;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Inventario_RestarCant` (IN `ins` INT, IN `cant` DECIMAL(10,2), IN `cantp` INT, IN `sede` INT)  BEGIN
declare scant int;
declare sid int;
declare nomins varchar(100);
declare cmin int;
declare nsede varchar(100);
select
(inventario.cantidad_inventario - (cant*cantp)),
inventario.id_inventario,
insumos.nom_insumo,
insumos.cantmin_insumo,
sedes.nom_sede
into
scant,
sid,
nomins,
cmin,
nsede
from
inventario
inner join insumos on insumos.id_insumo = inventario.fk_insumo
inner join sedes on sedes.id_sede = inventario.sede_inventario
where inventario.fk_insumo = ins
and
inventario.sede_inventario = sede;
if scant <  0 then
CALL Inventario_Update(sid, ins, 0, sede);
else
CALL Inventario_Update(sid, ins, scant, sede);
end if;
if scant <= cmin then
call Alertas_Add('Iventario', concat('Quedan ', scant, ' de ', nomins, ' en ', nsede), 2);
end if;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Inventario_Update` (IN `id` INT, IN `ins` INT, IN `cant` DECIMAL(10,2), IN `sede` INT)  BEGIN
UPDATE `inventario`
SET
`fk_insumo` = ins,
`cantidad_inventario` = cant,
`fecha_inventario` = now(),
`sede_inventario` = sede
WHERE `id_inventario` = id AND `sede_inventario` = sede;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `MedioPago_Add` (IN `NOMBRE` VARCHAR(100))  BEGIN

INSERT INTO medio_pago
(nommedio_pago)
VALUES
(NOMBRE);

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `MedioPago_Get` ()  BEGIN

SELECT medio_pago.idmedio_pago,
    medio_pago.nommedio_pago
FROM medio_pago;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `MedioPago_Update` (IN `ID` INT, IN `NOMBRE` VARCHAR(100))  BEGIN

UPDATE medio_pago
SET
nommedio_pago = NOMBRE
WHERE idmedio_pago = ID;


END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `meses_GetSel` ()  BEGIN
select distinct
month(productos_vendidos.fecha_vendido) as id,
meses.nom_mes as nom
from
productos_vendidos
inner join meses on meses.id_mes = month(productos_vendidos.fecha_vendido)
order by id asc;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Municipios_GetAllSel` ()  BEGIN
select
municipios.id_municipio as id,
municipios.nom_municipio as nom
from municipios
order by municipios.nom_municipio asc;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Municipios_GetSel` (IN `iddep` INT)  BEGIN
select
municipios.id_municipio as id,
municipios.nom_municipio as nom
from municipios
where municipios.fk_departamento = iddep
order by municipios.nom_municipio asc;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Parametrizador_Get` ()  BEGIN

 SELECT parametrizador.id_parametrizador,
    parametrizador.nombre_parametrizador,
    parametrizador.fk_estado
FROM parametrizador
where parametrizador.fk_estado = 1;


END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `ProductosV_Add` (IN `pro` INT, IN `cant` INT, IN `des` DECIMAL(10,2), IN `fac` VARCHAR(45), IN `sede` INT, IN `web` INT)  BEGIN
insert into
productos_vendidos 
(
productos_vendidos.fk_producto,
productos_vendidos.cant_vendido,
productos_vendidos.desc_vendido,
productos_vendidos.fecha_vendido,
productos_vendidos.fk_factura,
productos_vendidos.fk_sede,
productos_vendidos.web
)values
(
pro,
cant,
des,
now(),
fac,
sede,
web
);
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `ProductosV_Get` (IN `fecha` DATE, IN `dia` INT, IN `mes` INT, IN `anio` INT, IN `sede` INT)  BEGIN
if fecha = '0-0-0' and dia = 0 and mes = 0 and anio = 0 and sede = 0 then 
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos.precio_producto,
sum(productos_vendidos.cant_vendido) as cantidad,
sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as valor,
sedes.nom_sede
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
group by productos_vendidos.fk_producto
order by cantidad desc;
elseif fecha != '0-0-0' and dia = 0 and mes = 0 and anio = 0 and sede = 0 then 
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos.precio_producto,
sum(productos_vendidos.cant_vendido) as cantidad,
sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as valor,
sedes.nom_sede
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where date(productos_vendidos.fecha_vendido) = fecha
group by productos_vendidos.fk_producto
order by cantidad desc;
elseif fecha != '0-0-0' and dia = 0 and mes = 0 and anio = 0 and sede != 0 then 
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos.precio_producto,
sum(productos_vendidos.cant_vendido) as cantidad,
sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as valor,
sedes.nom_sede
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where date(productos_vendidos.fecha_vendido) = fecha
and productos_vendidos.fk_sede = sede
group by productos_vendidos.fk_producto
order by cantidad desc;
elseif fecha = '0-0-0' and dia != 0 and mes = 0 and anio = 0 and sede = 0 then 
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos.precio_producto,
sum(productos_vendidos.cant_vendido) as cantidad,
sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as valor,
sedes.nom_sede
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where date(productos_vendidos.fecha_vendido) = date(now())
group by productos_vendidos.fk_producto
order by cantidad desc;
elseif fecha = '0-0-0' and dia != 0 and mes = 0 and anio = 0 and sede != 0 then 
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos.precio_producto,
sum(productos_vendidos.cant_vendido) as cantidad,
sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as valor,
sedes.nom_sede
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where date(productos_vendidos.fecha_vendido) = date(now())
and productos_vendidos.fk_sede = sede
group by productos_vendidos.fk_producto
order by cantidad desc;
elseif fecha = '0-0-0' and dia = 0 and mes != 0 and anio = 0 and sede = 0 then 
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos.precio_producto,
sum(productos_vendidos.cant_vendido) as cantidad,
sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as valor,
sedes.nom_sede
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where month(productos_vendidos.fecha_vendido) = month(now())
and year(productos_vendidos.fecha_vendido) = year(now())
group by productos_vendidos.fk_producto
order by cantidad desc;
elseif fecha = '0-0-0' and dia = 0 and mes != 0 and anio = 0 and sede != 0 then 
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos.precio_producto,
sum(productos_vendidos.cant_vendido) as cantidad,
sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as valor,
sedes.nom_sede
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where month(productos_vendidos.fecha_vendido) = month(now())
and year(productos_vendidos.fecha_vendido) = year(now())
and productos_vendidos.fk_sede = sede
group by productos_vendidos.fk_producto
order by cantidad desc;
elseif fecha = '0-0-0' and dia = 0 and mes = 0 and anio != 0 and sede = 0 then 
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos.precio_producto,
sum(productos_vendidos.cant_vendido) as cantidad,
sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as valor,
sedes.nom_sede
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where year(productos_vendidos.fecha_vendido) = year(now())
group by productos_vendidos.fk_producto
order by cantidad desc;
elseif fecha = '0-0-0' and dia = 0 and mes = 0 and anio != 0 and sede != 0 then 
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos.precio_producto,
sum(productos_vendidos.cant_vendido) as cantidad,
sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as valor,
sedes.nom_sede
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where year(productos_vendidos.fecha_vendido) = year(now())
and productos_vendidos.fk_sede = sede
group by productos_vendidos.fk_producto
order by cantidad desc;
else
SELECT 'Filtro no encontrado' as nom_producto;
END IF;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `ProductosV_GetTotal` (IN `fecha` DATE, IN `dia` INT, IN `mes` INT, IN `anio` INT, IN `sede` INT)  BEGIN
if fecha = '0-0-0' and dia = 0 and mes = 0 and anio = 0 and sede = 0 then 
SELECT
ifnull(sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido), 0) as total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede;
elseif fecha != '0-0-0' and dia = 0 and mes = 0 and anio = 0 and sede = 0 then 
SELECT
ifnull(sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido), 0) as total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where date(productos_vendidos.fecha_vendido) = fecha;
elseif fecha != '0-0-0' and dia = 0 and mes = 0 and anio = 0 and sede != 0 then 
SELECT
ifnull(sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido), 0) as total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where date(productos_vendidos.fecha_vendido) = fecha
and productos_vendidos.fk_sede = sede;
elseif fecha = '0-0-0' and dia != 0 and mes = 0 and anio = 0 and sede = 0 then 
SELECT
ifnull(sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido), 0) as total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where date(productos_vendidos.fecha_vendido) = date(now());
elseif fecha = '0-0-0' and dia != 0 and mes = 0 and anio = 0 and sede != 0 then 
SELECT
ifnull(sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido), 0) as total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where date(productos_vendidos.fecha_vendido) = date(now())
and productos_vendidos.fk_sede = sede;
elseif fecha = '0-0-0' and dia = 0 and mes != 0 and anio = 0 and sede = 0 then 
SELECT
ifnull(sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido), 0) as total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where month(productos_vendidos.fecha_vendido) = month(now())
and year(productos_vendidos.fecha_vendido) = year(now());
elseif fecha = '0-0-0' and dia = 0 and mes != 0 and anio = 0 and sede != 0 then 
SELECT
ifnull(sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido), 0) as total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where month(productos_vendidos.fecha_vendido) = month(now())
and year(productos_vendidos.fecha_vendido) = year(now())
and productos_vendidos.fk_sede = sede;
elseif fecha = '0-0-0' and dia = 0 and mes = 0 and anio != 0 and sede = 0 then 
SELECT
ifnull(sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido), 0) as total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where year(productos_vendidos.fecha_vendido) = year(now());
elseif fecha = '0-0-0' and dia = 0 and mes = 0 and anio != 0 and sede != 0 then 
SELECT
ifnull(sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido), 0) as total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where year(productos_vendidos.fecha_vendido) = year(now())
and productos_vendidos.fk_sede = sede;
else
SELECT 0 as total;
END IF;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `ProductosV_GetXFilt` (IN `mes` INT, IN `anio` INT, IN `sede` INT)  BEGIN
if mes = 0 and anio = 0 and sede = 0 then
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos.precio_producto,
sum(productos_vendidos.cant_vendido) as cantidad,
sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as valor,
sedes.nom_sede
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
group by productos_vendidos.fk_producto
order by cantidad desc;
elseif mes != 0 and anio != 0 and sede = 0 then 
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos.precio_producto,
sum(productos_vendidos.cant_vendido) as cantidad,
sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as valor,
sedes.nom_sede
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where month(productos_vendidos.fecha_vendido) = mes
and year(productos_vendidos.fecha_vendido) = anio
group by productos_vendidos.fk_producto
order by cantidad desc;
elseif mes = 0 and anio != 0 and sede = 0 then 
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos.precio_producto,
sum(productos_vendidos.cant_vendido) as cantidad,
sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as valor,
sedes.nom_sede
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where year(productos_vendidos.fecha_vendido) = anio
group by productos_vendidos.fk_producto
order by cantidad desc;
elseif mes = 0 and anio = 0 and sede != 0 then 
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos.precio_producto,
sum(productos_vendidos.cant_vendido) as cantidad,
sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as valor,
sedes.nom_sede
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where productos_vendidos.fk_sede = sede
group by productos_vendidos.fk_producto
order by cantidad desc;
elseif mes = 0 and anio != 0 and sede != 0 then 
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos.precio_producto,
sum(productos_vendidos.cant_vendido) as cantidad,
sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as valor,
sedes.nom_sede
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where productos_vendidos.fk_sede = sede
and year(productos_vendidos.fecha_vendido) = anio
group by productos_vendidos.fk_producto
order by cantidad desc;
elseif mes != 0 and anio != 0 and sede != 0 then 
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos.precio_producto,
sum(productos_vendidos.cant_vendido) as cantidad,
sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as valor,
sedes.nom_sede
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where productos_vendidos.fk_sede = sede
and year(productos_vendidos.fecha_vendido) = anio
and month(productos_vendidos.fecha_vendido) = mes
group by productos_vendidos.fk_producto
order by cantidad desc;
else
SELECT 'Filtro no encontrado' as nom_producto;
END IF;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `ProductosV_GetXFiltTotal` (IN `mes` INT, IN `anio` INT, IN `sede` INT)  BEGIN
if mes = 0 and anio = 0 and sede = 0 then
SELECT
ifnull(sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido), 0) as total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede;
elseif mes != 0 and anio != 0 and sede = 0 then 
SELECT
ifnull(sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido), 0) as total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where month(productos_vendidos.fecha_vendido) = mes
and year(productos_vendidos.fecha_vendido) = anio;
elseif mes = 0 and anio != 0 and sede = 0 then 
SELECT
ifnull(sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido), 0) as total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where year(productos_vendidos.fecha_vendido) = anio;
elseif mes = 0 and anio = 0 and sede != 0 then 
SELECT
ifnull(sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido), 0) as total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where productos_vendidos.fk_sede = sede;
elseif mes = 0 and anio != 0 and sede != 0 then 
SELECT
ifnull(sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido), 0) as total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where productos_vendidos.fk_sede = sede
and year(productos_vendidos.fecha_vendido) = anio;
elseif mes != 0 and anio != 0 and sede != 0 then 
SELECT
ifnull(sum((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido), 0) as total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
where productos_vendidos.fk_sede = sede
and year(productos_vendidos.fecha_vendido) = anio
and month(productos_vendidos.fecha_vendido) = mes;
else
SELECT 0 as total;
END IF;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Productos_Add` (IN `id` INT, IN `nom` VARCHAR(45), IN `nomg` VARCHAR(1000), IN `precio` DOUBLE, IN `cat` INT, IN `descr` VARCHAR(4000), IN `img` VARCHAR(200))  BEGIN
insert into
productos
(
productos.id_producto,
productos.nom_producto,
productos.nomG_producto,
productos.precio_producto,
productos.fk_categoria,
productos.descripcion_producto,
productos.imagen_producto
)
values
(
id,
nom,
nomG,
precio,
cat,
descr,
img
);
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Productos_Delete` (IN `id` INT)  BEGIN
delete
from
productos
where
productos.id_producto = id;
delete
from
insumos_rel
where insumos_rel.fk_producto = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Productos_Get` ()  BEGIN
SELECT
productos.id_producto,
productos.nom_producto,
productos.nomG_producto,
productos.precio_producto,
categorias.nomcategoria,
productos.imagen_producto
FROM productos
INNER JOIN categorias on categorias.idcategoria = productos.fk_categoria;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Productos_GetNuevoId` ()  BEGIN
SELECT 
max(id_producto)+1 as nid 
FROM 
productos;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Productos_GetXCategoria` (IN `id` INT)  BEGIN
select
productos.id_producto,
productos.nom_producto,
categorias.nomcategoria,
productos.precio_producto,
productos.mprima_producto,
productos.comision_producto,
productos.imagen_producto
from
productos
inner join categorias on categorias.idcategoria = productos.fk_categoria
where
productos.fk_categoria = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Productos_GetXId` (IN `id` INT)  BEGIN
select
productos.id_producto,
productos.nom_producto,
productos.nomG_producto,
productos.precio_producto,
productos.fk_categoria,
productos.descripcion_producto,
categorias.nomcategoria,
productos.imagen_producto
from
productos
inner join categorias on categorias.idcategoria = productos.fk_categoria
where
productos.id_producto = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Productos_Update` (IN `id` INT, IN `nom` VARCHAR(45), IN `nomg` VARCHAR(1000), IN `precio` DOUBLE, IN `cat` INT, IN `descr` VARCHAR(4000), IN `img` VARCHAR(200))  BEGIN
update
productos
set
productos.nom_producto = nom,
productos.nomG_producto = nomG,
productos.precio_producto = precio,
productos.fk_categoria = cat,
productos.descripcion_producto = descr,
productos.imagen_producto = img
where productos.id_producto = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Relacion_Add` (IN `idpro` INT, IN `idins` INT, IN `cant` DECIMAL(10,5))  BEGIN
insert
into
insumos_rel
(insumos_rel.fk_producto, insumos_rel.fk_insumo, insumos_rel.insumoUnidad_rel)
values
(idpro, idins, cant);
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Relacion_Delete` (IN `idpro` INT, IN `idins` INT)  BEGIN
delete from
insumos_rel
where
insumos_rel.fk_producto = idpro
and
insumos_rel.fk_insumo = idins;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Relacion_Get` ()  BEGIN
select
insumos.nom_insumo,
insumos_rel.insumoUnidad_rel as cantidad,
unidades.simbolo_unidad,
unidades.nomSI_unidad,
productos.nom_producto,
insumos_rel.fk_insumo,
insumos_rel.fk_producto
from insumos_rel
inner join insumos on insumos.id_insumo = insumos_rel.fk_insumo
inner join productos on productos.id_producto = insumos_rel.fk_producto
inner join unidades on unidades.id_unidad = insumos.fk_unidad;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Relacion_GetXProd` (IN `id` INT)  BEGIN
select
insumos.nom_insumo,
insumos_rel.insumoUnidad_rel,
unidades.simbolo_unidad,
unidades.nomSI_unidad,
insumos_rel.fk_insumo,
insumos_rel.fk_producto
from insumos_rel
inner join insumos on insumos.id_insumo = insumos_rel.fk_insumo
inner join unidades on unidades.id_unidad = insumos.fk_unidad
where insumos_rel.fk_producto = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Relacion_Update` (IN `idpro` INT, IN `idins` INT, IN `cant` DECIMAL(10,5))  BEGIN
update
insumos_rel
set
insumos_rel.insumoUnidad_rel = cant
where
insumos_rel.fk_producto = idpro
and
insumos_rel.fk_insumo = idins;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Reportes_Add` (IN `iden` VARCHAR(45), IN `val` DOUBLE, IN `sede` INT)  BEGIN
declare scont int;
select
count(reportes.iden_reporte)
into
scont
from reportes
where reportes.iden_reporte = iden and reportes.fk_sede = sede;
if scont > 0 then
CALL`Reportes_Update`(iden, val, sede);
else
INSERT INTO `reportes`
(
`iden_reporte`,
`val_reporte`,
`fk_sede`,
`fecha_reporte`)
VALUES
(
iden,
val,
sede,
now()
);
end if;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Reportes_Get` ()  BEGIN
SELECT `reportes`.`id_reportes`,
    `reportes`.`iden_reporte`,
    `reportes`.`val_reporte`,
    `reportes`.`fk_sede`,
    sedes.nom_sede,
    `reportes`.`fecha_reporte`
FROM `reportes`
inner join sedes on sedes.id_sede = reportes.fk_sede;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Reportes_Update` (IN `iden` VARCHAR(45), IN `val` DOUBLE, IN `sede` INT)  BEGIN
UPDATE `reportes`
SET
`val_reporte` = val
WHERE `iden_reporte` = iden and reportes.fk_sede = sede;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Secciones_Get` ()  BEGIN

SELECT cms_seccion.id_seccion,
    cms_seccion.nom_seccion
FROM cms_seccion;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Sedes_Add` (IN `nit` VARCHAR(100), IN `nom` VARCHAR(45), IN `dir` VARCHAR(100), IN `mun` INT, IN `tel1` DOUBLE, IN `tel2` DOUBLE, IN `tel3` DOUBLE, IN `longi` VARCHAR(100), IN `lat` VARCHAR(100))  BEGIN
declare nid int;
select max(sedes.id_sede)+1 into nid
from sedes;
insert into
sedes
(
sedes.nit_sede,
sedes.nom_sede,
sedes.dir_sede,
sedes.fk_municipio,
sedes.tel1_sede,
sedes.tel2_sede,
sedes.tel3_sede,
sedes.long_sede,
sedes.lat_sede,
sedes.iden_sede
)
values
(
nit,
nom,
dir,
mun,
tel1,
tel2,
tel3,
longi,
lat,
concat('shsed', nid)
);
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Sedes_Delete` (IN `id` INT)  BEGIN
delete from
sedes
where
sedes.id_sede = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Sedes_Get` ()  BEGIN
select
sedes.id_sede,
sedes.nom_sede,
sedes.dir_sede,
sedes.tel1_sede,
sedes.tel2_sede,
municipios.nom_municipio,
departamentos.nom_departamento
from
sedes
inner join municipios on municipios.id_municipio = sedes.fk_municipio
inner join  departamentos on departamentos.id_departamento = municipios.fk_departamento;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Sedes_GetSel` ()  BEGIN
select
sedes.id_sede as id,
sedes.nom_sede as nom
from sedes
order by sedes.nom_sede asc;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Sedes_GetXId` (IN `id` INT)  BEGIN
select
sedes.id_sede, 
sedes.nit_sede,
sedes.nom_sede,
sedes.dir_sede,
sedes.tel1_sede,
sedes.tel2_sede,
sedes.tel3_sede,
municipios.id_municipio,
municipios.fk_departamento,
sedes.long_sede,
sedes.lat_sede,
sedes.iden_sede,
caja.estado_caja,
estados_generales.nom_estado
from
sedes
inner join caja on caja.sede_caja = sedes.id_sede
inner join estados_generales on estados_generales.idestado = caja.estado_caja
inner join municipios on municipios.id_municipio = sedes.fk_municipio
where
sedes.id_sede = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Sedes_GetXNom` (IN `nom` VARCHAR(45))  BEGIN
select
sedes.id_sede, 
sedes.nit_sede,
sedes.nom_sede,
sedes.dir_sede,
municipios.id_municipio,
municipios.nom_municipio,
departamentos.id_departamento,
departamentos.nom_departamento,
sedes.tel1_sede,
sedes.tel2_sede,
sedes.tel3_sede,
sedes.long_sede,
sedes.lat_sede,
sedes.iden_sede
from
sedes
inner join municipios on municipios.id_municipio = sedes.fk_municipio
inner join departamentos on departamentos.id_departamento = municipios.fk_departamento
where
sedes.nom_sede = nom;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Sedes_Update` (IN `id` INT, IN `nit` VARCHAR(100), IN `nom` VARCHAR(45), IN `dir` VARCHAR(100), IN `mun` INT, IN `tel1` DOUBLE, IN `tel2` DOUBLE, IN `tel3` DOUBLE, IN `longi` VARCHAR(100), IN `lat` VARCHAR(100))  BEGIN
update
sedes
set
sedes.nit_sede =nit,
sedes.nom_sede = nom,
sedes.dir_sede = dir,
sedes.fk_municipio = mun,
sedes.tel1_sede = tel1,
sedes.tel2_sede = tel2,
sedes.tel3_sede = tel3,
sedes.long_sede = longi,
sedes.lat_sede = lat
where
sedes.id_sede = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Tokens_Get` (IN `IP` VARCHAR(45), IN `SO` VARCHAR(200), IN `BROWSER` VARCHAR(200), IN `USER` VARCHAR(45), IN `FECHA` DATETIME)  BEGIN

declare cant int;
declare us double;

set @IP = IP;
set @SO = SO;
SET @BROWSER = BROWSER;
SET @USER = USER;
SET @FECHA = FECHA;
SET @EXPIRA = concat(date(FECHA), ' 23:59:00');
SET @HASHTXT = SHA2(concat(@IP, @SO, @BROWSER, @USER, @FECHA, @EXPIRA, uuid()), 224);

select
count(tokens.user_token),
tokens.user_token
into
cant,
us
from
tokens
where tokens.user_token = @USER
limit 1;

if cant > 0 then 

UPDATE tokens
SET
hash_token = @HASHTXT,
ip_token = @IP,
so_token = @SO,
browser_token = @BROWSER,
fecha_token = @FECHA,
expira_token = @EXPIRA,
fk_estado = 1
WHERE user_token = @USER;

else

INSERT INTO tokens
(hash_token,
ip_token,
so_token,
browser_token,
user_token,
fecha_token,
expira_token,
fk_estado)
VALUES
(
@HASHTXT,
@IP,
@SO,
@BROWSER,
@USER,
@FECHA,
@EXPIRA,
1
);
end if;

SELECT
tokens.hash_token as token
FROM
tokens
WHERE
tokens.hash_token = @HASHTXT;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Tokens_GetEstado` (IN `TOKEN` VARCHAR(5000), IN `FECHA` DATETIME)  BEGIN

declare cont int;
declare creation datetime;
declare expiration datetime;

SELECT count(tokens.hash_token),
    tokens.fecha_token,
    tokens.expira_token
    INTO
    cont,
    creation,
    expiration
FROM tokens
where tokens.hash_token = TOKEN;

if cont > 0 then

if date(creation) = date(FECHA) then
   if (hour(FECHA) - hour(creation)) <= 5 then
       UPDATE tokens
       SET
       fecha_token = FECHA,
       fk_estado = 1
	    WHERE hash_token = TOKEN;
       select 1 as estado, 'OK' as result;
   else
       UPDATE tokens
       SET
       fk_estado = 2
	    WHERE hash_token = TOKEN;
       select 2 as estado, 'EXPIRED' as result;
   end if;
else
 UPDATE tokens
       SET
       fk_estado = 2
	    WHERE hash_token = TOKEN;
       select 2 as estado, 'EXPIRED' as result;
end if;

else

select 0 as estado, 'NO RESULTS' as result;

end if;


END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Unidades_Add` (IN `NOMBRE` VARCHAR(100), IN `SIMBOLO` VARCHAR(50))  BEGIN

INSERT INTO unidades
(nomSI_unidad,
simbolo_unidad)
VALUES
(NOMBRE,
SIMBOLO);


END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Unidades_Get` ()  BEGIN
select
unidades.id_unidad as id,
unidades.nomSI_unidad as nom
from unidades;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Unidades_GetSel` ()  BEGIN
select
unidades.id_unidad as id,
unidades.nomSI_unidad as nom
from unidades;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Unidades_Update` (IN `ID` INT, IN `NOMBRE` VARCHAR(100), IN `SIMBOLO` VARCHAR(50))  BEGIN

UPDATE unidades
SET
nomSI_unidad = NOMBRE,
simbolo_unidad = SIMBOLO
WHERE id_unidad = ID;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `UsuariosTipo_GetSel` ()  BEGIN
select
usuarios_tipo.idusuarios_tipo as id,
usuarios_tipo.nom_tipo as nom
from usuarios_tipo
order by usuarios_tipo.nom_tipo asc;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Usuarios_Add` (IN `documento` DOUBLE, IN `nombres` VARCHAR(100), IN `apellidos` VARCHAR(100), IN `tel` VARCHAR(10), IN `email` VARCHAR(500), IN `pass` VARCHAR(45), IN `tipo` INT, IN `estado` INT)  BEGIN
declare scont int;
declare idus int;
select
count(usuarios.id_usuario),
ifnull(usuarios.id_usuario, 0)
into
scont,
idus
from usuarios
where usuarios.doc_usuario = documento;
if scont > 0 then
CALL Usuarios_Update(idus, documento, nombres, apellidos, tel, email, pass, tipo, estado);
else
INSERT INTO
usuarios
(usuarios.doc_usuario,
usuarios.nom_usuario,
usuarios.ape_usuario,
usuarios.tel_usuario,
usuarios.email_usuario,
usuarios.pass_usuario,
usuarios.tipo_usuario,
usuarios.estado_usuario)
values
(documento,
nombres,
apellidos,
tel,
email,
pass,
tipo,
estado);
end if;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Usuarios_Delete` (IN `id` INT)  BEGIN
DELETE FROM usuarios
WHERE usuarios.id_usuario = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Usuarios_Get` ()  BEGIN
select
usuarios.id_usuario,
usuarios.doc_usuario,
usuarios.nom_usuario,
usuarios.ape_usuario,
usuarios.tel_usuario,
usuarios.email_usuario,
usuarios_tipo.nom_tipo,
usuarios.tipo_usuario,
comun_estados.nomcomun_estado
from
usuarios
inner join usuarios_tipo on usuarios_tipo.idusuarios_tipo = usuarios.tipo_usuario
inner join comun_estados on comun_estados.idcomun_estado = usuarios.estado_usuario
order by usuarios.id_usuario asc;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Usuarios_GetXDoc` (IN `doc` DOUBLE)  BEGIN
select
usuarios.id_usuario,
usuarios.doc_usuario,
usuarios.nom_usuario,
usuarios.ape_usuario,
usuarios.tel_usuario,
usuarios.email_usuario,
usuarios.pass_usuario,
usuarios.tipo_usuario,
usuarios.estado_usuario
from
usuarios
inner join usuarios_tipo on usuarios_tipo.idusuarios_tipo = usuarios.tipo_usuario
inner join comun_estados on comun_estados.idcomun_estado = usuarios.estado_usuario
where usuarios.doc_usuario =doc;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Usuarios_GetXId` (IN `id` INT)  BEGIN
select
usuarios.id_usuario,
usuarios.doc_usuario,
usuarios.nom_usuario,
usuarios.ape_usuario,
usuarios.tel_usuario,
usuarios.email_usuario,
usuarios.pass_usuario,
usuarios.tipo_usuario,
usuarios.estado_usuario,
usuarios_tipo.nom_tipo
from
usuarios
inner join usuarios_tipo on usuarios_tipo.idusuarios_tipo = usuarios.tipo_usuario
inner join comun_estados on comun_estados.idcomun_estado = usuarios.estado_usuario
where usuarios.id_usuario =id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Usuarios_Login` (IN `doc` DOUBLE, IN `pass` VARCHAR(45))  BEGIN
SET collation_connection = 'utf8_spanish_ci';
select
usuarios.id_usuario,
usuarios.doc_usuario,
usuarios.nom_usuario,
usuarios.ape_usuario,
usuarios.tel_usuario,
usuarios.email_usuario,
usuarios.pass_usuario,
usuarios.tipo_usuario,
usuarios_tipo.nom_tipo,
usuarios.estado_usuario,
comun_estados.nomcomun_estado,
usuarios_tipo.nom_tipo
from
usuarios
inner join usuarios_tipo on usuarios_tipo.idusuarios_tipo = usuarios.tipo_usuario
inner join comun_estados on comun_estados.idcomun_estado = usuarios.estado_usuario
where usuarios.doc_usuario = doc
and usuarios.pass_usuario= pass
/*and (usuarios.estado_usuario = 1 or usuarios.estado_usuario = 3)
and (usuarios.tipo_usuario = 2 or usuarios.tipo_usuario = 3)*/
order by usuarios.id_usuario asc;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Usuarios_Update` (IN `id` INT, IN `documento` DOUBLE, IN `nombres` VARCHAR(100), IN `apellidos` VARCHAR(100), IN `tel` VARCHAR(10), IN `email` VARCHAR(500), IN `pass` VARCHAR(45), IN `tipo` INT, IN `estado` INT)  BEGIN
UPDATE usuarios
SET
usuarios.doc_usuario = documento,
usuarios.nom_usuario = nombres,
usuarios.ape_usuario = apellidos,
usuarios.tel_usuario = tel,
usuarios.email_usuario = email,
usuarios.pass_usuario = pass,
usuarios.tipo_usuario = tipo,
usuarios.estado_usuario = estado
WHERE usuarios.id_usuario = id;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Ventas_Add` (IN `cant` INT, IN `fac` VARCHAR(100), IN `sede` INT, IN `consumo` INT, IN `pago` INT, IN `ent` INT, IN `val` DOUBLE, IN `web` INT)  BEGIN
insert
into
ventas
(
ventas.cant_productos,
ventas.num_factura,
ventas.fk_sede,
ventas.fk_consumo,
ventas.fk_pago,
ventas.fk_entidad,
ventas.val_venta,
ventas.facha_venta,
ventas.web
)
values
(
cant,
fac,
sede,
consumo,
pago,
ent,
val,
now(),
web
);
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Ventas_Get` (IN `fecha` DATE, IN `dia` INT, IN `mes` INT, IN `anio` INT, IN `sede` INT)  BEGIN
if fecha = '0-0-0' and dia = 0 and mes = 0 and anio = 0 and sede = 0 then 
#Todas las ventas
SELECT
ventas.id_venta,
ventas.num_factura,
ventas.cant_productos,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta,
date(ventas.facha_venta) as fecha,
time(ventas.facha_venta) as hora
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
order by ventas.facha_venta asc;
elseif fecha = '0-0-0' and dia != 0 and mes = 0 and anio = 0 and sede = 0 then 
#Ventas por dia actual
SELECT
ventas.id_venta,
ventas.num_factura,
ventas.cant_productos,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta,
date(ventas.facha_venta) as fecha,
time(ventas.facha_venta) as hora
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where date(ventas.facha_venta) = date(now())
order by ventas.facha_venta asc;
elseif fecha = '0-0-0' and dia = 0 and mes != 0 and anio = 0 and sede = 0 then 
#Ventas por mes actual
SELECT
ventas.id_venta,
ventas.num_factura,
ventas.cant_productos,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta,
date(ventas.facha_venta) as fecha,
time(ventas.facha_venta) as hora
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where month(ventas.facha_venta) = month(now())
and year(ventas.facha_venta) = year(now())
order by ventas.facha_venta asc;
elseif fecha = '0-0-0' and dia = 0 and mes = 0 and anio != 0 and sede = 0 then 
#Ventas por año actual
SELECT
ventas.id_venta,
ventas.num_factura,
ventas.cant_productos,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta,
date(ventas.facha_venta) as fecha,
time(ventas.facha_venta) as hora
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where year(ventas.facha_venta) = year(now())
order by ventas.facha_venta asc;
elseif fecha != '0-0-0' and dia = 0 and mes = 0 and anio = 0 and sede = 0 then 
#Ventas por fecha
SELECT
ventas.id_venta,
ventas.num_factura,
ventas.cant_productos,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta,
date(ventas.facha_venta) as fecha,
time(ventas.facha_venta) as hora
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where date(ventas.facha_venta) = fecha
order by ventas.facha_venta asc;
elseif fecha = '0-0-0' and dia != 0 and mes != 0 and anio = 0 and sede != 0 then 
#Ventas por dia actual y sede
SELECT
ventas.id_venta,
ventas.num_factura,
ventas.cant_productos,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta,
date(ventas.facha_venta) as fecha,
time(ventas.facha_venta) as hora
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where date(ventas.facha_venta) = date(now())
and ventas.fk_sede = sede
order by ventas.facha_venta asc;
elseif fecha = '0-0-0' and dia = 0 and mes != 0 and anio = 0 and sede != 0 then 
#Ventas por mes actual y sede 
SELECT
ventas.id_venta,
ventas.num_factura,
ventas.cant_productos,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta,
date(ventas.facha_venta) as fecha,
time(ventas.facha_venta) as hora
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where month(ventas.facha_venta) = month(now())
and year(ventas.facha_venta) = year(now())
and ventas.fk_sede = sede
order by ventas.facha_venta asc;
elseif fecha = '0-0-0' and dia = 0 and mes = 0 and anio != 0 and sede != 0 then 
#Ventas por año actual y sede
SELECT
ventas.id_venta,
ventas.num_factura,
ventas.cant_productos,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta,
date(ventas.facha_venta) as fecha,
time(ventas.facha_venta) as hora
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where year(ventas.facha_venta) = year(now())
and ventas.fk_sede = sede
order by ventas.facha_venta asc;
elseif fecha != '0-0-0' and dia = 0 and mes = 0 and anio = 0 and sede != 0 then 
#Ventas por fecha y sede
SELECT
ventas.id_venta,
ventas.num_factura,
ventas.cant_productos,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta,
date(ventas.facha_venta) as fecha,
time(ventas.facha_venta) as hora
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where date(ventas.facha_venta) = fecha
and ventas.fk_sede = sede
order by ventas.facha_venta asc;
else
SELECT 'Filtro no encontrado' as nom_sede;
END IF;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Ventas_GetDetalle` (IN `vent` INT)  BEGIN
SELECT
productos_vendidos.fk_producto,
productos.nom_producto,
productos_vendidos.cant_vendido,
productos.precio_producto,
(productos_vendidos.desc_vendido*100) as descuento,
((productos.precio_producto-(productos.precio_producto*productos_vendidos.desc_vendido))*productos_vendidos.cant_vendido) as Total
FROM productos_vendidos
inner join productos on productos.id_producto = productos_vendidos.fk_producto
inner join sedes on sedes.id_sede = productos_vendidos.fk_sede
inner join ventas on ventas.num_factura  collate utf8_general_ci = productos_vendidos.fk_factura collate utf8_general_ci
where ventas.id_venta = vent;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Ventas_GetTotal` (IN `fecha` DATE, IN `dia` INT, IN `mes` INT, IN `anio` INT, IN `sede` INT)  BEGIN
if fecha = '0-0-0' and dia = 0 and mes = 0 and anio = 0 and sede = 0 then 
#Todas las ventas
SELECT
ifnull(sum(ventas.val_venta), 0) as total
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
order by ventas.facha_venta asc;
elseif fecha = '0-0-0' and dia != 0 and mes = 0 and anio = 0 and sede = 0 then 
#Ventas por dia actual
SELECT
ifnull(sum(ventas.val_venta), 0) as total
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where date(ventas.facha_venta) = date(now())
order by ventas.facha_venta asc;
elseif fecha = '0-0-0' and dia = 0 and mes != 0 and anio = 0 and sede = 0 then 
#Ventas por mes actual
SELECT
ifnull(sum(ventas.val_venta), 0) as total
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where month(ventas.facha_venta) = month(now())
and year(ventas.facha_venta) = year(now())
order by ventas.facha_venta asc;
elseif fecha = '0-0-0' and dia = 0 and mes = 0 and anio != 0 and sede = 0 then 
#Ventas por año actual
SELECT
ifnull(sum(ventas.val_venta), 0) as total
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where year(ventas.facha_venta) = year(now())
order by ventas.facha_venta asc;
elseif fecha != '0-0-0' and dia = 0 and mes = 0 and anio = 0 and sede = 0 then 
#Ventas por fecha
SELECT
ifnull(sum(ventas.val_venta), 0) as total
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where date(ventas.facha_venta) = fecha
order by ventas.facha_venta asc;
elseif fecha = '0-0-0' and dia != 0 and mes = 0 and anio = 0 and sede != 0 then 
#Ventas por dia actual y sede
SELECT
ifnull(sum(ventas.val_venta), 0) as total
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where date(ventas.facha_venta) = date(now())
and ventas.fk_sede = sede
order by ventas.facha_venta asc;
elseif fecha = '0-0-0' and dia = 0 and mes != 0 and anio = 0 and sede != 0 then 
#Ventas por mes actual y sede 
SELECT
ifnull(sum(ventas.val_venta), 0) as total
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where month(ventas.facha_venta) = month(now())
and year(ventas.facha_venta) = year(now())
and ventas.fk_sede = sede
order by ventas.facha_venta asc;
elseif fecha = '0-0-0' and dia = 0 and mes = 0 and anio != 0 and sede != 0 then 
#Ventas por año actual y sede
SELECT
ifnull(sum(ventas.val_venta), 0) as total
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where year(ventas.facha_venta) = year(now())
and ventas.fk_sede = sede
order by ventas.facha_venta asc;
elseif fecha != '0-0-0' and dia = 0 and mes = 0 and anio = 0 and sede != 0 then 
#Ventas por fecha y sede
SELECT
ifnull(sum(ventas.val_venta), 0) as total
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where date(ventas.facha_venta) = fecha
and ventas.fk_sede = sede
order by ventas.facha_venta asc;
else
SELECT 0 as total;
END IF;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Ventas_GetXFilt` (IN `mes` INT, IN `anio` INT, IN `sede` INT)  BEGIN
if mes = 0 and anio = 0 and sede = 0 then
SELECT
ventas.id_venta,
ventas.num_factura,
ventas.cant_productos,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta,
date(ventas.facha_venta) as fecha,
time(ventas.facha_venta) as hora
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
order by ventas.facha_venta asc;
elseif mes != 0 and anio != 0 and sede = 0 then 
#Ventas por mes filtro
SELECT
ventas.id_venta,
ventas.num_factura,
ventas.cant_productos,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta,
date(ventas.facha_venta) as fecha,
time(ventas.facha_venta) as hora
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where month(ventas.facha_venta) = mes 
and year(ventas.facha_venta) = anio
order by ventas.facha_venta asc;
elseif mes = 0 and anio != 0 and sede = 0 then 
#Ventas por año filtro
SELECT
ventas.id_venta,
ventas.num_factura,
ventas.cant_productos,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta,
date(ventas.facha_venta) as fecha,
time(ventas.facha_venta) as hora
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where  year(ventas.facha_venta) = anio
order by ventas.facha_venta asc;
elseif mes = 0 and anio = 0 and sede != 0 then 
#Ventas por sede filtro
SELECT
ventas.id_venta,
ventas.num_factura,
ventas.cant_productos,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta,
date(ventas.facha_venta) as fecha,
time(ventas.facha_venta) as hora
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where ventas.fk_sede = sede
order by ventas.facha_venta asc;
elseif mes = 0 and anio != 0 and sede != 0 then 
#Ventas por año y sede filtro
SELECT
ventas.id_venta,
ventas.num_factura,
ventas.cant_productos,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta,
date(ventas.facha_venta) as fecha,
time(ventas.facha_venta) as hora
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where  year(ventas.facha_venta) = anio
and ventas.fk_sede = sede
order by ventas.facha_venta asc;
elseif mes != 0 and anio != 0 and sede != 0 then 
#Ventas por mes y sede filtro
SELECT
ventas.id_venta,
ventas.num_factura,
ventas.cant_productos,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta,
date(ventas.facha_venta) as fecha,
time(ventas.facha_venta) as hora
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where month(ventas.facha_venta) = mes 
and year(ventas.facha_venta) = anio
and ventas.fk_sede = sede
order by ventas.facha_venta asc;
else
SELECT 'Filtro no encontrado' as nom_producto;
END IF;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Ventas_GetXFiltTotal` (IN `mes` INT, IN `anio` INT, IN `sede` INT)  BEGIN
if mes = 0 and anio = 0 and sede = 0 then
SELECT
ifnull(sum(ventas.val_venta), 0) as total
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
order by ventas.facha_venta asc;
elseif mes != 0 and anio != 0 and sede = 0 then 
#Ventas por mes filtro
SELECT
ifnull(sum(ventas.val_venta), 0) as total
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where month(ventas.facha_venta) = mes 
and year(ventas.facha_venta) = anio
order by ventas.facha_venta asc;
elseif mes = 0 and anio != 0 and sede = 0 then 
#Ventas por año filtro
SELECT
ifnull(sum(ventas.val_venta), 0) as total
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where  year(ventas.facha_venta) = anio
order by ventas.facha_venta asc;
elseif mes = 0 and anio = 0 and sede != 0 then 
#Ventas por sede filtro
SELECT
ifnull(sum(ventas.val_venta), 0) as total
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where ventas.fk_sede = sede
order by ventas.facha_venta asc;
elseif mes = 0 and anio != 0 and sede != 0 then 
#Ventas por año y sede filtro
SELECT
ifnull(sum(ventas.val_venta), 0) as total
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where  year(ventas.facha_venta) = anio
and ventas.fk_sede = sede
order by ventas.facha_venta asc;
elseif mes != 0 and anio != 0 and sede != 0 then 
#Ventas por mes y sede filtro
SELECT
ifnull(sum(ventas.val_venta), 0) as total
FROM ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where month(ventas.facha_venta) = mes 
and year(ventas.facha_venta) = anio
and ventas.fk_sede = sede
order by ventas.facha_venta asc;
else
SELECT 0 as total;
END IF;
END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `Ventas_GetXId` (IN `id` INT)  BEGIN
select
ventas.id_venta,
ventas.cant_productos,
ventas.num_factura,
sedes.nom_sede,
consumo.nom_consumo,
medio_pago.nommedio_pago,
entidadespago.nom_entidad,
ventas.val_venta
from ventas
inner join sedes on sedes.id_sede = ventas.fk_sede
inner join consumo on consumo.id_consumo = ventas.fk_consumo
inner join medio_pago on medio_pago.idmedio_pago = ventas.fk_pago
inner join entidadespago on entidadespago.id_entidad = ventas.fk_entidad
where ventas.id_venta = id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alertas`
--

CREATE TABLE `alertas` (
  `id_alerta` int(11) NOT NULL,
  `nom_alerta` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `desc_alerta` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `fk_estado` int(11) NOT NULL,
  `fk_usuario` int(11) NOT NULL,
  `fecha_alerta` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `alertas`
--

INSERT INTO `alertas` (`id_alerta`, `nom_alerta`, `desc_alerta`, `fk_estado`, `fk_usuario`, `fecha_alerta`) VALUES
(289, 'Movimiento de caja', 'se ha cerrado caja de Shake It Bogotá con dinero en caja de 0', 1, 2, '2019-06-12 01:57:07'),
(290, 'Movimiento de caja', 'se ha cerrado caja de Shake It Bogotá con dinero en caja de 0', 0, 5, '2019-06-12 01:57:07'),
(291, 'Movimiento de caja', 'se ha cerrado caja de Shake It Valledupar con dinero en caja de 0', 1, 2, '2019-06-15 09:22:43'),
(292, 'Movimiento de caja', 'se ha cerrado caja de Shake It Valledupar con dinero en caja de 0', 0, 5, '2019-06-15 09:22:43'),
(293, 'Movimiento de caja', 'se ha abierto caja de Shake It Valledupar con dinero en caja de 200000', 0, 2, '2019-06-15 10:01:54'),
(294, 'Movimiento de caja', 'se ha abierto caja de Shake It Valledupar con dinero en caja de 200000', 0, 5, '2019-06-15 10:01:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `caja`
--

CREATE TABLE `caja` (
  `id_caja` int(11) NOT NULL,
  `valor_caja` double NOT NULL,
  `estado_caja` int(11) NOT NULL,
  `sede_caja` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `caja`
--

INSERT INTO `caja` (`id_caja`, `valor_caja`, `estado_caja`, `sede_caja`) VALUES
(5, 0, 4, 7),
(6, 200000, 5, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `idcategoria` int(11) NOT NULL,
  `nomcategoria` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `tipcategoria` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`idcategoria`, `nomcategoria`, `tipcategoria`) VALUES
(1, 'Adicionales', 0),
(2, 'Bebidas De Café', 1),
(3, 'Complementos', 0),
(4, 'Frappés', 1),
(5, 'Frutas', 0),
(6, 'Ingredientes', 0),
(7, 'Milkshakes', 1),
(8, 'Otros Productos', 1),
(9, 'Smoothies', 1),
(10, 'Tamaño-Base', 0),
(11, 'Extras', 1),
(12, 'Malteadas', 1),
(13, 'Comidas', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id_cliente` int(11) NOT NULL,
  `nom_cliente` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `ape_cliente` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `dir_cliente` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `barrio_cliente` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `fk_municipio` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `tel_cliente` double NOT NULL,
  `us_cliente` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `pass_cliente` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `email_cliente` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `nac_cliente` date DEFAULT NULL,
  `registro_cliente` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT 'Local',
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cms_ambientes`
--

CREATE TABLE `cms_ambientes` (
  `id_ambiente` int(11) NOT NULL,
  `nom_ambiente` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cms_archivos`
--

CREATE TABLE `cms_archivos` (
  `id_archivo` int(11) NOT NULL,
  `path_archivo` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `posicion_archivo` int(11) NOT NULL,
  `fk_idencontenido` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cms_categorias`
--

CREATE TABLE `cms_categorias` (
  `id_categoria` int(11) NOT NULL,
  `nom_categoria` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cms_contenido`
--

CREATE TABLE `cms_contenido` (
  `id_cms` int(11) NOT NULL,
  `titulo_cms` varchar(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `contenido_cms` varchar(5600) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `infoadcional_cms` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `infoextra_cms` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `path_cms` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha_cms` datetime DEFAULT NULL,
  `fk_tipocontenido` int(11) DEFAULT NULL,
  `fk_seccion` int(11) DEFAULT NULL,
  `jerarquia_cms` int(11) DEFAULT NULL,
  `fk_estado` int(11) DEFAULT NULL,
  `fk_ambiente` int(11) DEFAULT '1',
  `fk_categoria` int(11) DEFAULT NULL,
  `iden_cms` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cms_seccion`
--

CREATE TABLE `cms_seccion` (
  `id_seccion` int(11) NOT NULL,
  `nom_seccion` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cms_tipoconenido`
--

CREATE TABLE `cms_tipoconenido` (
  `id_tipoconenido` int(11) NOT NULL,
  `nom_tipoconenido` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comun_estados`
--

CREATE TABLE `comun_estados` (
  `idcomun_estado` int(11) NOT NULL,
  `nomcomun_estado` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `fk_tipo` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `comun_estados`
--

INSERT INTO `comun_estados` (`idcomun_estado`, `nomcomun_estado`, `fk_tipo`) VALUES
(1, 'Activo', 1),
(2, 'Inactivo', 1),
(3, 'Sin Especificar', 1),
(4, 'Abierta', 4),
(5, 'Cerrada', 4),
(6, 'Revisado', 1),
(7, 'Sin Revisar', 1),
(8, 'Pendiente', 1),
(9, 'Contestado', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consumo`
--

CREATE TABLE `consumo` (
  `id_consumo` int(11) NOT NULL,
  `nom_consumo` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `consumo`
--

INSERT INTO `consumo` (`id_consumo`, `nom_consumo`) VALUES
(1, 'Domicilio'),
(2, 'Para llevar'),
(3, 'Local');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contacto`
--

CREATE TABLE `contacto` (
  `con_id` int(11) NOT NULL,
  `con_nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `con_email` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `con_mensaje` varchar(3000) COLLATE utf8_spanish_ci NOT NULL,
  `con_fecha` date NOT NULL,
  `con_estado` varchar(45) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

CREATE TABLE `departamentos` (
  `id_departamento` int(11) NOT NULL,
  `nom_departamento` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`id_departamento`, `nom_departamento`) VALUES
(5, 'ANTIOQUIA'),
(8, 'ATLÁNTICO'),
(11, 'BOGOTÁ, D.C.'),
(13, 'BOLÍVAR'),
(15, 'BOYACÁ'),
(17, 'CALDAS'),
(18, 'CAQUETÁ'),
(19, 'CAUCA'),
(20, 'CESAR'),
(23, 'CÓRDOBA'),
(25, 'CUNDINAMARCA'),
(27, 'CHOCÓ'),
(41, 'HUILA'),
(44, 'LA GUAJIRA'),
(47, 'MAGDALENA'),
(50, 'META'),
(52, 'NARIÑO'),
(54, 'NORTE DE SANTANDER'),
(63, 'QUINDIO'),
(66, 'RISARALDA'),
(68, 'SANTANDER'),
(70, 'SUCRE'),
(73, 'TOLIMA'),
(76, 'VALLE DEL CAUCA'),
(81, 'ARAUCA'),
(85, 'CASANARE'),
(86, 'PUTUMAYO'),
(88, 'ARCHIPIÉLAGO DE SAN ANDRÉS, PROVIDENCIA Y SANTA CATALINA'),
(91, 'AMAZONAS'),
(94, 'GUAINÍA'),
(95, 'GUAVIARE'),
(97, 'VAUPÉS'),
(99, 'VICHADA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entidadespago`
--

CREATE TABLE `entidadespago` (
  `id_entidad` int(11) NOT NULL,
  `nom_entidad` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `entidadespago`
--

INSERT INTO `entidadespago` (`id_entidad`, `nom_entidad`) VALUES
(1, 'Bancolombia'),
(2, 'Davivienda'),
(3, 'Domicilios.com'),
(4, 'iFood'),
(5, 'Efectivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados_generales`
--

CREATE TABLE `estados_generales` (
  `idestado` int(11) NOT NULL,
  `nom_estado` varchar(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `fk_tipo` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `estados_generales`
--

INSERT INTO `estados_generales` (`idestado`, `nom_estado`, `fk_tipo`) VALUES
(1, 'Activo', 1),
(2, 'Inactivo', 1),
(3, 'Sin Especificar', 1),
(4, 'Abierta', 4),
(5, 'Cerrada', 4),
(6, 'Revisado', 1),
(7, 'Sin Revisar', 1),
(8, 'Pendiente', 1),
(9, 'Contestado', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estados_tipo`
--

CREATE TABLE `estados_tipo` (
  `id_tipo` int(11) NOT NULL,
  `nombre_tipo` varchar(45) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `estados_tipo`
--

INSERT INTO `estados_tipo` (`id_tipo`, `nombre_tipo`) VALUES
(1, 'Comunes'),
(2, 'Pedidos'),
(3, 'Mensajes'),
(4, 'Caja');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumos`
--

CREATE TABLE `insumos` (
  `id_insumo` int(11) NOT NULL,
  `nom_insumo` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `fk_unidad` int(11) DEFAULT NULL,
  `cantmin_insumo` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `insumos`
--

INSERT INTO `insumos` (`id_insumo`, `nom_insumo`, `fk_unidad`, `cantmin_insumo`) VALUES
(13, 'Oreo', 1, '10.00'),
(14, 'Cocosette', 1, '20.00'),
(15, 'Vainilla 9oz', 3, '1.00'),
(16, 'Leche', 4, '10.00'),
(17, 'Arequipe', 1, '30.00'),
(19, 'Ferrero', 1, '30.00'),
(20, 'M&M', 1, '2.00'),
(21, 'Noggy', 2, '20.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumos_rel`
--

CREATE TABLE `insumos_rel` (
  `fk_producto` int(11) NOT NULL,
  `fk_insumo` int(11) NOT NULL,
  `insumoUnidad_rel` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `insumos_rel`
--

INSERT INTO `insumos_rel` (`fk_producto`, `fk_insumo`, `insumoUnidad_rel`) VALUES
(68, 13, '1.00'),
(68, 15, '200.00'),
(68, 17, '10.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumos_vendidos`
--

CREATE TABLE `insumos_vendidos` (
  `id_insumosv` int(11) NOT NULL,
  `fk_insumo` int(11) DEFAULT NULL,
  `cant_insumosv` int(11) DEFAULT NULL,
  `fecha_insumosv` datetime DEFAULT NULL,
  `fk_sede` int(11) DEFAULT NULL,
  `web` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id_inventario` int(11) NOT NULL,
  `fk_insumo` int(11) NOT NULL,
  `cantidad_inventario` decimal(10,2) NOT NULL,
  `fecha_inventario` datetime NOT NULL,
  `sede_inventario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id_inventario`, `fk_insumo`, `cantidad_inventario`, `fecha_inventario`, `sede_inventario`) VALUES
(24, 17, '6000.00', '2019-10-09 12:18:26', 2),
(25, 17, '5000.00', '2019-06-15 10:16:57', 3),
(26, 17, '5000.00', '2019-06-15 10:16:57', 5),
(27, 17, '5000.00', '2019-06-15 10:16:57', 1),
(28, 16, '2000.00', '2019-06-15 10:21:32', 2),
(29, 16, '2000.00', '2019-06-15 10:21:32', 3),
(30, 16, '2000.00', '2019-06-15 10:21:32', 5),
(31, 16, '2000.00', '2019-06-15 10:21:33', 1),
(32, 13, '200.00', '2019-06-15 10:23:51', 2),
(33, 13, '200.00', '2019-06-15 10:23:51', 3),
(34, 13, '200.00', '2019-06-15 10:23:51', 5),
(35, 13, '200.00', '2019-06-15 10:23:51', 1),
(36, 15, '5000.00', '2019-06-15 10:48:28', 1),
(37, 19, '150.00', '2019-10-08 10:13:19', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_dia`
--

CREATE TABLE `inventario_dia` (
  `id_inventario` int(11) NOT NULL,
  `fk_insumo` int(11) DEFAULT NULL,
  `cantidad1_inventario` int(11) DEFAULT NULL,
  `fecha1_inventario` datetime DEFAULT NULL,
  `cantidad2_inventario` int(11) DEFAULT NULL,
  `fecha2_inventario` datetime DEFAULT NULL,
  `fecha_inventario` datetime DEFAULT NULL,
  `fk_inventarioiden` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `inventario_dia`
--

INSERT INTO `inventario_dia` (`id_inventario`, `fk_insumo`, `cantidad1_inventario`, `fecha1_inventario`, `cantidad2_inventario`, `fecha2_inventario`, `fecha_inventario`, `fk_inventarioiden`) VALUES
(7, 13, 20, '2019-06-15 09:59:13', 20, '2019-06-15 16:43:58', '2019-06-15 09:59:13', 'shsed119615'),
(8, 14, 12, '2019-06-15 09:59:22', NULL, NULL, '2019-06-15 09:59:22', 'shsed119615'),
(9, 15, 4000, '2019-06-15 09:59:39', NULL, NULL, '2019-06-15 09:59:39', 'shsed119615'),
(10, 17, 500, '2019-06-15 09:59:55', NULL, NULL, '2019-06-15 09:59:55', 'shsed119615'),
(11, 17, 500, '2019-07-21 18:00:28', NULL, NULL, '2019-07-21 18:00:28', 'shsed119721');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_identificador`
--

CREATE TABLE `inventario_identificador` (
  `id_identificador` int(11) NOT NULL,
  `iden_identificador` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `fk_sede` int(11) DEFAULT NULL,
  `fk_estado` int(11) DEFAULT NULL,
  `fecha_identificador` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `inventario_identificador`
--

INSERT INTO `inventario_identificador` (`id_identificador`, `iden_identificador`, `fk_sede`, `fk_estado`, `fecha_identificador`) VALUES
(7, 'shsed719612', 7, 4, '2019-06-12 06:41:17'),
(8, 'shsed119615', 1, 5, '2019-06-15 09:33:51'),
(9, 'shsed719617', 7, 4, '2019-06-17 06:59:00'),
(10, 'shsed119721', 1, 4, '2019-07-21 18:00:13');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario_movimientos`
--

CREATE TABLE `inventario_movimientos` (
  `idmovimiento` int(11) NOT NULL,
  `fktipo_movimiento` int(11) DEFAULT NULL,
  `descripcion_movimiento` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `fkusuario_movimiento` int(11) DEFAULT NULL,
  `fksede_movimiento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medio_pago`
--

CREATE TABLE `medio_pago` (
  `idmedio_pago` int(11) NOT NULL,
  `nommedio_pago` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `medio_pago`
--

INSERT INTO `medio_pago` (`idmedio_pago`, `nommedio_pago`) VALUES
(1, 'Efectivo'),
(2, 'Electrónico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `meses`
--

CREATE TABLE `meses` (
  `id_mes` int(11) NOT NULL,
  `nom_mes` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `meses`
--

INSERT INTO `meses` (`id_mes`, `nom_mes`) VALUES
(1, 'Enero'),
(2, 'Febrero'),
(3, 'Marzo'),
(4, 'Abril'),
(5, 'Mayo'),
(6, 'Junio'),
(7, 'Julio'),
(8, 'Agosto'),
(9, 'Septiembre'),
(10, 'Octubre'),
(11, 'Noviembre'),
(12, 'Diciembre');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos`
--

CREATE TABLE `movimientos` (
  `id_movimiento` int(11) NOT NULL,
  `fk_tipo` int(11) NOT NULL,
  `fk_concepto` int(11) NOT NULL,
  `val_movimiento` double NOT NULL,
  `fk_usuario` int(11) DEFAULT NULL,
  `fk_sede` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos_concepto`
--

CREATE TABLE `movimientos_concepto` (
  `id_concepto` int(11) NOT NULL,
  `nom_concepto` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos_tipo`
--

CREATE TABLE `movimientos_tipo` (
  `id_tipo` int(11) NOT NULL,
  `nom_tipo` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `municipios`
--

CREATE TABLE `municipios` (
  `id_municipio` int(11) NOT NULL,
  `nom_municipio` varchar(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `fk_estado` int(11) DEFAULT NULL,
  `fk_departamento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `municipios`
--

INSERT INTO `municipios` (`id_municipio`, `nom_municipio`, `fk_estado`, `fk_departamento`) VALUES
(1, 'Abriaquí', 1, 5),
(2, 'Acacías', 1, 50),
(3, 'Acandí', 1, 27),
(4, 'Acevedo', 1, 41),
(5, 'Achí', 1, 13),
(6, 'Agrado', 1, 41),
(7, 'Agua de Dios', 1, 25),
(8, 'Aguachica', 1, 20),
(9, 'Aguada', 1, 68),
(10, 'Aguadas', 1, 17),
(11, 'Aguazul', 1, 85),
(12, 'Agustín Codazzi', 1, 20),
(13, 'Aipe', 1, 41),
(14, 'Albania', 1, 18),
(15, 'Albania', 1, 44),
(16, 'Albania', 1, 68),
(17, 'Albán', 1, 25),
(18, 'Albán (San José)', 1, 52),
(19, 'Alcalá', 1, 76),
(20, 'Alejandria', 1, 5),
(21, 'Algarrobo', 1, 47),
(22, 'Algeciras', 1, 41),
(23, 'Almaguer', 1, 19),
(24, 'Almeida', 1, 15),
(25, 'Alpujarra', 1, 73),
(26, 'Altamira', 1, 41),
(27, 'Alto Baudó (Pie de Pato)', 1, 27),
(28, 'Altos del Rosario', 1, 13),
(29, 'Alvarado', 1, 73),
(30, 'Amagá', 1, 5),
(31, 'Amalfi', 1, 5),
(32, 'Ambalema', 1, 73),
(33, 'Anapoima', 1, 25),
(34, 'Ancuya', 1, 52),
(35, 'Andalucía', 1, 76),
(36, 'Andes', 1, 5),
(37, 'Angelópolis', 1, 5),
(38, 'Angostura', 1, 5),
(39, 'Anolaima', 1, 25),
(40, 'Anorí', 1, 5),
(41, 'Anserma', 1, 17),
(42, 'Ansermanuevo', 1, 76),
(43, 'Anzoátegui', 1, 73),
(44, 'Anzá', 1, 5),
(45, 'Apartadó', 1, 5),
(46, 'Apulo', 1, 25),
(47, 'Apía', 1, 66),
(48, 'Aquitania', 1, 15),
(49, 'Aracataca', 1, 47),
(50, 'Aranzazu', 1, 17),
(51, 'Aratoca', 1, 68),
(52, 'Arauca', 1, 81),
(53, 'Arauquita', 1, 81),
(54, 'Arbeláez', 1, 25),
(55, 'Arboleda (Berruecos)', 1, 52),
(56, 'Arboledas', 1, 54),
(57, 'Arboletes', 1, 5),
(58, 'Arcabuco', 1, 15),
(59, 'Arenal', 1, 13),
(60, 'Argelia', 1, 5),
(61, 'Argelia', 1, 19),
(62, 'Argelia', 1, 76),
(63, 'Ariguaní (El Difícil)', 1, 47),
(64, 'Arjona', 1, 13),
(65, 'Armenia', 1, 5),
(66, 'Armenia', 1, 63),
(67, 'Armero (Guayabal)', 1, 73),
(68, 'Arroyohondo', 1, 13),
(69, 'Astrea', 1, 20),
(70, 'Ataco', 1, 73),
(71, 'Atrato (Yuto)', 1, 27),
(72, 'Ayapel', 1, 23),
(73, 'Bagadó', 1, 27),
(74, 'Bahía Solano (Mútis)', 1, 27),
(75, 'Bajo Baudó (Pizarro)', 1, 27),
(76, 'Balboa', 1, 19),
(77, 'Balboa', 1, 66),
(78, 'Baranoa', 1, 8),
(79, 'Baraya', 1, 41),
(80, 'Barbacoas', 1, 52),
(81, 'Barbosa', 1, 5),
(82, 'Barbosa', 1, 68),
(83, 'Barichara', 1, 68),
(84, 'Barranca de Upía', 1, 50),
(85, 'Barrancabermeja', 1, 68),
(86, 'Barrancas', 1, 44),
(87, 'Barranco de Loba', 1, 13),
(88, 'Barranquilla', 1, 8),
(89, 'Becerríl', 1, 20),
(90, 'Belalcázar', 1, 17),
(91, 'Bello', 1, 5),
(92, 'Belmira', 1, 5),
(93, 'Beltrán', 1, 25),
(94, 'Belén', 1, 15),
(95, 'Belén', 1, 52),
(96, 'Belén de Bajirá', 1, 27),
(97, 'Belén de Umbría', 1, 66),
(98, 'Belén de los Andaquíes', 1, 18),
(99, 'Berbeo', 1, 15),
(100, 'Betania', 1, 5),
(101, 'Beteitiva', 1, 15),
(102, 'Betulia', 1, 5),
(103, 'Betulia', 1, 68),
(104, 'Bituima', 1, 25),
(105, 'Boavita', 1, 15),
(106, 'Bochalema', 1, 54),
(107, 'Bogotá D.C.', 1, 11),
(108, 'Bojacá', 1, 25),
(109, 'Bojayá (Bellavista)', 1, 27),
(110, 'Bolívar', 1, 5),
(111, 'Bolívar', 1, 19),
(112, 'Bolívar', 1, 68),
(113, 'Bolívar', 1, 76),
(114, 'Bosconia', 1, 20),
(115, 'Boyacá', 1, 15),
(116, 'Briceño', 1, 5),
(117, 'Briceño', 1, 15),
(118, 'Bucaramanga', 1, 68),
(119, 'Bucarasica', 1, 54),
(120, 'Buenaventura', 1, 76),
(121, 'Buenavista', 1, 15),
(122, 'Buenavista', 1, 23),
(123, 'Buenavista', 1, 63),
(124, 'Buenavista', 1, 70),
(125, 'Buenos Aires', 1, 19),
(126, 'Buesaco', 1, 52),
(127, 'Buga', 1, 76),
(128, 'Bugalagrande', 1, 76),
(129, 'Burítica', 1, 5),
(130, 'Busbanza', 1, 15),
(131, 'Cabrera', 1, 25),
(132, 'Cabrera', 1, 68),
(133, 'Cabuyaro', 1, 50),
(134, 'Cachipay', 1, 25),
(135, 'Caicedo', 1, 5),
(136, 'Caicedonia', 1, 76),
(137, 'Caimito', 1, 70),
(138, 'Cajamarca', 1, 73),
(139, 'Cajibío', 1, 19),
(140, 'Cajicá', 1, 25),
(141, 'Calamar', 1, 13),
(142, 'Calamar', 1, 95),
(143, 'Calarcá', 1, 63),
(144, 'Caldas', 1, 5),
(145, 'Caldas', 1, 15),
(146, 'Caldono', 1, 19),
(147, 'California', 1, 68),
(148, 'Calima (Darién)', 1, 76),
(149, 'Caloto', 1, 19),
(150, 'Calí', 1, 76),
(151, 'Campamento', 1, 5),
(152, 'Campo de la Cruz', 1, 8),
(153, 'Campoalegre', 1, 41),
(154, 'Campohermoso', 1, 15),
(155, 'Canalete', 1, 23),
(156, 'Candelaria', 1, 8),
(157, 'Candelaria', 1, 76),
(158, 'Cantagallo', 1, 13),
(159, 'Cantón de San Pablo', 1, 27),
(160, 'Caparrapí', 1, 25),
(161, 'Capitanejo', 1, 68),
(162, 'Caracolí', 1, 5),
(163, 'Caramanta', 1, 5),
(164, 'Carcasí', 1, 68),
(165, 'Carepa', 1, 5),
(166, 'Carmen de Apicalá', 1, 73),
(167, 'Carmen de Carupa', 1, 25),
(168, 'Carmen de Viboral', 1, 5),
(169, 'Carmen del Darién (CURBARADÓ)', 1, 27),
(170, 'Carolina', 1, 5),
(171, 'Cartagena', 1, 13),
(172, 'Cartagena del Chairá', 1, 18),
(173, 'Cartago', 1, 76),
(174, 'Carurú', 1, 97),
(175, 'Casabianca', 1, 73),
(176, 'Castilla la Nueva', 1, 50),
(177, 'Caucasia', 1, 5),
(178, 'Cañasgordas', 1, 5),
(179, 'Cepita', 1, 68),
(180, 'Cereté', 1, 23),
(181, 'Cerinza', 1, 15),
(182, 'Cerrito', 1, 68),
(183, 'Cerro San Antonio', 1, 47),
(184, 'Chachaguí', 1, 52),
(185, 'Chaguaní', 1, 25),
(186, 'Chalán', 1, 70),
(187, 'Chaparral', 1, 73),
(188, 'Charalá', 1, 68),
(189, 'Charta', 1, 68),
(190, 'Chigorodó', 1, 5),
(191, 'Chima', 1, 68),
(192, 'Chimichagua', 1, 20),
(193, 'Chimá', 1, 23),
(194, 'Chinavita', 1, 15),
(195, 'Chinchiná', 1, 17),
(196, 'Chinácota', 1, 54),
(197, 'Chinú', 1, 23),
(198, 'Chipaque', 1, 25),
(199, 'Chipatá', 1, 68),
(200, 'Chiquinquirá', 1, 15),
(201, 'Chiriguaná', 1, 20),
(202, 'Chiscas', 1, 15),
(203, 'Chita', 1, 15),
(204, 'Chitagá', 1, 54),
(205, 'Chitaraque', 1, 15),
(206, 'Chivatá', 1, 15),
(207, 'Chivolo', 1, 47),
(208, 'Choachí', 1, 25),
(209, 'Chocontá', 1, 25),
(210, 'Chámeza', 1, 85),
(211, 'Chía', 1, 25),
(212, 'Chíquiza', 1, 15),
(213, 'Chívor', 1, 15),
(214, 'Cicuco', 1, 13),
(215, 'Cimitarra', 1, 68),
(216, 'Circasia', 1, 63),
(217, 'Cisneros', 1, 5),
(218, 'Ciénaga', 1, 15),
(219, 'Ciénaga', 1, 47),
(220, 'Ciénaga de Oro', 1, 23),
(221, 'Clemencia', 1, 13),
(222, 'Cocorná', 1, 5),
(223, 'Coello', 1, 73),
(224, 'Cogua', 1, 25),
(225, 'Colombia', 1, 41),
(226, 'Colosó (Ricaurte)', 1, 70),
(227, 'Colón', 1, 86),
(228, 'Colón (Génova)', 1, 52),
(229, 'Concepción', 1, 5),
(230, 'Concepción', 1, 68),
(231, 'Concordia', 1, 5),
(232, 'Concordia', 1, 47),
(233, 'Condoto', 1, 27),
(234, 'Confines', 1, 68),
(235, 'Consaca', 1, 52),
(236, 'Contadero', 1, 52),
(237, 'Contratación', 1, 68),
(238, 'Convención', 1, 54),
(239, 'Copacabana', 1, 5),
(240, 'Coper', 1, 15),
(241, 'Cordobá', 1, 63),
(242, 'Corinto', 1, 19),
(243, 'Coromoro', 1, 68),
(244, 'Corozal', 1, 70),
(245, 'Corrales', 1, 15),
(246, 'Cota', 1, 25),
(247, 'Cotorra', 1, 23),
(248, 'Covarachía', 1, 15),
(249, 'Coveñas', 1, 70),
(250, 'Coyaima', 1, 73),
(251, 'Cravo Norte', 1, 81),
(252, 'Cuaspud (Carlosama)', 1, 52),
(253, 'Cubarral', 1, 50),
(254, 'Cubará', 1, 15),
(255, 'Cucaita', 1, 15),
(256, 'Cucunubá', 1, 25),
(257, 'Cucutilla', 1, 54),
(258, 'Cuitiva', 1, 15),
(259, 'Cumaral', 1, 50),
(260, 'Cumaribo', 1, 99),
(261, 'Cumbal', 1, 52),
(262, 'Cumbitara', 1, 52),
(263, 'Cunday', 1, 73),
(264, 'Curillo', 1, 18),
(265, 'Curití', 1, 68),
(266, 'Curumaní', 1, 20),
(267, 'Cáceres', 1, 5),
(268, 'Cáchira', 1, 54),
(269, 'Cácota', 1, 54),
(270, 'Cáqueza', 1, 25),
(271, 'Cértegui', 1, 27),
(272, 'Cómbita', 1, 15),
(273, 'Córdoba', 1, 13),
(274, 'Córdoba', 1, 52),
(275, 'Cúcuta', 1, 54),
(276, 'Dabeiba', 1, 5),
(277, 'Dagua', 1, 76),
(278, 'Dibulla', 1, 44),
(279, 'Distracción', 1, 44),
(280, 'Dolores', 1, 73),
(281, 'Don Matías', 1, 5),
(282, 'Dos Quebradas', 1, 66),
(283, 'Duitama', 1, 15),
(284, 'Durania', 1, 54),
(285, 'Ebéjico', 1, 5),
(286, 'El Bagre', 1, 5),
(287, 'El Banco', 1, 47),
(288, 'El Cairo', 1, 76),
(289, 'El Calvario', 1, 50),
(290, 'El Carmen', 1, 54),
(291, 'El Carmen', 1, 68),
(292, 'El Carmen de Atrato', 1, 27),
(293, 'El Carmen de Bolívar', 1, 13),
(294, 'El Castillo', 1, 50),
(295, 'El Cerrito', 1, 76),
(296, 'El Charco', 1, 52),
(297, 'El Cocuy', 1, 15),
(298, 'El Colegio', 1, 25),
(299, 'El Copey', 1, 20),
(300, 'El Doncello', 1, 18),
(301, 'El Dorado', 1, 50),
(302, 'El Dovio', 1, 76),
(303, 'El Espino', 1, 15),
(304, 'El Guacamayo', 1, 68),
(305, 'El Guamo', 1, 13),
(306, 'El Molino', 1, 44),
(307, 'El Paso', 1, 20),
(308, 'El Paujil', 1, 18),
(309, 'El Peñol', 1, 52),
(310, 'El Peñon', 1, 13),
(311, 'El Peñon', 1, 68),
(312, 'El Peñón', 1, 25),
(313, 'El Piñon', 1, 47),
(314, 'El Playón', 1, 68),
(315, 'El Retorno', 1, 95),
(316, 'El Retén', 1, 47),
(317, 'El Roble', 1, 70),
(318, 'El Rosal', 1, 25),
(319, 'El Rosario', 1, 52),
(320, 'El Tablón de Gómez', 1, 52),
(321, 'El Tambo', 1, 19),
(322, 'El Tambo', 1, 52),
(323, 'El Tarra', 1, 54),
(324, 'El Zulia', 1, 54),
(325, 'El Águila', 1, 76),
(326, 'Elías', 1, 41),
(327, 'Encino', 1, 68),
(328, 'Enciso', 1, 68),
(329, 'Entrerríos', 1, 5),
(330, 'Envigado', 1, 5),
(331, 'Espinal', 1, 73),
(332, 'Facatativá', 1, 25),
(333, 'Falan', 1, 73),
(334, 'Filadelfia', 1, 17),
(335, 'Filandia', 1, 63),
(336, 'Firavitoba', 1, 15),
(337, 'Flandes', 1, 73),
(338, 'Florencia', 1, 18),
(339, 'Florencia', 1, 19),
(340, 'Floresta', 1, 15),
(341, 'Florida', 1, 76),
(342, 'Floridablanca', 1, 68),
(343, 'Florián', 1, 68),
(344, 'Fonseca', 1, 44),
(345, 'Fortúl', 1, 81),
(346, 'Fosca', 1, 25),
(347, 'Francisco Pizarro', 1, 52),
(348, 'Fredonia', 1, 5),
(349, 'Fresno', 1, 73),
(350, 'Frontino', 1, 5),
(351, 'Fuente de Oro', 1, 50),
(352, 'Fundación', 1, 47),
(353, 'Funes', 1, 52),
(354, 'Funza', 1, 25),
(355, 'Fusagasugá', 1, 25),
(356, 'Fómeque', 1, 25),
(357, 'Fúquene', 1, 25),
(358, 'Gachalá', 1, 25),
(359, 'Gachancipá', 1, 25),
(360, 'Gachantivá', 1, 15),
(361, 'Gachetá', 1, 25),
(362, 'Galapa', 1, 8),
(363, 'Galeras (Nueva Granada)', 1, 70),
(364, 'Galán', 1, 68),
(365, 'Gama', 1, 25),
(366, 'Gamarra', 1, 20),
(367, 'Garagoa', 1, 15),
(368, 'Garzón', 1, 41),
(369, 'Gigante', 1, 41),
(370, 'Ginebra', 1, 76),
(371, 'Giraldo', 1, 5),
(372, 'Girardot', 1, 25),
(373, 'Girardota', 1, 5),
(374, 'Girón', 1, 68),
(375, 'Gonzalez', 1, 20),
(376, 'Gramalote', 1, 54),
(377, 'Granada', 1, 5),
(378, 'Granada', 1, 25),
(379, 'Granada', 1, 50),
(380, 'Guaca', 1, 68),
(381, 'Guacamayas', 1, 15),
(382, 'Guacarí', 1, 76),
(383, 'Guachavés', 1, 52),
(384, 'Guachené', 1, 19),
(385, 'Guachetá', 1, 25),
(386, 'Guachucal', 1, 52),
(387, 'Guadalupe', 1, 5),
(388, 'Guadalupe', 1, 41),
(389, 'Guadalupe', 1, 68),
(390, 'Guaduas', 1, 25),
(391, 'Guaitarilla', 1, 52),
(392, 'Gualmatán', 1, 52),
(393, 'Guamal', 1, 47),
(394, 'Guamal', 1, 50),
(395, 'Guamo', 1, 73),
(396, 'Guapota', 1, 68),
(397, 'Guapí', 1, 19),
(398, 'Guaranda', 1, 70),
(399, 'Guarne', 1, 5),
(400, 'Guasca', 1, 25),
(401, 'Guatapé', 1, 5),
(402, 'Guataquí', 1, 25),
(403, 'Guatavita', 1, 25),
(404, 'Guateque', 1, 15),
(405, 'Guavatá', 1, 68),
(406, 'Guayabal de Siquima', 1, 25),
(407, 'Guayabetal', 1, 25),
(408, 'Guayatá', 1, 15),
(409, 'Guepsa', 1, 68),
(410, 'Guicán', 1, 15),
(411, 'Gutiérrez', 1, 25),
(412, 'Guática', 1, 66),
(413, 'Gámbita', 1, 68),
(414, 'Gámeza', 1, 15),
(415, 'Génova', 1, 63),
(416, 'Gómez Plata', 1, 5),
(417, 'Hacarí', 1, 54),
(418, 'Hatillo de Loba', 1, 13),
(419, 'Hato', 1, 68),
(420, 'Hato Corozal', 1, 85),
(421, 'Hatonuevo', 1, 44),
(422, 'Heliconia', 1, 5),
(423, 'Herrán', 1, 54),
(424, 'Herveo', 1, 73),
(425, 'Hispania', 1, 5),
(426, 'Hobo', 1, 41),
(427, 'Honda', 1, 73),
(428, 'Ibagué', 1, 73),
(429, 'Icononzo', 1, 73),
(430, 'Iles', 1, 52),
(431, 'Imúes', 1, 52),
(432, 'Inzá', 1, 19),
(433, 'Inírida', 1, 94),
(434, 'Ipiales', 1, 52),
(435, 'Isnos', 1, 41),
(436, 'Istmina', 1, 27),
(437, 'Itagüí', 1, 5),
(438, 'Ituango', 1, 5),
(439, 'Izá', 1, 15),
(440, 'Jambaló', 1, 19),
(441, 'Jamundí', 1, 76),
(442, 'Jardín', 1, 5),
(443, 'Jenesano', 1, 15),
(444, 'Jericó', 1, 5),
(445, 'Jericó', 1, 15),
(446, 'Jerusalén', 1, 25),
(447, 'Jesús María', 1, 68),
(448, 'Jordán', 1, 68),
(449, 'Juan de Acosta', 1, 8),
(450, 'Junín', 1, 25),
(451, 'Juradó', 1, 27),
(452, 'La Apartada y La Frontera', 1, 23),
(453, 'La Argentina', 1, 41),
(454, 'La Belleza', 1, 68),
(455, 'La Calera', 1, 25),
(456, 'La Capilla', 1, 15),
(457, 'La Ceja', 1, 5),
(458, 'La Celia', 1, 66),
(459, 'La Cruz', 1, 52),
(460, 'La Cumbre', 1, 76),
(461, 'La Dorada', 1, 17),
(462, 'La Esperanza', 1, 54),
(463, 'La Estrella', 1, 5),
(464, 'La Florida', 1, 52),
(465, 'La Gloria', 1, 20),
(466, 'La Jagua de Ibirico', 1, 20),
(467, 'La Jagua del Pilar', 1, 44),
(468, 'La Llanada', 1, 52),
(469, 'La Macarena', 1, 50),
(470, 'La Merced', 1, 17),
(471, 'La Mesa', 1, 25),
(472, 'La Montañita', 1, 18),
(473, 'La Palma', 1, 25),
(474, 'La Paz', 1, 68),
(475, 'La Paz (Robles)', 1, 20),
(476, 'La Peña', 1, 25),
(477, 'La Pintada', 1, 5),
(478, 'La Plata', 1, 41),
(479, 'La Playa', 1, 54),
(480, 'La Primavera', 1, 99),
(481, 'La Salina', 1, 85),
(482, 'La Sierra', 1, 19),
(483, 'La Tebaida', 1, 63),
(484, 'La Tola', 1, 52),
(485, 'La Unión', 1, 5),
(486, 'La Unión', 1, 52),
(487, 'La Unión', 1, 70),
(488, 'La Unión', 1, 76),
(489, 'La Uvita', 1, 15),
(490, 'La Vega', 1, 19),
(491, 'La Vega', 1, 25),
(492, 'La Victoria', 1, 15),
(493, 'La Victoria', 1, 17),
(494, 'La Victoria', 1, 76),
(495, 'La Virginia', 1, 66),
(496, 'Labateca', 1, 54),
(497, 'Labranzagrande', 1, 15),
(498, 'Landázuri', 1, 68),
(499, 'Lebrija', 1, 68),
(500, 'Leiva', 1, 52),
(501, 'Lejanías', 1, 50),
(502, 'Lenguazaque', 1, 25),
(503, 'Leticia', 1, 91),
(504, 'Liborina', 1, 5),
(505, 'Linares', 1, 52),
(506, 'Lloró', 1, 27),
(507, 'Lorica', 1, 23),
(508, 'Los Córdobas', 1, 23),
(509, 'Los Palmitos', 1, 70),
(510, 'Los Patios', 1, 54),
(511, 'Los Santos', 1, 68),
(512, 'Lourdes', 1, 54),
(513, 'Luruaco', 1, 8),
(514, 'Lérida', 1, 73),
(515, 'Líbano', 1, 73),
(516, 'López (Micay)', 1, 19),
(517, 'Macanal', 1, 15),
(518, 'Macaravita', 1, 68),
(519, 'Maceo', 1, 5),
(520, 'Machetá', 1, 25),
(521, 'Madrid', 1, 25),
(522, 'Magangué', 1, 13),
(523, 'Magüi (Payán)', 1, 52),
(524, 'Mahates', 1, 13),
(525, 'Maicao', 1, 44),
(526, 'Majagual', 1, 70),
(527, 'Malambo', 1, 8),
(528, 'Mallama (Piedrancha)', 1, 52),
(529, 'Manatí', 1, 8),
(530, 'Manaure', 1, 44),
(531, 'Manaure Balcón del Cesar', 1, 20),
(532, 'Manizales', 1, 17),
(533, 'Manta', 1, 25),
(534, 'Manzanares', 1, 17),
(535, 'Maní', 1, 85),
(536, 'Mapiripan', 1, 50),
(537, 'Margarita', 1, 13),
(538, 'Marinilla', 1, 5),
(539, 'Maripí', 1, 15),
(540, 'Mariquita', 1, 73),
(541, 'Marmato', 1, 17),
(542, 'Marquetalia', 1, 17),
(543, 'Marsella', 1, 66),
(544, 'Marulanda', 1, 17),
(545, 'María la Baja', 1, 13),
(546, 'Matanza', 1, 68),
(547, 'Medellín', 1, 5),
(548, 'Medina', 1, 25),
(549, 'Medio Atrato', 1, 27),
(550, 'Medio Baudó', 1, 27),
(551, 'Medio San Juan (ANDAGOYA)', 1, 27),
(552, 'Melgar', 1, 73),
(553, 'Mercaderes', 1, 19),
(554, 'Mesetas', 1, 50),
(555, 'Milán', 1, 18),
(556, 'Miraflores', 1, 15),
(557, 'Miraflores', 1, 95),
(558, 'Miranda', 1, 19),
(559, 'Mistrató', 1, 66),
(560, 'Mitú', 1, 97),
(561, 'Mocoa', 1, 86),
(562, 'Mogotes', 1, 68),
(563, 'Molagavita', 1, 68),
(564, 'Momil', 1, 23),
(565, 'Mompós', 1, 13),
(566, 'Mongua', 1, 15),
(567, 'Monguí', 1, 15),
(568, 'Moniquirá', 1, 15),
(569, 'Montebello', 1, 5),
(570, 'Montecristo', 1, 13),
(571, 'Montelíbano', 1, 23),
(572, 'Montenegro', 1, 63),
(573, 'Monteria', 1, 23),
(574, 'Monterrey', 1, 85),
(575, 'Morales', 1, 13),
(576, 'Morales', 1, 19),
(577, 'Morelia', 1, 18),
(578, 'Morroa', 1, 70),
(579, 'Mosquera', 1, 25),
(580, 'Mosquera', 1, 52),
(581, 'Motavita', 1, 15),
(582, 'Moñitos', 1, 23),
(583, 'Murillo', 1, 73),
(584, 'Murindó', 1, 5),
(585, 'Mutatá', 1, 5),
(586, 'Mutiscua', 1, 54),
(587, 'Muzo', 1, 15),
(588, 'Málaga', 1, 68),
(589, 'Nariño', 1, 5),
(590, 'Nariño', 1, 25),
(591, 'Nariño', 1, 52),
(592, 'Natagaima', 1, 73),
(593, 'Nechí', 1, 5),
(594, 'Necoclí', 1, 5),
(595, 'Neira', 1, 17),
(596, 'Neiva', 1, 41),
(597, 'Nemocón', 1, 25),
(598, 'Nilo', 1, 25),
(599, 'Nimaima', 1, 25),
(600, 'Nobsa', 1, 15),
(601, 'Nocaima', 1, 25),
(602, 'Norcasia', 1, 17),
(603, 'Norosí', 1, 13),
(604, 'Novita', 1, 27),
(605, 'Nueva Granada', 1, 47),
(606, 'Nuevo Colón', 1, 15),
(607, 'Nunchía', 1, 85),
(608, 'Nuquí', 1, 27),
(609, 'Nátaga', 1, 41),
(610, 'Obando', 1, 76),
(611, 'Ocamonte', 1, 68),
(612, 'Ocaña', 1, 54),
(613, 'Oiba', 1, 68),
(614, 'Oicatá', 1, 15),
(615, 'Olaya', 1, 5),
(616, 'Olaya Herrera', 1, 52),
(617, 'Onzaga', 1, 68),
(618, 'Oporapa', 1, 41),
(619, 'Orito', 1, 86),
(620, 'Orocué', 1, 85),
(621, 'Ortega', 1, 73),
(622, 'Ospina', 1, 52),
(623, 'Otanche', 1, 15),
(624, 'Ovejas', 1, 70),
(625, 'Pachavita', 1, 15),
(626, 'Pacho', 1, 25),
(627, 'Padilla', 1, 19),
(628, 'Paicol', 1, 41),
(629, 'Pailitas', 1, 20),
(630, 'Paime', 1, 25),
(631, 'Paipa', 1, 15),
(632, 'Pajarito', 1, 15),
(633, 'Palermo', 1, 41),
(634, 'Palestina', 1, 17),
(635, 'Palestina', 1, 41),
(636, 'Palmar', 1, 68),
(637, 'Palmar de Varela', 1, 8),
(638, 'Palmas del Socorro', 1, 68),
(639, 'Palmira', 1, 76),
(640, 'Palmito', 1, 70),
(641, 'Palocabildo', 1, 73),
(642, 'Pamplona', 1, 54),
(643, 'Pamplonita', 1, 54),
(644, 'Pandi', 1, 25),
(645, 'Panqueba', 1, 15),
(646, 'Paratebueno', 1, 25),
(647, 'Pasca', 1, 25),
(648, 'Patía (El Bordo)', 1, 19),
(649, 'Pauna', 1, 15),
(650, 'Paya', 1, 15),
(651, 'Paz de Ariporo', 1, 85),
(652, 'Paz de Río', 1, 15),
(653, 'Pedraza', 1, 47),
(654, 'Pelaya', 1, 20),
(655, 'Pensilvania', 1, 17),
(656, 'Peque', 1, 5),
(657, 'Pereira', 1, 66),
(658, 'Pesca', 1, 15),
(659, 'Peñol', 1, 5),
(660, 'Piamonte', 1, 19),
(661, 'Pie de Cuesta', 1, 68),
(662, 'Piedras', 1, 73),
(663, 'Piendamó', 1, 19),
(664, 'Pijao', 1, 63),
(665, 'Pijiño', 1, 47),
(666, 'Pinchote', 1, 68),
(667, 'Pinillos', 1, 13),
(668, 'Piojo', 1, 8),
(669, 'Pisva', 1, 15),
(670, 'Pital', 1, 41),
(671, 'Pitalito', 1, 41),
(672, 'Pivijay', 1, 47),
(673, 'Planadas', 1, 73),
(674, 'Planeta Rica', 1, 23),
(675, 'Plato', 1, 47),
(676, 'Policarpa', 1, 52),
(677, 'Polonuevo', 1, 8),
(678, 'Ponedera', 1, 8),
(679, 'Popayán', 1, 19),
(680, 'Pore', 1, 85),
(681, 'Potosí', 1, 52),
(682, 'Pradera', 1, 76),
(683, 'Prado', 1, 73),
(684, 'Providencia', 1, 52),
(685, 'Providencia', 1, 88),
(686, 'Pueblo Bello', 1, 20),
(687, 'Pueblo Nuevo', 1, 23),
(688, 'Pueblo Rico', 1, 66),
(689, 'Pueblorrico', 1, 5),
(690, 'Puebloviejo', 1, 47),
(691, 'Puente Nacional', 1, 68),
(692, 'Puerres', 1, 52),
(693, 'Puerto Asís', 1, 86),
(694, 'Puerto Berrío', 1, 5),
(695, 'Puerto Boyacá', 1, 15),
(696, 'Puerto Caicedo', 1, 86),
(697, 'Puerto Carreño', 1, 99),
(698, 'Puerto Colombia', 1, 8),
(699, 'Puerto Concordia', 1, 50),
(700, 'Puerto Escondido', 1, 23),
(701, 'Puerto Gaitán', 1, 50),
(702, 'Puerto Guzmán', 1, 86),
(703, 'Puerto Leguízamo', 1, 86),
(704, 'Puerto Libertador', 1, 23),
(705, 'Puerto Lleras', 1, 50),
(706, 'Puerto López', 1, 50),
(707, 'Puerto Nare', 1, 5),
(708, 'Puerto Nariño', 1, 91),
(709, 'Puerto Parra', 1, 68),
(710, 'Puerto Rico', 1, 18),
(711, 'Puerto Rico', 1, 50),
(712, 'Puerto Rondón', 1, 81),
(713, 'Puerto Salgar', 1, 25),
(714, 'Puerto Santander', 1, 54),
(715, 'Puerto Tejada', 1, 19),
(716, 'Puerto Triunfo', 1, 5),
(717, 'Puerto Wilches', 1, 68),
(718, 'Pulí', 1, 25),
(719, 'Pupiales', 1, 52),
(720, 'Puracé (Coconuco)', 1, 19),
(721, 'Purificación', 1, 73),
(722, 'Purísima', 1, 23),
(723, 'Pácora', 1, 17),
(724, 'Páez', 1, 15),
(725, 'Páez (Belalcazar)', 1, 19),
(726, 'Páramo', 1, 68),
(727, 'Quebradanegra', 1, 25),
(728, 'Quetame', 1, 25),
(729, 'Quibdó', 1, 27),
(730, 'Quimbaya', 1, 63),
(731, 'Quinchía', 1, 66),
(732, 'Quipama', 1, 15),
(733, 'Quipile', 1, 25),
(734, 'Ragonvalia', 1, 54),
(735, 'Ramiriquí', 1, 15),
(736, 'Recetor', 1, 85),
(737, 'Regidor', 1, 13),
(738, 'Remedios', 1, 5),
(739, 'Remolino', 1, 47),
(740, 'Repelón', 1, 8),
(741, 'Restrepo', 1, 50),
(742, 'Restrepo', 1, 76),
(743, 'Retiro', 1, 5),
(744, 'Ricaurte', 1, 25),
(745, 'Ricaurte', 1, 52),
(746, 'Rio Negro', 1, 68),
(747, 'Rioblanco', 1, 73),
(748, 'Riofrío', 1, 76),
(749, 'Riohacha', 1, 44),
(750, 'Risaralda', 1, 17),
(751, 'Rivera', 1, 41),
(752, 'Roberto Payán (San José)', 1, 52),
(753, 'Roldanillo', 1, 76),
(754, 'Roncesvalles', 1, 73),
(755, 'Rondón', 1, 15),
(756, 'Rosas', 1, 19),
(757, 'Rovira', 1, 73),
(758, 'Ráquira', 1, 15),
(759, 'Río Iró', 1, 27),
(760, 'Río Quito', 1, 27),
(761, 'Río Sucio', 1, 17),
(762, 'Río Viejo', 1, 13),
(763, 'Río de oro', 1, 20),
(764, 'Ríonegro', 1, 5),
(765, 'Ríosucio', 1, 27),
(766, 'Sabana de Torres', 1, 68),
(767, 'Sabanagrande', 1, 8),
(768, 'Sabanalarga', 1, 5),
(769, 'Sabanalarga', 1, 8),
(770, 'Sabanalarga', 1, 85),
(771, 'Sabanas de San Angel (SAN ANGEL)', 1, 47),
(772, 'Sabaneta', 1, 5),
(773, 'Saboyá', 1, 15),
(774, 'Sahagún', 1, 23),
(775, 'Saladoblanco', 1, 41),
(776, 'Salamina', 1, 17),
(777, 'Salamina', 1, 47),
(778, 'Salazar', 1, 54),
(779, 'Saldaña', 1, 73),
(780, 'Salento', 1, 63),
(781, 'Salgar', 1, 5),
(782, 'Samacá', 1, 15),
(783, 'Samaniego', 1, 52),
(784, 'Samaná', 1, 17),
(785, 'Sampués', 1, 70),
(786, 'San Agustín', 1, 41),
(787, 'San Alberto', 1, 20),
(788, 'San Andrés', 1, 68),
(789, 'San Andrés Sotavento', 1, 23),
(790, 'San Andrés de Cuerquía', 1, 5),
(791, 'San Antero', 1, 23),
(792, 'San Antonio', 1, 73),
(793, 'San Antonio de Tequendama', 1, 25),
(794, 'San Benito', 1, 68),
(795, 'San Benito Abad', 1, 70),
(796, 'San Bernardo', 1, 25),
(797, 'San Bernardo', 1, 52),
(798, 'San Bernardo del Viento', 1, 23),
(799, 'San Calixto', 1, 54),
(800, 'San Carlos', 1, 5),
(801, 'San Carlos', 1, 23),
(802, 'San Carlos de Guaroa', 1, 50),
(803, 'San Cayetano', 1, 25),
(804, 'San Cayetano', 1, 54),
(805, 'San Cristobal', 1, 13),
(806, 'San Diego', 1, 20),
(807, 'San Eduardo', 1, 15),
(808, 'San Estanislao', 1, 13),
(809, 'San Fernando', 1, 13),
(810, 'San Francisco', 1, 5),
(811, 'San Francisco', 1, 25),
(812, 'San Francisco', 1, 86),
(813, 'San Gíl', 1, 68),
(814, 'San Jacinto', 1, 13),
(815, 'San Jacinto del Cauca', 1, 13),
(816, 'San Jerónimo', 1, 5),
(817, 'San Joaquín', 1, 68),
(818, 'San José', 1, 17),
(819, 'San José de Miranda', 1, 68),
(820, 'San José de Montaña', 1, 5),
(821, 'San José de Pare', 1, 15),
(822, 'San José de Uré', 1, 23),
(823, 'San José del Fragua', 1, 18),
(824, 'San José del Guaviare', 1, 95),
(825, 'San José del Palmar', 1, 27),
(826, 'San Juan de Arama', 1, 50),
(827, 'San Juan de Betulia', 1, 70),
(828, 'San Juan de Nepomuceno', 1, 13),
(829, 'San Juan de Pasto', 1, 52),
(830, 'San Juan de Río Seco', 1, 25),
(831, 'San Juan de Urabá', 1, 5),
(832, 'San Juan del Cesar', 1, 44),
(833, 'San Juanito', 1, 50),
(834, 'San Lorenzo', 1, 52),
(835, 'San Luis', 1, 73),
(836, 'San Luís', 1, 5),
(837, 'San Luís de Gaceno', 1, 15),
(838, 'San Luís de Palenque', 1, 85),
(839, 'San Marcos', 1, 70),
(840, 'San Martín', 1, 20),
(841, 'San Martín', 1, 50),
(842, 'San Martín de Loba', 1, 13),
(843, 'San Mateo', 1, 15),
(844, 'San Miguel', 1, 68),
(845, 'San Miguel', 1, 86),
(846, 'San Miguel de Sema', 1, 15),
(847, 'San Onofre', 1, 70),
(848, 'San Pablo', 1, 13),
(849, 'San Pablo', 1, 52),
(850, 'San Pablo de Borbur', 1, 15),
(851, 'San Pedro', 1, 5),
(852, 'San Pedro', 1, 70),
(853, 'San Pedro', 1, 76),
(854, 'San Pedro de Cartago', 1, 52),
(855, 'San Pedro de Urabá', 1, 5),
(856, 'San Pelayo', 1, 23),
(857, 'San Rafael', 1, 5),
(858, 'San Roque', 1, 5),
(859, 'San Sebastián', 1, 19),
(860, 'San Sebastián de Buenavista', 1, 47),
(861, 'San Vicente', 1, 5),
(862, 'San Vicente del Caguán', 1, 18),
(863, 'San Vicente del Chucurí', 1, 68),
(864, 'San Zenón', 1, 47),
(865, 'Sandoná', 1, 52),
(866, 'Santa Ana', 1, 47),
(867, 'Santa Bárbara', 1, 5),
(868, 'Santa Bárbara', 1, 68),
(869, 'Santa Bárbara (Iscuandé)', 1, 52),
(870, 'Santa Bárbara de Pinto', 1, 47),
(871, 'Santa Catalina', 1, 13),
(872, 'Santa Fé de Antioquia', 1, 5),
(873, 'Santa Genoveva de Docorodó', 1, 27),
(874, 'Santa Helena del Opón', 1, 68),
(875, 'Santa Isabel', 1, 73),
(876, 'Santa Lucía', 1, 8),
(877, 'Santa Marta', 1, 47),
(878, 'Santa María', 1, 15),
(879, 'Santa María', 1, 41),
(880, 'Santa Rosa', 1, 13),
(881, 'Santa Rosa', 1, 19),
(882, 'Santa Rosa de Cabal', 1, 66),
(883, 'Santa Rosa de Osos', 1, 5),
(884, 'Santa Rosa de Viterbo', 1, 15),
(885, 'Santa Rosa del Sur', 1, 13),
(886, 'Santa Rosalía', 1, 99),
(887, 'Santa Sofía', 1, 15),
(888, 'Santana', 1, 15),
(889, 'Santander de Quilichao', 1, 19),
(890, 'Santiago', 1, 54),
(891, 'Santiago', 1, 86),
(892, 'Santo Domingo', 1, 5),
(893, 'Santo Tomás', 1, 8),
(894, 'Santuario', 1, 5),
(895, 'Santuario', 1, 66),
(896, 'Sapuyes', 1, 52),
(897, 'Saravena', 1, 81),
(898, 'Sardinata', 1, 54),
(899, 'Sasaima', 1, 25),
(900, 'Sativanorte', 1, 15),
(901, 'Sativasur', 1, 15),
(902, 'Segovia', 1, 5),
(903, 'Sesquilé', 1, 25),
(904, 'Sevilla', 1, 76),
(905, 'Siachoque', 1, 15),
(906, 'Sibaté', 1, 25),
(907, 'Sibundoy', 1, 86),
(908, 'Silos', 1, 54),
(909, 'Silvania', 1, 25),
(910, 'Silvia', 1, 19),
(911, 'Simacota', 1, 68),
(912, 'Simijaca', 1, 25),
(913, 'Simití', 1, 13),
(914, 'Sincelejo', 1, 70),
(915, 'Sincé', 1, 70),
(916, 'Sipí', 1, 27),
(917, 'Sitionuevo', 1, 47),
(918, 'Soacha', 1, 25),
(919, 'Soatá', 1, 15),
(920, 'Socha', 1, 15),
(921, 'Socorro', 1, 68),
(922, 'Socotá', 1, 15),
(923, 'Sogamoso', 1, 15),
(924, 'Solano', 1, 18),
(925, 'Soledad', 1, 8),
(926, 'Solita', 1, 18),
(927, 'Somondoco', 1, 15),
(928, 'Sonsón', 1, 5),
(929, 'Sopetrán', 1, 5),
(930, 'Soplaviento', 1, 13),
(931, 'Sopó', 1, 25),
(932, 'Sora', 1, 15),
(933, 'Soracá', 1, 15),
(934, 'Sotaquirá', 1, 15),
(935, 'Sotara (Paispamba)', 1, 19),
(936, 'Sotomayor (Los Andes)', 1, 52),
(937, 'Suaita', 1, 68),
(938, 'Suan', 1, 8),
(939, 'Suaza', 1, 41),
(940, 'Subachoque', 1, 25),
(941, 'Sucre', 1, 19),
(942, 'Sucre', 1, 68),
(943, 'Sucre', 1, 70),
(944, 'Suesca', 1, 25),
(945, 'Supatá', 1, 25),
(946, 'Supía', 1, 17),
(947, 'Suratá', 1, 68),
(948, 'Susa', 1, 25),
(949, 'Susacón', 1, 15),
(950, 'Sutamarchán', 1, 15),
(951, 'Sutatausa', 1, 25),
(952, 'Sutatenza', 1, 15),
(953, 'Suárez', 1, 19),
(954, 'Suárez', 1, 73),
(955, 'Sácama', 1, 85),
(956, 'Sáchica', 1, 15),
(957, 'Tabio', 1, 25),
(958, 'Tadó', 1, 27),
(959, 'Talaigua Nuevo', 1, 13),
(960, 'Tamalameque', 1, 20),
(961, 'Tame', 1, 81),
(962, 'Taminango', 1, 52),
(963, 'Tangua', 1, 52),
(964, 'Taraira', 1, 97),
(965, 'Tarazá', 1, 5),
(966, 'Tarqui', 1, 41),
(967, 'Tarso', 1, 5),
(968, 'Tasco', 1, 15),
(969, 'Tauramena', 1, 85),
(970, 'Tausa', 1, 25),
(971, 'Tello', 1, 41),
(972, 'Tena', 1, 25),
(973, 'Tenerife', 1, 47),
(974, 'Tenjo', 1, 25),
(975, 'Tenza', 1, 15),
(976, 'Teorama', 1, 54),
(977, 'Teruel', 1, 41),
(978, 'Tesalia', 1, 41),
(979, 'Tibacuy', 1, 25),
(980, 'Tibaná', 1, 15),
(981, 'Tibasosa', 1, 15),
(982, 'Tibirita', 1, 25),
(983, 'Tibú', 1, 54),
(984, 'Tierralta', 1, 23),
(985, 'Timaná', 1, 41),
(986, 'Timbiquí', 1, 19),
(987, 'Timbío', 1, 19),
(988, 'Tinjacá', 1, 15),
(989, 'Tipacoque', 1, 15),
(990, 'Tiquisio (Puerto Rico)', 1, 13),
(991, 'Titiribí', 1, 5),
(992, 'Toca', 1, 15),
(993, 'Tocaima', 1, 25),
(994, 'Tocancipá', 1, 25),
(995, 'Toguí', 1, 15),
(996, 'Toledo', 1, 5),
(997, 'Toledo', 1, 54),
(998, 'Tolú', 1, 70),
(999, 'Tolú Viejo', 1, 70),
(1000, 'Tona', 1, 68),
(1001, 'Topagá', 1, 15),
(1002, 'Topaipí', 1, 25),
(1003, 'Toribío', 1, 19),
(1004, 'Toro', 1, 76),
(1005, 'Tota', 1, 15),
(1006, 'Totoró', 1, 19),
(1007, 'Trinidad', 1, 85),
(1008, 'Trujillo', 1, 76),
(1009, 'Tubará', 1, 8),
(1010, 'Tuchín', 1, 23),
(1011, 'Tulúa', 1, 76),
(1012, 'Tumaco', 1, 52),
(1013, 'Tunja', 1, 15),
(1014, 'Tunungua', 1, 15),
(1015, 'Turbaco', 1, 13),
(1016, 'Turbaná', 1, 13),
(1017, 'Turbo', 1, 5),
(1018, 'Turmequé', 1, 15),
(1019, 'Tuta', 1, 15),
(1020, 'Tutasá', 1, 15),
(1021, 'Támara', 1, 85),
(1022, 'Támesis', 1, 5),
(1023, 'Túquerres', 1, 52),
(1024, 'Ubalá', 1, 25),
(1025, 'Ubaque', 1, 25),
(1026, 'Ubaté', 1, 25),
(1027, 'Ulloa', 1, 76),
(1028, 'Une', 1, 25),
(1029, 'Unguía', 1, 27),
(1030, 'Unión Panamericana (ÁNIMAS)', 1, 27),
(1031, 'Uramita', 1, 5),
(1032, 'Uribe', 1, 50),
(1033, 'Uribia', 1, 44),
(1034, 'Urrao', 1, 5),
(1035, 'Urumita', 1, 44),
(1036, 'Usiacuri', 1, 8),
(1037, 'Valdivia', 1, 5),
(1038, 'Valencia', 1, 23),
(1039, 'Valle de San José', 1, 68),
(1040, 'Valle de San Juan', 1, 73),
(1041, 'Valle del Guamuez', 1, 86),
(1042, 'Valledupar', 1, 20),
(1043, 'Valparaiso', 1, 5),
(1044, 'Valparaiso', 1, 18),
(1045, 'Vegachí', 1, 5),
(1046, 'Venadillo', 1, 73),
(1047, 'Venecia', 1, 5),
(1048, 'Venecia (Ospina Pérez)', 1, 25),
(1049, 'Ventaquemada', 1, 15),
(1050, 'Vergara', 1, 25),
(1051, 'Versalles', 1, 76),
(1052, 'Vetas', 1, 68),
(1053, 'Viani', 1, 25),
(1054, 'Vigía del Fuerte', 1, 5),
(1055, 'Vijes', 1, 76),
(1056, 'Villa Caro', 1, 54),
(1057, 'Villa Rica', 1, 19),
(1058, 'Villa de Leiva', 1, 15),
(1059, 'Villa del Rosario', 1, 54),
(1060, 'Villagarzón', 1, 86),
(1061, 'Villagómez', 1, 25),
(1062, 'Villahermosa', 1, 73),
(1063, 'Villamaría', 1, 17),
(1064, 'Villanueva', 1, 13),
(1065, 'Villanueva', 1, 44),
(1066, 'Villanueva', 1, 68),
(1067, 'Villanueva', 1, 85),
(1068, 'Villapinzón', 1, 25),
(1069, 'Villarrica', 1, 73),
(1070, 'Villavicencio', 1, 50),
(1071, 'Villavieja', 1, 41),
(1072, 'Villeta', 1, 25),
(1073, 'Viotá', 1, 25),
(1074, 'Viracachá', 1, 15),
(1075, 'Vista Hermosa', 1, 50),
(1076, 'Viterbo', 1, 17),
(1077, 'Vélez', 1, 68),
(1078, 'Yacopí', 1, 25),
(1079, 'Yacuanquer', 1, 52),
(1080, 'Yaguará', 1, 41),
(1081, 'Yalí', 1, 5),
(1082, 'Yarumal', 1, 5),
(1083, 'Yolombó', 1, 5),
(1084, 'Yondó (Casabe)', 1, 5),
(1085, 'Yopal', 1, 85),
(1086, 'Yotoco', 1, 76),
(1087, 'Yumbo', 1, 76),
(1088, 'Zambrano', 1, 13),
(1089, 'Zapatoca', 1, 68),
(1090, 'Zapayán (PUNTA DE PIEDRAS)', 1, 47),
(1091, 'Zaragoza', 1, 5),
(1092, 'Zarzal', 1, 76),
(1093, 'Zetaquirá', 1, 15),
(1094, 'Zipacón', 1, 25),
(1095, 'Zipaquirá', 1, 25),
(1096, 'Zona Bananera (PRADO - SEVILLA)', 1, 47),
(1097, 'Ábrego', 1, 54),
(1098, 'Íquira', 1, 41),
(1099, 'Úmbita', 1, 15),
(1100, 'Útica', 1, 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parametrizador`
--

CREATE TABLE `parametrizador` (
  `id_parametrizador` int(11) NOT NULL,
  `nombre_parametrizador` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fk_estado` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL,
  `cant_pedido` int(11) NOT NULL,
  `fk_sede` int(11) NOT NULL,
  `fk_estado` int(11) NOT NULL,
  `fk_cliente` int(11) NOT NULL,
  `ref_pedido` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos_productos`
--

CREATE TABLE `pedidos_productos` (
  `id_producto` int(11) NOT NULL,
  `fk_producto` int(11) NOT NULL,
  `cant_producto` int(11) NOT NULL,
  `ref_pedido` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `nom_producto` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `nomG_producto` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT 'No Data',
  `precio_producto` double DEFAULT NULL,
  `mprima_producto` double DEFAULT NULL,
  `comision_producto` double DEFAULT NULL,
  `fk_categoria` int(11) DEFAULT NULL,
  `descripcion_producto` varchar(4000) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `imagen_producto` varchar(1000) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `nom_producto`, `nomG_producto`, `precio_producto`, `mprima_producto`, `comision_producto`, `fk_categoria`, `descripcion_producto`, `imagen_producto`) VALUES
(1, '14oz Vainilla', 'Milkshake Vainilla 14 Oz', 8000, 3500, 3500, 10, 'fjjshksjhkash', 'prod-smoothie.jpg'),
(2, '9oz Vainilla', 'Vainilla', 5000, 2500, 2500, 10, 'Algo, algo.', 'prod-malteadas.jpg'),
(3, '14oz Chocolate', NULL, 7000, 3500, 3500, 10, NULL, NULL),
(4, '9oz Chocolate', NULL, 5000, 2500, 2500, 10, NULL, NULL),
(5, '14oz ChocoVainilla', 'Choco Vainilla', 7000, 3500, 3500, 10, 'Choco Vainilla', '2019_10_09_5_10.jpg'),
(6, '9oz ChocoVainilla', 'choco', 5000, 2500, 2500, 10, 'choco', '2019_10_09_6_10.jpg'),
(7, 'Nucita en polvo', NULL, 500, 250, 250, 1, NULL, NULL),
(8, 'Milo en polvo', NULL, 500, 250, 250, 1, NULL, NULL),
(9, 'Canela', NULL, 500, 250, 250, 1, NULL, NULL),
(10, 'Grageas', NULL, 500, 250, 250, 1, NULL, NULL),
(11, 'Chocolatina Jet', NULL, 1000, 500, 500, 1, NULL, NULL),
(12, 'Choco Masmelos', NULL, 1000, 500, 500, 1, NULL, NULL),
(13, 'Barrilete', NULL, 1000, 500, 500, 1, NULL, NULL),
(14, 'Mini Masmelos', NULL, 1000, 500, 500, 1, NULL, NULL),
(15, 'Frunas Balls', NULL, 1000, 500, 500, 1, NULL, NULL),
(16, 'Maní', NULL, 1000, 500, 500, 1, NULL, NULL),
(17, 'Noggy', NULL, 1000, 500, 500, 1, NULL, NULL),
(18, 'Milo Galletas', NULL, 1000, 500, 500, 1, NULL, NULL),
(19, 'Moritas', NULL, 1000, 500, 500, 1, NULL, NULL),
(20, 'Oreo', NULL, 1500, 750, 750, 1, NULL, NULL),
(21, 'Piazza', NULL, 1500, 750, 750, 1, NULL, NULL),
(22, 'Hanuta', NULL, 2000, 1000, 1000, 1, NULL, NULL),
(23, 'Trululú', NULL, 1500, 750, 750, 1, NULL, NULL),
(24, 'Festival Limón', NULL, 1500, 750, 750, 1, NULL, NULL),
(25, 'Morenitas', NULL, 1500, 750, 750, 1, NULL, NULL),
(26, 'Nucita Galletas', NULL, 1500, 750, 750, 1, NULL, NULL),
(27, 'Snicker´s', NULL, 2000, 1000, 1000, 1, NULL, NULL),
(28, 'Cocosette', NULL, 2000, 1000, 1000, 1, NULL, NULL),
(29, 'Milky Way', NULL, 2000, 1000, 1000, 1, NULL, NULL),
(30, 'Brownie', NULL, 2000, 1000, 1000, 1, NULL, NULL),
(32, 'Cocadas Copelia', NULL, 2000, 1000, 1000, 1, NULL, NULL),
(33, 'Mini Chips', NULL, 1500, 750, 750, 1, NULL, NULL),
(34, 'Beso de Negra', NULL, 2000, 1000, 1000, 1, NULL, NULL),
(35, 'Deditos de Chocolate', NULL, 2000, 1000, 1000, 1, NULL, NULL),
(36, 'Twix', NULL, 3000, 1500, 1500, 1, NULL, NULL),
(37, 'M&M', NULL, 3000, 1500, 1500, 1, NULL, NULL),
(38, 'Cookies & Cream', NULL, 3000, 1500, 1500, 1, NULL, NULL),
(40, 'Nutella', NULL, 3000, 1500, 1500, 1, NULL, NULL),
(41, 'Milo Nuggets', NULL, 3000, 1500, 1500, 1, NULL, NULL),
(42, 'Bayleys', NULL, 3000, 1500, 1500, 1, NULL, NULL),
(45, 'Ferrero Rocher', NULL, 4000, 2000, 2000, 1, NULL, NULL),
(46, 'Kinder Bueno', NULL, 4000, 2000, 2000, 1, NULL, NULL),
(50, 'Salsa Fresa', NULL, 1000, 500, 500, 1, NULL, NULL),
(51, 'Crema Chantilly', NULL, 1500, 750, 750, 1, NULL, NULL),
(52, 'Arequipe', NULL, 1000, 500, 500, 1, NULL, NULL),
(53, 'Leche Condensada', NULL, 1000, 500, 500, 1, NULL, NULL),
(54, 'Salsa Chocolate', NULL, 1000, 500, 500, 1, NULL, NULL),
(55, 'Salsa Caramelo', NULL, 1000, 500, 500, 1, NULL, NULL),
(56, 'Chips de Chocolate', NULL, 1000, 500, 500, 1, NULL, NULL),
(57, 'Fresa', NULL, 2000, 1000, 1000, 5, NULL, NULL),
(58, 'Uva', NULL, 2000, 1000, 1000, 5, NULL, NULL),
(59, 'Kiwi', NULL, 2000, 1000, 1000, 5, NULL, NULL),
(60, 'Patilla', NULL, 2000, 1000, 1000, 5, NULL, NULL),
(61, 'Mango Maduro', NULL, 2000, 1000, 1000, 5, NULL, NULL),
(62, 'Manzana Verde', NULL, 2000, 1000, 1000, 5, NULL, NULL),
(63, 'Banano', NULL, 2000, 1000, 1000, 5, NULL, NULL),
(64, 'Durazno', NULL, 2000, 1000, 1000, 5, NULL, NULL),
(65, 'Piña', NULL, 2000, 1000, 1000, 5, NULL, NULL),
(66, 'Mandarina', NULL, 2000, 1000, 1000, 5, NULL, NULL),
(67, 'Cereza en Almibar', NULL, 2000, 1000, 1000, 5, NULL, NULL),
(68, 'Clásico 9oz', 'Milkshake Clásico 9oz', 7500, 3750, 3750, 7, 'Vainilla + Oreo + Arequipe', NULL),
(69, 'Clásico 14oz', NULL, 9500, 4750, 4750, 7, NULL, NULL),
(70, 'De la Casa 9oz', NULL, 13000, 6500, 6500, 7, NULL, NULL),
(71, 'De la Casa 14oz', NULL, 15000, 7500, 7500, 7, NULL, NULL),
(72, 'Combinado 9oz', NULL, 10000, 5000, 5000, 7, NULL, NULL),
(73, 'Combinado 14oz', NULL, 12000, 6000, 6000, 7, NULL, NULL),
(74, 'Baileys 9oz', NULL, 13000, 6500, 6500, 7, NULL, NULL),
(75, 'Baileys 14oz', NULL, 15000, 7500, 7500, 7, NULL, NULL),
(76, 'Divertido 9oz', NULL, 9000, 4500, 4500, 7, NULL, NULL),
(77, 'Divertido 14oz', NULL, 11000, 5500, 5500, 7, NULL, NULL),
(79, 'L. Cerezada', NULL, 4500, 2250, 2250, 4, NULL, NULL),
(80, 'Crazy 9oz', NULL, 13000, 6500, 6500, 7, NULL, NULL),
(81, 'Crazy 14oz', NULL, 15000, 7500, 7500, 7, NULL, NULL),
(82, 'Elegante 9oz', NULL, 12000, 6000, 6000, 7, NULL, NULL),
(83, 'Elegante 14oz', NULL, 14000, 7000, 7000, 7, NULL, NULL),
(84, 'Sweet 9oz', NULL, 10000, 5000, 5000, 7, NULL, NULL),
(85, 'Sweet 14oz', NULL, 12000, 6000, 6000, 7, NULL, NULL),
(86, 'Baby Shake', NULL, 8000, 4000, 4000, 7, NULL, NULL),
(87, 'S. Tropical', NULL, 7000, 3500, 3500, 9, NULL, NULL),
(88, 'S. Primavera', NULL, 7000, 3500, 3500, 9, NULL, NULL),
(89, 'S. Fresh', NULL, 7000, 3500, 3500, 9, NULL, NULL),
(90, 'S. De la casa', NULL, 7000, 3500, 3500, 9, NULL, NULL),
(91, 'S. Hawaiano', NULL, 7000, 3500, 3500, 9, NULL, NULL),
(92, 'S. Brisa Roja', NULL, 7000, 3500, 3500, 9, NULL, NULL),
(93, 'S. Cremoso', NULL, 8000, 4000, 4000, 9, NULL, NULL),
(94, 'L. Clásica', NULL, 4500, 2250, 2250, 4, NULL, NULL),
(95, 'L. Patilla', NULL, 4500, 2250, 2250, 4, NULL, NULL),
(96, 'L. Hiberbabuena', NULL, 4500, 2250, 2250, 4, NULL, NULL),
(97, 'L. Mango Biche', NULL, 4500, 2250, 2250, 4, NULL, NULL),
(98, 'Parfait', NULL, 10000, 5000, 5000, 8, NULL, NULL),
(99, 'Kool', NULL, 5000, 2500, 2500, 8, NULL, NULL),
(100, 'Fruit', NULL, 10000, 5000, 5000, 8, NULL, NULL),
(101, 'Fresas con crema', NULL, 6000, 3000, 3000, 8, NULL, NULL),
(102, 'Explosión de Nutella', NULL, 6000, 3000, 3000, 8, NULL, NULL),
(103, 'Sandwich', NULL, 3000, 1500, 1500, 12, NULL, NULL),
(104, 'S. MaracuMango', NULL, 7000, 3500, 3500, 9, NULL, NULL),
(105, 'F. Maracuyá', NULL, 5000, 2500, 2500, 4, NULL, NULL),
(106, 'Botella de agua', NULL, 2000, 1000, 1000, 8, NULL, NULL),
(109, 'CofSha Arequipe', NULL, 9000, 4500, 4500, 2, NULL, NULL),
(111, 'CofSha Brownie', NULL, 9000, 4500, 4500, 2, NULL, NULL),
(116, 'CofShaCremChip9oz', NULL, 8000, 4000, 4000, 2, NULL, NULL),
(117, 'CofShaCremChip14oz', NULL, 10000, 5000, 5000, 2, NULL, NULL),
(118, 'CofShaCremMilo9oz', NULL, 8000, 4000, 4000, 2, NULL, NULL),
(119, 'CofShaCremMilo14oz', NULL, 10000, 5000, 5000, 2, NULL, NULL),
(121, 'Granizado Café', NULL, 7000, 3500, 3500, 2, NULL, NULL),
(122, 'MiniShake Lunes', NULL, 5000, 2000, 3000, 7, NULL, NULL),
(123, 'MiniShake Martes', NULL, 5000, 2000, 3000, 7, NULL, NULL),
(124, 'MiniShake Miércoles', NULL, 5000, 2000, 3000, 7, NULL, NULL),
(125, 'MiniShake Jueves', NULL, 5000, 2000, 3000, 7, NULL, NULL),
(126, 'MiniShake Viernes', NULL, 5000, 2000, 3000, 7, NULL, NULL),
(127, 'Ensalada de frutas', NULL, 12000, 6000, 6000, 8, NULL, NULL),
(128, 'Bola de helado', NULL, 2000, 1000, 1000, 8, NULL, NULL),
(129, 'Mango Biche', NULL, 1000, 500, 500, 5, NULL, NULL),
(130, 'Brownie con Helado', NULL, 6000, 3000, 3000, 8, NULL, NULL),
(203, 'Encanto de Maracuyá', NULL, 12000, 6000, 6000, 12, NULL, NULL),
(205, 'Mix de Crema', NULL, 8000, 4000, 4000, 8, NULL, NULL),
(206, 'Waffle Mix', NULL, 10000, 5000, 5000, 8, NULL, NULL),
(500, 'Beso de Negra 9oz', NULL, 10000, 6000, 4000, 7, NULL, NULL),
(501, 'Super Mango Biche', NULL, 6000, 3000, 3000, 4, NULL, NULL),
(503, 'Beso de Negra 14oz', NULL, 12000, 6000, 6000, 7, NULL, NULL),
(600, 'Tentador 14oz', NULL, 13000, 8000, 5000, 7, NULL, NULL),
(601, 'Extremo 14oz', NULL, 13000, 8000, 5000, 7, NULL, NULL),
(605, 'Malteada Brownie', NULL, 10000, 5000, 5000, 12, NULL, NULL),
(606, 'Malteada Oreo', NULL, 10000, 5000, 5000, 12, NULL, NULL),
(607, 'Malteada Lulo', NULL, 10000, 5000, 5000, 12, NULL, NULL),
(608, 'Malteada Café', NULL, 10000, 5000, 5000, 12, NULL, NULL),
(609, 'Malteada Fresa', NULL, 10000, 5000, 5000, 12, NULL, NULL),
(610, 'Malteada Maracuyá', NULL, 10000, 5000, 5000, 12, NULL, NULL),
(611, 'Encantador 14oz', NULL, 13000, 6500, 6500, 7, NULL, NULL),
(612, 'Brown 14oz', NULL, 13000, 6500, 6500, 7, NULL, NULL),
(613, 'Crema Mix 14oz', NULL, 12000, 6000, 6000, 7, NULL, NULL),
(614, 'Mini Shake', NULL, 4000, 2000, 2000, 7, NULL, NULL),
(617, 'Waffle Fit', NULL, 10000, 5000, 5000, 8, NULL, NULL),
(618, 'Ensalada Fit', NULL, 10000, 5000, 5000, 8, NULL, NULL),
(619, 'Súper Perro', NULL, 7000, 3500, 3500, 13, NULL, NULL),
(620, 'Perro Suizo', NULL, 8000, 4000, 4000, 13, NULL, NULL),
(623, 'Waffle de Pollo', NULL, 13000, 6500, 6500, 13, NULL, NULL),
(624, 'Waffle de Atún ', NULL, 13000, 6500, 6500, 13, NULL, NULL),
(625, 'Waffle de la Casa', NULL, 15000, 7500, 7500, 13, NULL, NULL),
(703, 'Sandwich Hawaiano', NULL, 4000, 2000, 2000, 13, NULL, NULL),
(704, 'Sandwich de Queso', NULL, 4000, 2000, 2000, 13, NULL, NULL),
(705, 'Jugo de Naranja', NULL, 3000, 1500, 1500, 13, NULL, NULL),
(706, 'Promo Súper Mango Biche', NULL, 4500, 2250, 2250, 13, NULL, NULL),
(710, 'Fresas con Crema Helado', NULL, 9000, 4500, 4500, 13, NULL, NULL),
(715, '3x2 L. Mango Biche', NULL, 9000, 4500, 4500, 4, NULL, NULL),
(716, 'Producto de prueba', NULL, 14000, 7000, 7000, 0, 'Ingrediente1, ingrediente2, ingrediente3', 'parfait.jpg'),
(1000, '2x1 Fruit', NULL, 10000, 5000, 5000, 11, NULL, NULL),
(1001, '2x1 Malteada Brownie', NULL, 10000, 5000, 5000, 11, NULL, NULL),
(1002, '2x1 Milkshake Twix', NULL, 14000, 7000, 7000, 11, NULL, NULL),
(1003, 'Especial Mujer', NULL, 7000, 3500, 3500, 0, NULL, NULL),
(1004, 'a', 'a', 1, NULL, NULL, 1, 'hhj', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_vendidos`
--

CREATE TABLE `productos_vendidos` (
  `id_vendido` int(11) NOT NULL,
  `fk_producto` int(11) DEFAULT NULL,
  `cant_vendido` int(11) DEFAULT NULL,
  `desc_vendido` decimal(10,2) DEFAULT NULL,
  `fecha_vendido` datetime DEFAULT NULL,
  `fk_factura` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `fk_sede` int(11) DEFAULT NULL,
  `web` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes`
--

CREATE TABLE `reportes` (
  `id_reportes` int(11) NOT NULL,
  `iden_reporte` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `val_reporte` double DEFAULT NULL,
  `fk_sede` int(11) DEFAULT NULL,
  `fecha_reporte` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `reportes`
--

INSERT INTO `reportes` (`id_reportes`, `iden_reporte`, `val_reporte`, `fk_sede`, `fecha_reporte`) VALUES
(6, 'shsed119615', 0, 1, '2019-06-15 10:01:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sedes`
--

CREATE TABLE `sedes` (
  `id_sede` int(11) NOT NULL,
  `nit_sede` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `nom_sede` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `dir_sede` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `fk_municipio` int(11) DEFAULT NULL,
  `tel1_sede` double DEFAULT NULL,
  `tel2_sede` double DEFAULT NULL,
  `tel3_sede` double DEFAULT NULL,
  `long_sede` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `lat_sede` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `iden_sede` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `sedes`
--

INSERT INTO `sedes` (`id_sede`, `nit_sede`, `nom_sede`, `dir_sede`, `fk_municipio`, `tel1_sede`, `tel2_sede`, `tel3_sede`, `long_sede`, `lat_sede`, `iden_sede`) VALUES
(1, NULL, 'Shake It Valledupar', 'Carrera 11A #11-71 San Joaquin', 1042, 5840352, 3106939893, 3006245651, NULL, NULL, 'shsed1'),
(2, NULL, 'Shake It Aguachica', 'Calle 7 # 17-24 Las Américas', 8, 5657564, 3234497130, 5657564, NULL, NULL, 'shsed2'),
(3, NULL, 'Shake It Barrancabermeja', 'Plazoleta Cavipetrol, Local 6', 85, 6110010, 3162825109, 0, NULL, NULL, 'shsed3'),
(4, NULL, 'Shake It Monteria', 'Carrera 1 # 31-36 Centro', 573, 7861064, 3136633552, 7861064, NULL, NULL, 'shsed4'),
(5, NULL, 'Shake It Santa Marta', 'Cra. 12 # 26B - 130 Bavaria', 877, 4321844, 3022523964, 0, NULL, NULL, 'shsed5'),
(6, NULL, 'Shake It Barranquilla', 'a', 88, 1, 1, 1, '1', '1', 'shsed6'),
(7, '12345678-9', 'Shake It Bogotá', 'Calle 128A', 107, 12345678, 12345678, 0, '0', '0', 'shsed7'),
(10, '2554-s4', 'Sede Nueva', '123', 107, 1234567890, 1234567890, 0, '0', '0', 'shsed8');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tokens`
--

CREATE TABLE `tokens` (
  `id_token` int(11) NOT NULL,
  `hash_token` varchar(5000) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `ip_token` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `so_token` varchar(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `browser_token` varchar(200) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `user_token` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `fecha_token` datetime NOT NULL,
  `expira_token` datetime NOT NULL,
  `fk_estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tokens`
--

INSERT INTO `tokens` (`id_token`, `hash_token`, `ip_token`, `so_token`, `browser_token`, `user_token`, `fecha_token`, `expira_token`, `fk_estado`) VALUES
(265, '7edac89bde36f87775574f5bc4d462e4f9d395beb7e28a0a1b3a7814', '::1', 'Unknown OS Platform', 'Unknown Browser', '123456789', '2019-10-03 16:07:14', '2019-10-03 23:59:00', 1),
(266, 'b67eb8554109d08c1627dc7ce52a65ea70ed7c9155b5bc898a85f3b9', '::1', 'Unknown OS Platform', 'Unknown Browser', '1065626260', '2019-10-04 09:50:23', '2019-10-04 23:59:00', 1),
(267, 'e0948e7909efd008ab5045bd2f44f5f39d0fd319fd1eadc857b2aa48', '::1', 'Unknown OS Platform', 'Unknown Browser', '1065626260', '2019-10-07 11:57:22', '2019-10-07 23:59:00', 2),
(268, 'fae5d3d25d135f219d614e0c63e3d3bf8c21da78f351f48368cba74a', '::1', 'Unknown OS Platform', 'Unknown Browser', '1065626260', '2019-10-08 16:25:35', '2019-10-08 23:59:00', 1),
(269, '5e6dfa051568d88957f90aaf9f20ee13e3f58f3313c7e2efab3a91db', '::1', 'Windows 10', 'Chrome', '5', '2019-10-10 10:22:33', '2019-10-10 23:59:00', 1),
(270, 'd2343962ec558acc77ea770a971120a66a73c8045bb5a748c0e82396', '::1', 'Windows 10', 'Chrome', 'NaN', '2019-10-09 10:28:02', '2019-10-09 23:59:00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `unidades`
--

CREATE TABLE `unidades` (
  `id_unidad` int(11) NOT NULL,
  `nomSI_unidad` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `simbolo_unidad` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `unidades`
--

INSERT INTO `unidades` (`id_unidad`, `nomSI_unidad`, `simbolo_unidad`) VALUES
(1, 'Gramos', 'g'),
(2, 'Unidades', 'U'),
(3, 'Kilogramo', 'Kg'),
(4, 'Mililitros', 'ml'),
(5, 'Litros', 'lt');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `doc_usuario` double NOT NULL,
  `nom_usuario` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `ape_usuario` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `tel_usuario` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `email_usuario` varchar(500) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `pass_usuario` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `tipo_usuario` int(11) DEFAULT NULL,
  `estado_usuario` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `doc_usuario`, `nom_usuario`, `ape_usuario`, `tel_usuario`, `email_usuario`, `pass_usuario`, `tipo_usuario`, `estado_usuario`) VALUES
(1, 26926064, 'María Silenia ', 'Ordóñez O.', NULL, NULL, '26926064', 1, 2),
(2, 26945921, 'Administrador', 'Admin', '3003278236', 'info@shakeitcol.com', '2c961e49e2787c5275d25962ffb94f96', 2, 3),
(3, 49790251, 'Martha', 'Avendaño', NULL, NULL, '49790251', 1, 1),
(4, 1007390247, 'Estefanía', 'Petro', NULL, NULL, '1007390247', 1, 2),
(5, 1065626260, 'Andrés', 'Estrada Mendoza', '3175025547', 'afestradam@gmail.com', '5324b730af8f1404896a9f759131ed53', 3, 3),
(6, 1065660499, 'Giselle', 'Quintero', NULL, NULL, '1065660499', 1, 2),
(7, 1096199504, 'Katerine', 'Zarate', NULL, NULL, '1096199504', 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_tipo`
--

CREATE TABLE `usuarios_tipo` (
  `idusuarios_tipo` int(11) NOT NULL,
  `nom_tipo` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios_tipo`
--

INSERT INTO `usuarios_tipo` (`idusuarios_tipo`, `nom_tipo`) VALUES
(1, 'Regular'),
(2, 'Administrador'),
(3, 'SuperAdmin'),
(4, 'Administrador De Sede');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `id_venta` int(11) NOT NULL,
  `cant_productos` int(11) NOT NULL,
  `num_factura` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `fk_sede` int(11) DEFAULT NULL,
  `fk_consumo` int(11) DEFAULT NULL,
  `fk_pago` int(11) DEFAULT NULL,
  `fk_entidad` int(11) DEFAULT NULL,
  `val_venta` double NOT NULL,
  `facha_venta` datetime DEFAULT NULL,
  `web` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alertas`
--
ALTER TABLE `alertas`
  ADD PRIMARY KEY (`id_alerta`);

--
-- Indices de la tabla `caja`
--
ALTER TABLE `caja`
  ADD PRIMARY KEY (`id_caja`,`sede_caja`),
  ADD UNIQUE KEY `sede_caja_UNIQUE` (`sede_caja`);

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`idcategoria`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id_cliente`,`tel_cliente`);

--
-- Indices de la tabla `cms_ambientes`
--
ALTER TABLE `cms_ambientes`
  ADD PRIMARY KEY (`id_ambiente`);

--
-- Indices de la tabla `cms_archivos`
--
ALTER TABLE `cms_archivos`
  ADD PRIMARY KEY (`id_archivo`);

--
-- Indices de la tabla `cms_categorias`
--
ALTER TABLE `cms_categorias`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `cms_contenido`
--
ALTER TABLE `cms_contenido`
  ADD PRIMARY KEY (`id_cms`);

--
-- Indices de la tabla `cms_seccion`
--
ALTER TABLE `cms_seccion`
  ADD PRIMARY KEY (`id_seccion`);

--
-- Indices de la tabla `cms_tipoconenido`
--
ALTER TABLE `cms_tipoconenido`
  ADD PRIMARY KEY (`id_tipoconenido`);

--
-- Indices de la tabla `comun_estados`
--
ALTER TABLE `comun_estados`
  ADD PRIMARY KEY (`idcomun_estado`);

--
-- Indices de la tabla `consumo`
--
ALTER TABLE `consumo`
  ADD PRIMARY KEY (`id_consumo`);

--
-- Indices de la tabla `contacto`
--
ALTER TABLE `contacto`
  ADD PRIMARY KEY (`con_id`);

--
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id_departamento`);

--
-- Indices de la tabla `entidadespago`
--
ALTER TABLE `entidadespago`
  ADD PRIMARY KEY (`id_entidad`);

--
-- Indices de la tabla `estados_generales`
--
ALTER TABLE `estados_generales`
  ADD PRIMARY KEY (`idestado`);

--
-- Indices de la tabla `estados_tipo`
--
ALTER TABLE `estados_tipo`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Indices de la tabla `insumos`
--
ALTER TABLE `insumos`
  ADD PRIMARY KEY (`id_insumo`);

--
-- Indices de la tabla `insumos_rel`
--
ALTER TABLE `insumos_rel`
  ADD PRIMARY KEY (`fk_producto`,`fk_insumo`);

--
-- Indices de la tabla `insumos_vendidos`
--
ALTER TABLE `insumos_vendidos`
  ADD PRIMARY KEY (`id_insumosv`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id_inventario`,`sede_inventario`);

--
-- Indices de la tabla `inventario_dia`
--
ALTER TABLE `inventario_dia`
  ADD PRIMARY KEY (`id_inventario`);

--
-- Indices de la tabla `inventario_identificador`
--
ALTER TABLE `inventario_identificador`
  ADD PRIMARY KEY (`id_identificador`),
  ADD UNIQUE KEY `iden_identificador_UNIQUE` (`iden_identificador`);

--
-- Indices de la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  ADD PRIMARY KEY (`idmovimiento`);

--
-- Indices de la tabla `medio_pago`
--
ALTER TABLE `medio_pago`
  ADD PRIMARY KEY (`idmedio_pago`);

--
-- Indices de la tabla `meses`
--
ALTER TABLE `meses`
  ADD PRIMARY KEY (`id_mes`);

--
-- Indices de la tabla `movimientos`
--
ALTER TABLE `movimientos`
  ADD PRIMARY KEY (`id_movimiento`);

--
-- Indices de la tabla `movimientos_concepto`
--
ALTER TABLE `movimientos_concepto`
  ADD PRIMARY KEY (`id_concepto`);

--
-- Indices de la tabla `movimientos_tipo`
--
ALTER TABLE `movimientos_tipo`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Indices de la tabla `municipios`
--
ALTER TABLE `municipios`
  ADD PRIMARY KEY (`id_municipio`);

--
-- Indices de la tabla `parametrizador`
--
ALTER TABLE `parametrizador`
  ADD PRIMARY KEY (`id_parametrizador`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id_pedido`);

--
-- Indices de la tabla `pedidos_productos`
--
ALTER TABLE `pedidos_productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `productos_vendidos`
--
ALTER TABLE `productos_vendidos`
  ADD PRIMARY KEY (`id_vendido`);

--
-- Indices de la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD PRIMARY KEY (`id_reportes`);

--
-- Indices de la tabla `sedes`
--
ALTER TABLE `sedes`
  ADD PRIMARY KEY (`id_sede`),
  ADD UNIQUE KEY `iden_sede_UNIQUE` (`iden_sede`);

--
-- Indices de la tabla `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id_token`);

--
-- Indices de la tabla `unidades`
--
ALTER TABLE `unidades`
  ADD PRIMARY KEY (`id_unidad`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Indices de la tabla `usuarios_tipo`
--
ALTER TABLE `usuarios_tipo`
  ADD PRIMARY KEY (`idusuarios_tipo`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alertas`
--
ALTER TABLE `alertas`
  MODIFY `id_alerta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=295;

--
-- AUTO_INCREMENT de la tabla `caja`
--
ALTER TABLE `caja`
  MODIFY `id_caja` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cms_ambientes`
--
ALTER TABLE `cms_ambientes`
  MODIFY `id_ambiente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cms_archivos`
--
ALTER TABLE `cms_archivos`
  MODIFY `id_archivo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cms_categorias`
--
ALTER TABLE `cms_categorias`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cms_contenido`
--
ALTER TABLE `cms_contenido`
  MODIFY `id_cms` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `cms_seccion`
--
ALTER TABLE `cms_seccion`
  MODIFY `id_seccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cms_tipoconenido`
--
ALTER TABLE `cms_tipoconenido`
  MODIFY `id_tipoconenido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `comun_estados`
--
ALTER TABLE `comun_estados`
  MODIFY `idcomun_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `consumo`
--
ALTER TABLE `consumo`
  MODIFY `id_consumo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `contacto`
--
ALTER TABLE `contacto`
  MODIFY `con_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `entidadespago`
--
ALTER TABLE `entidadespago`
  MODIFY `id_entidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `estados_generales`
--
ALTER TABLE `estados_generales`
  MODIFY `idestado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `estados_tipo`
--
ALTER TABLE `estados_tipo`
  MODIFY `id_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `insumos`
--
ALTER TABLE `insumos`
  MODIFY `id_insumo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `insumos_vendidos`
--
ALTER TABLE `insumos_vendidos`
  MODIFY `id_insumosv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id_inventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `inventario_dia`
--
ALTER TABLE `inventario_dia`
  MODIFY `id_inventario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `inventario_identificador`
--
ALTER TABLE `inventario_identificador`
  MODIFY `id_identificador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `inventario_movimientos`
--
ALTER TABLE `inventario_movimientos`
  MODIFY `idmovimiento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `medio_pago`
--
ALTER TABLE `medio_pago`
  MODIFY `idmedio_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `meses`
--
ALTER TABLE `meses`
  MODIFY `id_mes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `movimientos_tipo`
--
ALTER TABLE `movimientos_tipo`
  MODIFY `id_tipo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `parametrizador`
--
ALTER TABLE `parametrizador`
  MODIFY `id_parametrizador` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `pedidos_productos`
--
ALTER TABLE `pedidos_productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1006;

--
-- AUTO_INCREMENT de la tabla `productos_vendidos`
--
ALTER TABLE `productos_vendidos`
  MODIFY `id_vendido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT de la tabla `reportes`
--
ALTER TABLE `reportes`
  MODIFY `id_reportes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `sedes`
--
ALTER TABLE `sedes`
  MODIFY `id_sede` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id_token` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=271;

--
-- AUTO_INCREMENT de la tabla `unidades`
--
ALTER TABLE `unidades`
  MODIFY `id_unidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuarios_tipo`
--
ALTER TABLE `usuarios_tipo`
  MODIFY `idusuarios_tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
