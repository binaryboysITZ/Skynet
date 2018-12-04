create database VENTALIBROS;

use VENTALIBROS;

create table usuarios(
idusuario integer primary key,
nombre varchar(35),
direccion varchar(50))
engine = innodb;

create table ventas(
idusuario integer not null,
idlibro varchar(5) not null,
fecha date,
cantidad integer,
total double)
engine = innodb;

create table libros (
idlibro varchar(5) primary key,
titulo varchar(60),
editorial varchar(50),
precio double)
engine = innodb;

alter table ventas add constraint foreign key
(idusuario) references usuarios (idusuario)
on delete cascade on update cascade;

alter table ventas add constraint foreign key
(idlibro) references libros (idlibro)
on delete cascade on update cascade;

create procedure AltaUsuario(in id int, nombre varchar(50), direccion varchar(50))
begin
insert into usuarios(IdUsuario,Nombre,Direccion) values (id,nombre, direccion);
end;
//

create procedure AltaVentas(in idu int, idl varchar(10), fecha date, cantidad int, total float)
begin
insert into ventas(IdUsuario,IdLibro,Fecha, Cantidad, Total) values (idu,idl,fecha,cantidad,total);
end;
//

create procedure AltaLibros(in idl varchar(10), titulo varchar(50), editorial varchar(50), precio float)
begin
insert into libros(IdLibro,Titulo,Editorial,Precio) values (idl,titulo,editorial,precio);
end;
//

call AltaUsuario(100,"Juan Perez","Canteros 14")//
call AltaUsuario(101,"Melina Diaz","Soldadores 25")//
call AltaUsuario(102,"Victor Juarez","Mecanicos 15")//

call AltaLibros("L1","Taller De Base de Datos","McGraw-Hill",654.98)//
call AltaLibros("L2","Fundamentos De Base de Datos","PrenticeHail",755.00)//

call AltaVentas(100,"L1","2012-11-22",1,654.98)//
call AltaVentas(101,"L2","2012-11-22",1,1510.00)//

create procedure mostrarLib(in idus int)
	begin
	select titulo,fecha,nombre,usuarios.IdUsuario
	from usuarios,ventas,libros
	where (usuarios.idusuario = idus)
	and (usuarios.idusuario = ventas.idusuario)
	and (libros.IdLibro = ventas.IdLibro);
	end
	//

create trigger CalcularVenta after update on LIBROS
	for each row
	begin
	declare cantidad double;
	select ventas.cantidad into cantidad from ventas where IdLibro = new.idlibro;
	update ventas set total = new.precio*cantidad
	where (ventas.IdLibro = new.idlibro);
	end;
	//

update libros set precio = 750 where idlibro = 'L1'

update ventas set cantidad = 2 where idlibro = 'L1'//