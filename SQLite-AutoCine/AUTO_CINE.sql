BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "CIUDAD" (
	"idCiudad"	char(4) NOT NULL,
	"nomCiudad"	varchar(30) NOT NULL,
	CONSTRAINT "pk_CIUDAD" PRIMARY KEY("idCiudad")
);
CREATE TABLE IF NOT EXISTS "DEPARTAMENTO" (
	"idDepar"	char(6) NOT NULL,
	"nomDepar"	varchar(30) NOT NULL,
	CONSTRAINT "pk_DEPARTAMENTO" PRIMARY KEY("idDepar")
);
CREATE TABLE IF NOT EXISTS "GENERO" (
	"idGen"	char(4) NOT NULL,
	"nomGen"	varchar(30) NOT NULL,
	CONSTRAINT "pk_GENERO" PRIMARY KEY("idGen")
);
CREATE TABLE IF NOT EXISTS "CATEGORIA" (
	"idCateg"	char(4) NOT NULL,
	"nomCateg"	varchar(50) NOT NULL,
	CONSTRAINT "pk_CATEGORIA" PRIMARY KEY("idCateg")
);
CREATE TABLE IF NOT EXISTS "SERVICIOS" (
	"idServi"	char(5) NOT NULL,
	"precioServi"	varchar(30) NOT NULL,
	CONSTRAINT "pk_SERVICIOS" PRIMARY KEY("idServi")
);
CREATE TABLE IF NOT EXISTS "SALA" (
	"idSala"	char(3) NOT NULL,
	"area"	char(1) NOT NULL,
	"status"	char(1) NOT NULL,
	CONSTRAINT "pk_SALA" PRIMARY KEY("idSala")
);
CREATE TABLE IF NOT EXISTS "ADMINISTRADOR" (
	"idAdmin"	char(4) NOT NULL,
	"nomAdmin"	varchar(30) NOT NULL,
	"apelPaAdmin"	varchar(30) NOT NULL,
	"apelMaAdmin"	varchar(30),
	CONSTRAINT "pk_ADMINISTRADOR" PRIMARY KEY("idAdmin")
);
CREATE TABLE IF NOT EXISTS "PELICULAS" (
	"idPeli"	char(6) NOT NULL,
	"nomPeli"	varchar(30) NOT NULL,
	"Descripcion"	TEXT NOT NULL,
	"portPeli"	BLOB NOT NULL,
	CONSTRAINT "pk_PELICULAS" PRIMARY KEY("idPeli")
);
CREATE TABLE IF NOT EXISTS "UBICACION" (
	"nroUbic"	char(2) NOT NULL,
	"status"	char(1) NOT NULL,
	"idSala"	char(3) NOT NULL,
	CONSTRAINT "fk_SALA" FOREIGN KEY("idSala") REFERENCES "SALA"("idSala"),
	CONSTRAINT "pk_UBICACION" PRIMARY KEY("nroUbic")
);
CREATE TABLE IF NOT EXISTS "PROVINCIA" (
	"idProv"	char(6) NOT NULL,
	"nomProv"	varchar(30) NOT NULL,
	"idDepar"	char(6) NOT NULL,
	CONSTRAINT "fk_DEPARTAMENTO" FOREIGN KEY("idDepar") REFERENCES "DEPARTAMENTO"("idDepar"),
	CONSTRAINT "pk_PROVINCIA" PRIMARY KEY("idProv")
);
CREATE TABLE IF NOT EXISTS "DISTRITO" (
	"idDistrito"	char(6) NOT NULL,
	"nomDistrito"	varchar(30) NOT NULL,
	"idProv"	char(6) NOT NULL,
	CONSTRAINT "fk_PROVINCIA" FOREIGN KEY("idProv") REFERENCES "PROVINCIA"("idProv"),
	CONSTRAINT "pk_DISTRITO" PRIMARY KEY("idDistrito")
);
CREATE TABLE IF NOT EXISTS "USUARIO" (
	"idUser"	char(8) NOT NULL,
	"nomClien"	varchar(30) NOT NULL,
	"apelPaCliente"	varchar(30) NOT NULL,
	"apelMaCliente"	varchar(30),
	"sexoClien"	char(10) NOT NULL,
	"emailClien"	varchar(50) NOT NULL UNIQUE,
	"passwordUser"	varchar(50) NOT NULL,
	"fechaRegistro"	date NOT NULL,
	"idDistrito"	char(6) NOT NULL,
	"direccionClien"	varchar(50) NOT NULL,
	"idAdmin"	char(4) NOT NULL,
	CONSTRAINT "fk_ADMINISTRADOR" FOREIGN KEY("idDistrito") REFERENCES "DISTRITO"("idDistrito"),
	CONSTRAINT "fk_ADMINISTRADOR" FOREIGN KEY("idAdmin") REFERENCES "ADMINISTRADOR"("idAdmin"),
	CONSTRAINT "pk_USUARIO" PRIMARY KEY("idUser")
);
CREATE TABLE IF NOT EXISTS "CELULAR" (
	"idCelular"	char(3) NOT NULL,
	"nroCelular"	varchar(20) NOT NULL,
	"idUser"	char(8) NOT NULL,
	"idCiudad"	char(4) NOT NULL,
	CONSTRAINT "fk_USUARIO" FOREIGN KEY("idUser") REFERENCES "USUARIO"("idUser"),
	CONSTRAINT "fk_CIUDAD" FOREIGN KEY("idCiudad") REFERENCES "CIUDAD"("idCiudad"),
	CONSTRAINT "pk_CELULAR" PRIMARY KEY("idCelular")
);
CREATE TABLE IF NOT EXISTS "FUNCIONES" (
	"idFun"	char(4) NOT NULL,
	"fecha"	date NOT NULL,
	"horario"	time NOT NULL,
	"nroUbic"	char(2) NOT NULL UNIQUE,
	"precioFun"	REAL NOT NULL,
	"idAdmin"	char(4) NOT NULL,
	CONSTRAINT "fk_ADMINISTRADOR" FOREIGN KEY("idAdmin") REFERENCES "ADMINISTRADOR"("idAdmin"),
	CONSTRAINT "pk_FUNCIONES" PRIMARY KEY("idFun")
);
CREATE TABLE IF NOT EXISTS "FUN_SERVI" (
	"idFunServi"	char(5) NOT NULL,
	"idFun"	char(4) NOT NULL,
	"idServi"	char(5) NOT NULL,
	"cantServi"	char(2),
	"subtotal"	REAL,
	CONSTRAINT "fk_FUNCIONES" FOREIGN KEY("idFun") REFERENCES "FUNCIONES"("idFun"),
	CONSTRAINT "fk_SERVICIOS" FOREIGN KEY("idServi") REFERENCES "SERVICIOS"("idServi"),
	CONSTRAINT "pk_FUN_SERVI" PRIMARY KEY("idFunServi")
);
CREATE TABLE IF NOT EXISTS "FUN_PELIS" (
	"idFunPelis"	char(5) NOT NULL,
	"idFun"	char(4) NOT NULL,
	"idPeli"	char(6) NOT NULL,
	"Duracion"	time NOT NULL,
	CONSTRAINT "fk_PELICULAS" FOREIGN KEY("idPeli") REFERENCES "PELICULAS"("idPeli"),
	CONSTRAINT "fk_FUNCIONES" FOREIGN KEY("idFun") REFERENCES "FUNCIONES"("idFun"),
	CONSTRAINT "pk_FUN_SERVI" PRIMARY KEY("idFunPelis")
);
CREATE TABLE IF NOT EXISTS "PELIS_GEN" (
	"idPelisGen"	char(5) NOT NULL,
	"idPeli"	char(6) NOT NULL,
	"idGen"	char(4) NOT NULL,
	CONSTRAINT "fk_PELICULAS" FOREIGN KEY("idPeli") REFERENCES "PELICULAS"("idPeli"),
	CONSTRAINT "fk_GENERO" FOREIGN KEY("idGen") REFERENCES "GENERO"("idGen"),
	CONSTRAINT "pk_PELIS_GEN" PRIMARY KEY("idPelisGen")
);
CREATE TABLE IF NOT EXISTS "PELIS_CATEG" (
	"idPelisCateg"	char(5) NOT NULL,
	"idPeli"	char(6) NOT NULL,
	"idCateg"	char(4) NOT NULL,
	CONSTRAINT "fk_PELICULAS" FOREIGN KEY("idPeli") REFERENCES "PELICULAS"("idPeli"),
	CONSTRAINT "fk_CATEGORIA" FOREIGN KEY("idCateg") REFERENCES "CATEGORIA"("idCateg"),
	CONSTRAINT "pk_PELIS_CATEG" PRIMARY KEY("idPelisCateg")
);
CREATE TABLE IF NOT EXISTS "BOLETO" (
	"nroBoleto"	char(9) NOT NULL,
	"idUser"	char(8) NOT NULL,
	"idPeli"	char(6) NOT NULL,
	"idFun"	char(4) NOT NULL,
	"fechaBoleto"	date,
	"tipoPago"	varchar(20),
	"totalPago"	REAL,
	CONSTRAINT "fk_FUNCIONES" FOREIGN KEY("idFun") REFERENCES "FUNCIONES"("idFun"),
	CONSTRAINT "fk_USUARIO" FOREIGN KEY("idUser") REFERENCES "USUARIO"("idUser"),
	CONSTRAINT "fk_PELICULAS" FOREIGN KEY("idPeli") REFERENCES "PELICULAS"("idPeli"),
	CONSTRAINT "pk_BOLETO" PRIMARY KEY("nroBoleto")
);
COMMIT;
