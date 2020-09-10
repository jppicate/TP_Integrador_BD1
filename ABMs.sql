-- ****************** ABM modelos ***************************--
DELIMITER |

CREATE PROCEDURE abm_modelo (IN _id_modelo int, IN _nombre varchar(50), IN _descripcion varchar(100), IN accion varchar(10))
  BEGIN

    CASE 	accion
      WHEN 'alta' THEN 
      insert into modelo values (_id_modelo,_nombre,_descripcion);
      WHEN 'baja' THEN 
      delete from modelo where id_modelo=_id_modelo;
      WHEN 'mod' THEN
      update modelo set
		nombre=_nombre, descripcion=_descripcion where id_modelo=_id_modelo;
    END CASE;
    select * from modelo;
  END;
  |
  
  call abm_modelo(5,"Emma","Infantil","alta");
  call abm_modelo(5,"Emma2","Version 2","mod");
  call abm_modelo(5,"","","baja");
  
  -- ****************** ABM linea_montaje ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_linea_montaje(IN _id_linea int, IN _modelo_id_modelo int, IN _produccion_mes int, IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
			insert into linea_montaje values (_id_linea, _modelo_id_modelo, _produccion_mes);
		WHEN "baja" THEN
			delete from linea_montaje WHERE id_linea=_id_linea;
		WHEN "mod" THEN -- En este caso solo se puede modificar la columna que no es clave (produccion_mes), cualquier otro intento dara error
			update linea_montaje set
			produccion_mes=_produccion_mes where id_linea=_id_linea and modelo_id_modelo=_modelo_id_modelo;
	END CASE;
	select * from linea_montaje;
END
|


call abm_linea_montaje(3,1,50,"alta");		
call abm_linea_montaje(3,1,100,"mod");
call abm_linea_montaje(3,0,0,"baja");		
		
-- ****************** ABM tarea ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_tarea(IN _id_tarea int, IN _nombre varchar(50), IN _descripcion varchar(150), IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
			insert into tarea values (_id_tarea, _nombre, _descripcion);
		WHEN "baja" THEN
			delete from tarea WHERE id_tarea=_id_tarea;
		WHEN "mod" THEN 
			update tarea set
		nombre=_nombre, descripcion=_descripcion where id_tarea=_id_tarea;
	END CASE;
	select * from tarea;
END
|


call abm_tarea(6,"Otro","Prueba de alta","alta");		
call abm_tarea(6,"Otro 2","222222222222222 y 2","mod");
call abm_tarea(6,"","","baja");		
		

-- ****************** ABM estacion_trabajo ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_estacion_trabajo(IN _id_estacion int, IN _linea_id_linea int, IN _tarea_id_tarea int, IN _nombre varchar(50), IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
			insert into estacion_trabajo values (_id_estacion, _linea_id_linea, _tarea_id_tarea, _nombre);
		WHEN "baja" THEN
			delete from estacion_trabajo WHERE id_estacion=_id_estacion;
		WHEN "mod" THEN -- En este caso solo se puede modificar la columna que no es clave (nombre_estacion), cualquier otro intento dara error
			update estacion_trabajo set
			nombre_estacion=_nombre where id_estacion=_id_estacion;
	END CASE;
	select * from estacion_trabajo;
END
|


call abm_estacion_trabajo(11,1,1,"Prueba de Alta", "alta");		
call abm_estacion_trabajo(11,1,2,"Pruba de Modificacion", "mod");
call abm_estacion_trabajo(11,0,0,"","baja");		


-- ****************** ABM proveedor ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_proveedor(IN _cuit int, IN _nombre varchar(50), IN _descripcion varchar(100), IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
			insert into proveedor values (_cuit, _nombre, _descripcion);
		WHEN "baja" THEN
			delete from proveedor WHERE cuit=_cuit;
		WHEN "mod" THEN 
			update proveedor set
		nombre=_nombre, descripcion=_descripcion where cuit=_cuit;
	END CASE;
	select * from proveedor;
END
|


call abm_proveedor(12345678,"Empresa Nueva SA","Prueba de alta","alta");		
call abm_proveedor(12345678,"Empresa Mod SA","Prueba de mod","mod");
call abm_proveedor(12345678,"","","baja");		
		


-- ****************** ABM insumo ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_insumo(IN _id_insumo int, IN _nombre varchar(50), IN _descripcion varchar(150), IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
			insert into insumo values (_id_insumo, _nombre, _descripcion);
		WHEN "baja" THEN
			delete from insumo WHERE id_insumo=_id_insumo;
		WHEN "mod" THEN 
			update insumo set
		nombre=_nombre, descripcion=_descripcion where id_insumo=_id_insumo;
	END CASE;
	select * from insumo;
END
|


call abm_insumo(39,"IIIIOOOO2020","Prueba de alta","alta");		
call abm_insumo(39,"Otro 2","Prueba de Mod","mod");
call abm_insumo(39,"","","baja");		
		
-- ****************** ABM estacion_insumo ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_estacion_insumo(IN _estacion_id_estacion int, IN _insumo_id_insumo int, IN _cantidad int, IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
			insert into estacion_insumo values (_estacion_id_estacion, _insumo_id_insumo, _cantidad);
		WHEN "baja" THEN
			delete from estacion_insumo WHERE estacion_id_estacion=_estacion_id_estacion and insumo_id_insumo=_insumo_id_insumo;
		WHEN "mod" THEN -- En este caso solo se puede modificar la columna que no es clave (cantidad), cualquier otro intento dara error
			update estacion_insumo set
			cantidad=_cantidad where estacion_id_estacion=_estacion_id_estacion and insumo_id_insumo=_insumo_id_insumo;
	END CASE;
	select * from estacion_insumo;
END
|


call abm_estacion_insumo(10,1,1,"alta");		
call abm_estacion_insumo(10,1,333333, "mod");
call abm_estacion_insumo(10,1,0,"baja");		

-- ****************** ABM concesionaria ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_concesionaria(IN _id_concesionaria int, IN _nombre varchar(50), IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
			insert into concesionaria values (_id_concesionaria, _nombre);
		WHEN "baja" THEN
			delete from concesionaria WHERE id_concesionaria=_id_concesionaria;
		WHEN "mod" THEN 
			update concesionaria set
		nombre=_nombre where id_concesionaria=_id_concesionaria;
	END CASE;
	select * from concesionaria;
END
|


call abm_concesionaria(399,"Unla Motors","alta");		
call abm_concesionaria(399,"Otro 2","mod");
call abm_concesionaria(399,"","baja");	



	

-- ****************** ABM pedido ***************************--
  

 DELIMITER |
  
  CREATE PROCEDURE abm_pedido(IN _id_pedido int, IN _concesionaria_id_concesionaria int, IN _fecha_pedido date, IN _fecha_entrega date, IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
			insert into pedido values (_id_pedido, _concesionaria_id_concesionaria, _fecha_pedido, _fecha_entrega);
		WHEN "baja" THEN
			delete from pedido WHERE id_pedido=_id_pedido;
		WHEN "mod" THEN -- En este caso solo se pueden modificar las columnas que no son clave (fecha_pedido y fecha_entrega), cualquier otro intento dara error
			update pedido set
			fecha_pedido=_fecha_pedido, fecha_entrega=_fecha_entrega where id_pedido=_id_pedido and concesionaria_id_concesionaria=_concesionaria_id_concesionaria;
	END CASE;
	select * from pedido;
END
|


call abm_pedido(4,127,'20-08-15','20-12-15', "alta");		
call abm_pedido(4,127,'20-01-01','20-05-05',"mod");
call abm_pedido(4,127,'','',"baja");		

		
        
-- ****************** ABM vehiculo ***************************--
  

 DELIMITER |
  
  CREATE PROCEDURE abm_vehiculo(IN _id_chasis int, IN _modelo_id_modelo int, IN _pedido_id_pedido int, IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
			insert into vehiculo values (_id_chasis, _modelo_id_modelo, _pedido_id_pedido);
		WHEN "baja" THEN
			delete from vehiculo WHERE id_chasis=_id_chasis;
		WHEN "mod" THEN 
			update vehiculo set
			modelo_id_modelo=_modelo_id_modelo, pedido_id_pedido=_pedido_id_pedido where id_chasis=_id_chasis;
	END CASE;
	select * from vehiculo;
END
|


call abm_vehiculo(25,2,3, "alta");		
call abm_vehiculo(25,1,2,"mod");
call abm_vehiculo(25,0,0,"baja");		


-- ****************** ABM pedido_del_modelo ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_pedido_del_modelo(IN _pedido_id_pedido int, IN _modelo_id_modelo int, IN _cantidad int, IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
			insert into pedido_del_modelo values (_pedido_id_pedido, _modelo_id_modelo, _cantidad);
		WHEN "baja" THEN
			delete from pedido_del_modelo WHERE pedido_id_pedido=_pedido_id_pedido;
		WHEN "mod" THEN -- En este caso solo se puede modificar la columna que no es clave (cantidad), cualquier otro intento dara error
			update pedido_del_modelo set
			cantidad=_cantidad where pedido_id_pedido=_pedido_id_pedido;
	END CASE;
	select * from pedido_del_modelo;
END
|


call abm_pedido_del_modelo(4,1,1,"alta");		
call abm_pedido_del_modelo(4,1,10, "mod");
call abm_pedido_del_modelo(4,0,0,"baja");		


-- ****************** ABM estacion_vehiculo ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_estacion_vehiculo(IN _vehiculo_id_chasis int, IN _estacion_trabajo_id_estacion int, IN _ingreso datetime, IN _egreso datetime, IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
			insert into estacion_vehiculo values (_vehiculo_id_chasis, _estacion_trabajo_id_estacion, _ingreso, _egreso);
		WHEN "baja" THEN
			delete from estacion_vehiculo WHERE vehiculo_id_chasis=_vehiculo_id_chasis and estacion_trabajo_id_estacion=_estacion_trabajo_id_estacion;
		WHEN "mod" THEN -- En este caso solo se puede modificar la columna que no es clave (ingreso y egreso), cualquier otro intento dara error
			update estacion_vehiculo set
			ingreso=_ingreso, egreso=_egreso where vehiculo_id_chasis=_vehiculo_id_chasis and estacion_trabajo_id_estacion=_estacion_trabajo_id_estacion;
	END CASE;
	select * from estacion_vehiculo;
END
|


call abm_estacion_vehiculo(15,3,'2013-11-24 17:15:10','2013-11-24 20:15:10',"alta");		
call abm_estacion_vehiculo(15,3,'2222-11-24 17:15:10','2222-11-24 20:15:10', "mod");
call abm_estacion_vehiculo(15,3,'2013-11-24 17:15:10','2013-11-24 20:15:10',"baja");		




-- ****************** ABM proveedor_detalle_insumo ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_proveedor_detalle_insumo(IN _proveedor_cuit int, IN _insumo_id_insumo int, IN _precio int, IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
			insert into proveedor_detalle_insumo values (_proveedor_cuit, _insumo_id_insumo, _precio);
		WHEN "baja" THEN
			delete from proveedor_detalle_insumo WHERE proveedor_cuit=_proveedor_cuit and insumo_id_insumo=_insumo_id_insumo;
		WHEN "mod" THEN -- En este caso solo se puede modificar la columna que no es clave (precio), cualquier otro intento dara error
			update proveedor_detalle_insumo set
			precio=_precio where proveedor_cuit=_proveedor_cuit and insumo_id_insumo=_insumo_id_insumo;
	END CASE;
	select * from proveedor_detalle_insumo;
END
|


call abm_proveedor_detalle_insumo(111111111,10,500,"alta");		
call abm_proveedor_detalle_insumo(111111111,10,22222, "mod");
call abm_proveedor_detalle_insumo(111111111,10,0,"baja");		