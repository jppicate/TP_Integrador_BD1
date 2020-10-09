DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_pedido`(IN _id_pedido int)
BEGIN
    select id_pedido, fecha_pedido, concesionaria_id_concesionaria, modelo_id_modelo, cantidad  from pedido p
    inner join pedido_del_modelo pm on id_pedido=pedido_id_pedido
    where id_pedido=_id_pedido;
  END$$
DELIMITER ;



DELIMITER |

CREATE  PROCEDURE cargar_pedido(IN _id_pedido int)
BEGIN
DECLARE idPedidoParametro INTEGER DEFAULT 0;
DECLARE idChasis INTEGER DEFAULT 0;
DECLARE dFechaIngreso DATETIME;

DECLARE _modelo_id_modelo INTEGER;
DECLARE nCantidadDetalle INT;
DECLARE finished INT DEFAULT 0; 


DECLARE conteo INT;
-- Aca declaro el cursos para recorrer los detalles pero solo del pedido indicado en el parametro

    DECLARE curDetallePedido
        CURSOR FOR
            SELECT modelo_id_modelo, cantidad FROM pedido_del_modelo WHERE pedido_id_pedido = _id_pedido;
 
    DECLARE CONTINUE HANDLER
        FOR NOT FOUND SET finished = 1;
 
    OPEN curDetallePedido;


 
   -- Aca comienzo el loop recorriendo el cursor.
    getDetalle: LOOP

        FETCH curDetallePedido INTO _modelo_id_modelo, nCantidadDetalle;

        IF finished = 1 THEN
            LEAVE getDetalle;
        END IF;

	SET conteo = 0;

	-- Aca loopeo para hacer N inserts.
	WHILE 	conteo < nCantidadDetalle DO

	insert into vehiculo(modelo_id_modelo, pedido_id_pedido) values (_modelo_id_modelo, _id_pedido);

SET conteo = conteo  +1;

	END WHILE;

    END LOOP getDetalle;

-- Elimino el cursor de memoria

    CLOSE curDetallePedido;
    
    
    END
|

-- listar pedidos

select id_pedido, concesionaria_id_concesionaria, fecha_pedido, modelo_id_modelo, cantidad from pedido p
inner join pedido_del_modelo on id_pedido=pedido_id_pedido;

-- listar vehiculos sin fabricar

select * from vehiculo;
select id_chasis as Num_Chasis, modelo_id_modelo as Modelo, pedido_id_pedido, ingreso, estacion_trabajo_id_estacion from vehiculo v
left join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
where estacion_trabajo_id_estacion is null;

-- creamos un pedido nuevo
call abm_pedido(4, 127, '2020-10-9','2020-10-30',"alta",@_respuesta);
Select @_respuesta;
insert into pedido_del_modelo values (4, 1, 2);
insert into pedido_del_modelo values (4, 2, 2);
CALL `terminal_automotriz`.`mostrar_pedido`(4);
-- listar pedidos

select id_pedido, concesionaria_id_concesionaria, fecha_pedido, modelo_id_modelo, cantidad from pedido p
inner join pedido_del_modelo on id_pedido=pedido_id_pedido;

call cargar_pedido(4);

-- listar vehiculos sin fabricar

select * from vehiculo;
select id_chasis as Num_Chasis, modelo_id_modelo as Modelo, pedido_id_pedido, ingreso, estacion_trabajo_id_estacion from vehiculo v
left join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
where estacion_trabajo_id_estacion is null;


