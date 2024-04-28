CREATE TABLE LUGAR(
    id INT  AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50)NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    fk_tipo INT,
    CONSTRAINT lugar_pk PRIMARY KEY(id),
    CONSTRAINT lugar_fk FOREIGN KEY(fk_tipo) REFERENCES LUGAR(id)
);

CREATE TABLE CLIENTE(
    cedula_cli INT UNIQUE,
    nombre_cli VARCHAR(20) NOT NULL,
    apellido_cli VARCHAR(20) NOT NULL,
    genero CHAR NOT NULL,
    fk_lugar INT,
    CONSTRAINT cliente_pk PRIMARY KEY(cedula_cli),
    CONSTRAINT lp_fk_cliente FOREIGN KEY(fk_lugar) REFERENCES LUGAR(id)
);

CREATE TABLE EMPLEADO(
    cedula_emp INT UNIQUE,
    nombre_emp VARCHAR(20) NOT NULL,
    apellido_emp VARCHAR(20) NOT NULL,
    fecha_nac DATE NOT NULL,
    genero_emp CHAR NOT NULL,
    correo VARCHAR(50) NOT NULL,
    telefono VARCHAR(30) NOT NULL,
    fk_lugar INT,
    CONSTRAINT empleado_pk PRIMARY KEY(cedula_emp),
    CONSTRAINT lp_fk FOREIGN KEY(fk_lugar) REFERENCES LUGAR(id)
);

CREATE TABLE FACTURA(
    id_factura INT AUTO_INCREMENT,
    fecha_emision DATE NOT NULL,
    total INT NOT NULL,
    cliente_fk INT,
    fk_empleado INT,
    CONSTRAINT factura_pk PRIMARY KEY(id_factura),
    CONSTRAINT fact_cli_fk FOREIGN KEY(cliente_fk) REFERENCES CLIENTE(cedula_cli),
    CONSTRAINT fact_emp_fk FOREIGN KEY(fk_empleado) REFERENCES EMPLEADO(cedula_emp)
);

CREATE TABLE CONTRATO_EMPLEADO(
    id_contrato INT AUTO_INCREMENT,
    fecha_ingreso DATE NOT NULL,
    fecha_egreso DATE,
    fk_emp INT NOT NULL,
    CONSTRAINT id_contrato PRIMARY KEY(id_contrato),
    CONSTRAINT emp_cont_fk FOREIGN KEY(fk_emp) REFERENCES EMPLEADO(cedula_emp)
);

CREATE TABLE HORARIO(
    id_horario INT AUTO_INCREMENT,
    hora_entrada TIME NOT NULL,
    hora_salida TIME NOT NULL,
    dia_semana VARCHAR(10) NOT NULL,
    CONSTRAINT horario_pk PRIMARY KEY(id_horario)
);

CREATE TABLE C_H(
    id_cont_hor INT AUTO_INCREMENT,
    contrato_fk INT NOT NULL,
    fk_horario INT NOT NULL,
    CONSTRAINT c_h_pk PRIMARY KEY(id_cont_hor),
    CONSTRAINT fk_ch_hor FOREIGN KEY(fk_horario) REFERENCES HORARIO(id_horario),
    CONSTRAINT fk_ch_contrato FOREIGN KEY(contrato_fk) REFERENCES CONTRATO_EMPLEADO(id_contrato)
);

CREATE TABLE CARGO(
    id_cargo INT AUTO_INCREMENT,
    nombre_cargo VARCHAR(50) NOT NULL,
    sueldo_hora DECIMAL NOT NULL,
    CONSTRAINT cargo_pk PRIMARY KEY(id_cargo)
);

CREATE TABLE CATEGORIA(
    id_categoria INT AUTO_INCREMENT,
    nombre_categoria VARCHAR(50) NOT NULL,
    CONSTRAINT categoria_pk PRIMARY KEY(id_categoria)
);

CREATE TABLE C_C(
    id_cargo_cont INT AUTO_INCREMENT,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    sueldo DECIMAL NOT NULL,
    fk_cargo INT NOT NULL,
    cont_fk INT NOT NULL,
    CONSTRAINT cc_pk PRIMARY KEY(id_cargo_cont),
    CONSTRAINT cc_cargo_fk FOREIGN KEY(fk_cargo) REFERENCES CARGO(id_cargo),
    CONSTRAINT cc_cont_fk FOREIGN KEY(cont_fk) REFERENCES CONTRATO_EMPLEADO(id_contrato)
);

CREATE TABLE ENTRADA_SALIDA(
    id_ent_sal INT AUTO_INCREMENT,
    hora_entrada DATETIME  NOT NULL,
    hora_salida DATETIME,
    fk_contrato INT NOT NULL,
    semana_dia VARCHAR(10) NOT NULL,
    CONSTRAINT ent_sal_pk PRIMARY KEY(id_ent_sal),
    CONSTRAINT esc_fk FOREIGN KEY(fk_contrato) REFERENCES CONTRATO_EMPLEADO(id_contrato)
); 

CREATE TABLE PRODUCTO(
    id_producto INT AUTO_INCREMENT,
    imagen_p longblob NOT NULL,
    nombre_p VARCHAR(50) NOT NULL,
    descripcion_p VARCHAR(500) NOT NULL,
    fk_categoria INT,
    CONSTRAINT producto_pk PRIMARY KEY(id_producto),
    CONSTRAINT cat_prod_fk FOREIGN KEY(fk_categoria) REFERENCES CATEGORIA(id_categoria)
);

CREATE TABLE INVENTARIO(
    id_inventario INT AUTO_INCREMENT,
    cantidad_disp INT NOT NULL,
    producto_fk INT NOT NULL,
    CONSTRAINT inventario_pk PRIMARY KEY(id_inventario),
    CONSTRAINT pro_inv_fk FOREIGN KEY(producto_fk) REFERENCES PRODUCTO(id_producto)
);

CREATE TABLE DETALLE_FACTURA(
    id_det_fact INT AUTO_INCREMENT,
    cantidad_prod INT NOT NULL,
    precio_unitario DECIMAL NOT NULL,
    descuento INT,
    fk_factura INT  NOT NULL,
    fk_inventario INT NOT NULL,
    CONSTRAINT det_fact_pk PRIMARY KEY(id_det_fact),
    CONSTRAINT detfact_fact_fk FOREIGN KEY(fk_factura) REFERENCES FACTURA(id_factura),
    CONSTRAINT detfact_inv_fk FOREIGN KEY(fk_inventario) REFERENCES INVENTARIO(id_inventario)
);

CREATE TABLE HIST_PRECIO_VENTA(
    id_pv INT AUTO_INCREMENT,
    valor_pv FLOAT NOT NULL,
    fecha_inicio_pv DATE NOT NULL,
    fecha_fin_pv DATE,
    fk_inv INT,
    CONSTRAINT pv_pk PRIMARY KEY(id_pv),
    CONSTRAINT pv_inv_fk FOREIGN KEY(fk_inv) REFERENCES INVENTARIO(id_inventario)
);

--LUGAR  35 inserts
INSERT INTO LUGAR(nombre,tipo,fk_tipo) VALUES('Venezuela','país',null);
INSERT INTO LUGAR(nombre,tipo, fk_tipo) SELECT 'Distrito Capital', 'estado', id FROM LUGAR WHERE tipo='país' AND nombre='Venezuela';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Miranda','estado',id from LUGAR where tipo='país' and nombre='Venezuela';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Libertador','municipio',id from LUGAR where tipo='estado' and nombre='Distrito Capital';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Sucre','municipio',id from LUGAR where tipo='estado' and nombre='Miranda';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'El Hatillo','municipio',id from LUGAR where tipo='estado' and nombre='Miranda';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Baruta','municipio',id from LUGAR where tipo='estado' and nombre='Miranda';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Chacao','municipio',id from LUGAR where tipo='estado' and nombre='Miranda';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Altagracia','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Antímano','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT '23 de enero','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'El Junquito','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'La Pastora','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'La Vega','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'San José','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'San Agustín','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'San Juan','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'San Pedro','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Santa Rosalía','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'El Paraíso','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Caricuao','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Sucre','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'El Valle','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'El Recreo','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'La Candelaria','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Santa Teresa','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Macarao','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'San Bernardino','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Coche','parroquia',id from LUGAR where tipo='municipio' and nombre='Libertador';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'El Cafetal','parroquia',id from LUGAR where tipo='municipio' and nombre='Baruta';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Las Minas','parroquia',id from LUGAR where tipo='municipio' and nombre='Baruta';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Baruta','parroquia',id from LUGAR where tipo='municipio' and nombre='Baruta';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Chacao','parroquia',id from LUGAR where tipo='municipio' and nombre='Chacao';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Leoncio Martínez','parroquia',id from LUGAR where tipo='municipio' and nombre='Sucre';
INSERT INTO LUGAR(nombre,tipo,fk_tipo) SELECT 'Santa Rosalía de Palermo','parroquia',id from LUGAR where tipo='municipio' and nombre='El Hatillo';

--CLIENTE 50 inserts
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(9987456,'Maria','Garcia','F',(select id from LUGAR where tipo='parroquia' and nombre='Santa Rosalía de Palermo'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(20014567,'Maria','Collantes','F',(select id from LUGAR where tipo='parroquia' and nombre='Leoncio Martínez'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(10234567,'Hilaria','Alvarado','F',(select id from LUGAR where tipo='parroquia' and nombre='Chacao'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(11000011,'Vilmaris','Ascanio','F',(select id from LUGAR where tipo='parroquia' and nombre='Baruta'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(13098765,'Anita','Dugarte','F',(select id from LUGAR where tipo='parroquia' and nombre='El Cafetal'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(21034567,'Maria','Arcila','F',(select id from LUGAR where tipo='parroquia' and nombre='El Recreo'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(25067890,'Jenny','Gonzalez','F',(select id from LUGAR where tipo='parroquia' and nombre='El Valle'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(27012345,'Fabiola','Castillo','F',(select id from LUGAR where tipo='parroquia' and nombre='Caricuao'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(25000134,'Karleidis','Gonzalez','F',(select id from LUGAR where tipo='parroquia' and nombre='Santa Rosalía'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(13098776,'Eliz','Chacon','F',(select id from LUGAR where tipo='parroquia' and nombre='San José'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(14012356,'Marisela','Pinto','F',(select id from LUGAR where tipo='parroquia' and nombre='La Vega'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(16078912,'Romina','Sanchez','F',(select id from LUGAR where tipo='parroquia' and nombre='La Pastora'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(17045689,'Jhoanna','Gomez','F',(select id from LUGAR where tipo='parroquia' and nombre='El Junquito'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(18012356,'Aura','Leal','F',(select id from LUGAR where tipo='parroquia' and nombre='23 de enero'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(19078665,'Carliana','Morillo','F',(select id from LUGAR where tipo='parroquia' and nombre='San Juan'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(21034576,'Francis','Caro','F',(select id from LUGAR where tipo='parroquia' and nombre='Altagracia'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(26034576,'Silmarys','Garcia','F',(select id from LUGAR where tipo='parroquia' and nombre='Leoncio Martínez'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(27012356,'Felix','Peralta','M',(select id from LUGAR where tipo='parroquia' and nombre='Santa Rosalía de Palermo'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(15498765,'Milanyela','Viloria','F',(select id from LUGAR where tipo='parroquia' and nombre='El Valle'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(25014576,'Vanessa','Enrique','F',(select id from LUGAR where tipo='parroquia' and nombre='La Candelaria'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(25070134,'Yuneisy','Morales','F',(select id from LUGAR where tipo='parroquia' and nombre='La Vega'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(12845689,'Lislie','Pacheco','F',(select id from LUGAR where tipo='parroquia' and nombre='San José'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(17345689,'Evelin','Marin','F',(select id from LUGAR where tipo='parroquia' and nombre='Leoncio Martínez'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(18812356,'Yamileth','Jimenez','F',(select id from LUGAR where tipo='parroquia' and nombre='El paraíso'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(21134576,'Ruth','Bustamante','F',(select id from LUGAR where tipo='parroquia' and nombre='Chacao'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(12045678,'Armando','Melendez','M',(select id from LUGAR where tipo='parroquia' and nombre='Las Minas'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(14012345,'Kenis','Cesin','M',(select id from LUGAR where tipo='parroquia' and nombre='Coche'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(16078901,'Juan','Salas','M',(select id from LUGAR where tipo='parroquia' and nombre='San Bernardino'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(17045678,'Jhoeny','Aponte','M',(select id from LUGAR where tipo='parroquia' and nombre='Macarao'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(18012345,'Robert','Teran','M',(select id from LUGAR where tipo='parroquia' and nombre='Santa Teresa'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(19078654,'Pedro','Dacduk','M',(select id from LUGAR where tipo='parroquia' and nombre='La Candelaria'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(26034567,'Gregory','Tovar','M',(select id from LUGAR where tipo='parroquia' and nombre='Sucre'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(15098765,'Yonathan','Romero','M',(select id from LUGAR where tipo='parroquia' and nombre='La Pastora'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(20014576,'Rafael','Valera','M',(select id from LUGAR where tipo='parroquia' and nombre='El Paraíso'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(10234576,'Julian','Freites','M',(select id from LUGAR where tipo='parroquia' and nombre='San Juan'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(11000022,'Yvan','Sosa','M',(select id from LUGAR where tipo='parroquia' and nombre='San Pedro'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(12045689,'Jose','Mogollon','M',(select id from LUGAR where tipo='parroquia' and nombre='San Agustín'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(22012356,'Luis','Torrado','M',(select id from LUGAR where tipo='parroquia' and nombre='Chacao'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(25067891,'Jose','Segura','M',(select id from LUGAR where tipo='parroquia' and nombre='Baruta'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(9950001,'Luis','Infante','M',(select id from LUGAR where tipo='parroquia' and nombre='San Agustín'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(11123456,'Milagros','Perez','F',(select id from LUGAR where tipo='parroquia' and nombre='Chacao'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(16234576,'José','Medina','M',(select id from LUGAR where tipo='parroquia' and nombre='Caricuao'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(11345422,'Jose','Vargas','M',(select id from LUGAR where tipo='parroquia' and nombre='El Cafetal'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(13598776,'Luis','Rodriguez','M',(select id from LUGAR where tipo='parroquia' and nombre='Altagracia'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(14712356,'Loismer','Cuellar','M',(select id from LUGAR where tipo='parroquia' and nombre='Antímano'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(16578912,'Alcides','Mora','M',(select id from LUGAR where tipo='parroquia' and nombre='San Pedro'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(19978665,'Julio','Martinez','M',(select id from LUGAR where tipo='parroquia' and nombre='Las Minas'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(22712356,'Julio','Ruiz','M',(select id from LUGAR where tipo='parroquia' and nombre='Sucre'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(23645689,'Juan','Guzman','M',(select id from LUGAR where tipo='parroquia' and nombre='23 de enero'));
INSERT INTO CLIENTE(cedula_cli,nombre_cli,apellido_cli,genero,fk_lugar) VALUES(24112356,'Julio','Coiran','M',(select id from LUGAR where tipo='parroquia' and nombre='Santa Rosalía'));

--EMPLEADO 50 inserts
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(18485412,'Ronald','Castro','M','1988-01-02','rcastro97@gmail.com','4139018926',(select id from LUGAR where tipo='parroquia' and nombre='La Candelaria'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(15200135,'Jorge','Ral','M','1980-05-10','raljorge2014@gmail.com','4120278601',(select id from LUGAR where tipo='parroquia' and nombre='El Valle'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(15040464,'Michael','Rivas','M','1981-14-07','michaelrivasr@gmail.com','4129020048',(select id from LUGAR where tipo='parroquia' and nombre='La Candelaria'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(14021832,'Hector','Azuaje','M','1984-08-17','hectormazuaje@gmail.com','4241298491',(select id from LUGAR where tipo='parroquia' and nombre='Santa Rosalía'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(16382963,'Juan','Parra','M','1980-01-02','rcastro97@gmail.com','4127768861',(select id from LUGAR where tipo='parroquia' and nombre='El Recreo'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(17719600,'Miguel','Caballero','M','1986-07-16','miqueleknight@gmail.com','4142027298',(select id from LUGAR where tipo='parroquia' and nombre='El Recreo'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(16682634,'Jesús','Fajardo','M','1986-05-14','jesusfajardo0305@gmail.com','412560388',(select id from LUGAR where tipo='parroquia' and nombre='Sucre'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(15613660,'Horacio','Tirado','M','1986-09-02','horacioot09@gmail.com','4125853863',(select id from LUGAR where tipo='parroquia' and nombre='Altagracia'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(17116471,'Carlos','Herrera','M','1983-12-08','herreracarloss@gmail.com','42441521744',(select id from LUGAR where tipo='parroquia' and nombre='Baruta'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(15506254,'Mendelson','Cedeño','M','1986-04-23','mendelsonced@gmail.com','4242707166',(select id from LUGAR where tipo='parroquia' and nombre='La Pastora'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(15337842,'Oscar','Villanueva','M','1988-06-03','ovillanueva12@gmail.com','4168950758',(select id from LUGAR where tipo='parroquia' and nombre='San Agustín'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(19022950,'Carlos','Macuma','M','1989-01-20','carlosisaias89@gmail.com','4248432251',(select id from LUGAR where tipo='parroquia' and nombre='El Cafetal'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(24723408,'Eduardo','Bustamente','M','1994-02-24','bustamanteman24@gmail.com','4125538489',(select id from LUGAR where tipo='parroquia' and nombre='Las Minas'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(30115310,'Daniel','Trujillo','M','1990-07-27','dannytrujillo89@gmail.com','4241556055',(select id from LUGAR where tipo='parroquia' and nombre='Sucre'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(24210444,'Angel','Velasquez','M','2004-09-13','angelvelasquez13@gmail.com','4129846555',(select id from LUGAR where tipo='parroquia' and nombre='La Candelaria'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(29861711,'Romny','Malavé','M','2003-09-02','malaverommaan@gmail.com','4123750396',(select id from LUGAR where tipo='parroquia' and nombre='Macarao'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(29861430,'Oscar','Castellano','M','1988-01-02','oscarcatellano@gmail.com','4241882488',(select id from LUGAR where tipo='parroquia' and nombre='Caricuao'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(21262403,'Rafael','Villero','M','1995-12-14','rafaelvillero@gmail.com','4189978190',(select id from LUGAR where tipo='parroquia' and nombre='La Candelaria'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(24210484,'Erick','Berroteran','M','1994-08-11','berroteranerick@gmail.com','4242013814',(select id from LUGAR where tipo='parroquia' and nombre='El Valle'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(25755819,'Luis','Amaya','M','1993-11-25','luismtamayaya@gmail.com','4126898532',(select id from LUGAR where tipo='parroquia' and nombre='San José'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(19335806,'Cristian','Celis','M','1992-04-01','chriscelis9292@gmail.com','4241376181',(select id from LUGAR where tipo='parroquia' and nombre='El Valle'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(27741713,'Cesar','Leon','M','2000-02-18','caleon98@gmail.com','4129122825',(select id from LUGAR where tipo='parroquia' and nombre='Caricuao'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(28308698,'Victor','Blanco','M','2001-06-14','victorwhite@gmail.com','4242333582',(select id from LUGAR where tipo='parroquia' and nombre='Sucre'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(29987210,'Jose','Duran','M','2002-06-13','joseduran54@gmail.com','4241909460',(select id from LUGAR where tipo='parroquia' and nombre='Leoncio Martínez'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(21131494,'Samuel','Rodriguez','M','1988-07-07','samuelrod07@gmail.com','4141368121',(select id from LUGAR where tipo='parroquia' and nombre='Altagracia'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(16411632,'Maria','De Simone','F','1984-06-15','mariasimone@gmail.com','4120194539',(select id from LUGAR where tipo='parroquia' and nombre='San Pedro'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(17977425,'Karelis','Villalta','F','1988-03-24','krelisvilla01@gmail.com','424269302',(select id from LUGAR where tipo='parroquia' and nombre='San Juan'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(13748084,'Ana','Peña','F','1979-11-07','anitapeña@gmail.com','4141188242',(select id from LUGAR where tipo='parroquia' and nombre='23 de enero'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(20793899,'Florangel','Amado','F','1988-02-26','floramado2000@gmail.com','4242897522',(select id from LUGAR where tipo='parroquia' and nombre='Sucre'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(15574606,'Veronica','De Simone','F','1982-10-01','veronisimonevs@gmail.com','4128246980',(select id from LUGAR where tipo='parroquia' and nombre='San Pedro'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(17641976,'Vanessa','Capote','F','1988-03-26','vanessacapote26@gmail.com','4127316217',(select id from LUGAR where tipo='parroquia' and nombre='Chacao'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(17642304,'Emily','Galicia','F','1987-10-21','emilygal87@gmail.com','4241336164',(select id from LUGAR where tipo='parroquia' and nombre='El Paraíso'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(13636795,'Francis','Domar','F','1981-06-08','franciscutedom@gmail.com','4123857397',(select id from LUGAR where tipo='parroquia' and nombre='Chacao'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(15403505,'Elba','Perales','F','1981-04-11','danielperalese@gmail.com','4164284489',(select id from LUGAR where tipo='parroquia' and nombre='La Vega'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(16556250,'Romina','Gandaraz','F','1983-01-17','romigandaraz17@gmail.com','4241557368',(select id from LUGAR where tipo='parroquia' and nombre='San Juan'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(16413537,'Leidy','Sanchez','F','1985-08-01','leidysanchez24@gmail.com','4142780630',(select id from LUGAR where tipo='parroquia' and nombre='Baruta'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(17148667,'Jessica','Cedeño','F','1987-09-15','jessyced2001@gmail.com','4241512576',(select id from LUGAR where tipo='parroquia' and nombre='Santa Teresa'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(18364270,'Grecia','Acosta','F','1986-11-20','greekacosta24@gmail.com','4141171212',(select id from LUGAR where tipo='parroquia' and nombre='23 de enero'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(19606815,'Arianna','Velasquez','F','1997-06-12','arisitavelasquez@gmail.com','4241539100',(select id from LUGAR where tipo='parroquia' and nombre='El Valle'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(28180142,'América','Castellano','F','2001-11-06','americancastellano@gmail.com','414089650',(select id from LUGAR where tipo='parroquia' and nombre='Caricuao'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(26647943,'Dubraska','Gonzalez','F','2000-03-21','gonzalesdubris@gmail.com','4269081330',(select id from LUGAR where tipo='parroquia' and nombre='San Juan'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(30720094,'Alejandra','Farias','F','2004-07-12','alejandrafarias33@gmail.com','4242195857',(select id from LUGAR where tipo='parroquia' and nombre='El Paraíso'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(27965641,'Krisdeilys','Oropeza','F','2002-04-22','krissyoropeza22@gmail.com','4241679160',(select id from LUGAR where tipo='parroquia' and nombre='La Pastora'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(27472755,'Yunaire','Ortega','F','1999-10-15','yuniortega1999@gmail.com','4141214539',(select id from LUGAR where tipo='parroquia' and nombre='San Bernardino'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(24216176,'Dayana','Cordero','F','1996-05-09','dayaniscordero98@gmail.com','4242060839',(select id from LUGAR where tipo='parroquia' and nombre='La Candelaria'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(24577571,'Klayramal','Alvarez','F','1994-06-25','klayraalvarez6@gmail.com','4128420769',(select id from LUGAR where tipo='parroquia' and nombre='La Candelaria'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(24812956,'Cindy','Morales','F','1997-01-18','cindymm2020@gmail.com','4122081446',(select id from LUGAR where tipo='parroquia' and nombre='Santa Rosalía de Palermo'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(25234284,'Lineth','Zambrano','F','1997-08-12','linethlzambrano@gmail.com','4122839144',(select id from LUGAR where tipo='parroquia' and nombre='El Valle'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(26459925,'Maria','Anton','F','1998-04-02','antomaria2021@gmail.com','4249479789',(select id from LUGAR where tipo='parroquia' and nombre='El Recreo'));
INSERT INTO EMPLEADO(cedula_emp,nombre_emp,apellido_emp,genero_emp,fecha_nac,correo,telefono,fk_lugar) VALUES(30468132,'Adriana','Contreras','F','2004-09-07','adrianitacontreras@gmail.com','4241482458',(select id from LUGAR where tipo='parroquia' and nombre='Coche'));

--CONTRATO_EMPLEADO 50 inserts
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-10-05', '2024-03-03', EMPLEADO.cedula_emp FROM EMPLEADO WHERE EMPLEADO.cedula_emp= '18485412';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-03-15','2024-03-31',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='15200135';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-01-17','2023-3-10',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='21131494';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-2-11','2023-5-16',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='29987210';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-11-27','2023-7-31',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='19335806';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-9-30','2023-11-21',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='25755819';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-05-05','2023-5-12',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='15040464';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-9-20','2023-2-26',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='14021832';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-4-16','2023-5-5',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='24210484';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-2-27','2024-1-30',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='21262403';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-6-4','2023-2-26',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='16382963';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-8-6','2023-6-28',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='17719600';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-2-15','2024-2-9',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='16682634';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-1-13','2023-8-29',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='17641976';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-3-31','2023-12-12',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='30468132';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-5-27','2024-11-30',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='24216176';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-7-15','2024-3-20',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='24577571';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-4-21','2024-4-11',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='26459925';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-11-11','2024-3-1',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='25234284';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-1-30','2024-2-25',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='24812956';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-12-9','2023-2-28',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='16411632';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-4-7','2023-7-10',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='17977425';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-9-19','2023-12-06',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='13748084';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-10-1','2024-1-22',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='20793899';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-5-10','2024-3-18',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='15574606';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-7-18',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='27472755';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-1-27',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='27965641';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-3-21',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='30720094';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-1-2',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='26647943';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-4-14',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='28180142';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2024-2-4',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='19606815';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-10-31',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='18364270';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2024-4-13',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='17148667';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-11-7',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='16413537';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-8-20',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='16556250';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-04-08',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='15403505';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-05-23',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='13636795';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2024-03-07',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='17642304';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2024-01-19',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='15613660';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-10-08',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='17116471';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-11-20',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='15506254';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-4-7',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='15337842';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-12-1',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='19022950';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-4-3',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='24723408';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2024-1-15',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='30115310';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-6-13',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='24210444';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-6-14',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='29861711';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-2-16',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='29861430';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2024-1-18',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='27741713';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-9-14',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='28308698';

INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('08:00:00', '16:00:00','LUNES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('09:00:00', '17:00:00','MARTES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('10:00:00', '18:00:00','MIÉRCOLES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('11:00:00', '19:00:00','JUEVES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('12:00:00', '20:00:00','VIERNES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('13:00:00', '21:00:00','SÁBADO');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('14:00:00', '22:00:00','DOMINGO');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('15:00:00', '23:00:00','LUNES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('16:00:00', '00:00:00','MARTES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('17:00:00', '01:00:00','JUEVES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('18:00:00', '02:00:00','VIERNES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('19:00:00', '03:00:00','SÁBADO');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('20:00:00', '04:00:00','DOMINGO');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('21:00:00', '05:00:00','DOMINGO');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('22:00:00', '06:00:00','LUNES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('23:00:00', '07:00:00','MARTES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('08:30:00', '16:30:00','MIÉRCOLES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('09:30:00', '17:30:00','JUEVES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('10:30:00', '18:30:00','VIERNES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('11:30:00', '19:30:00','SÁBADO');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('12:30:00', '20:30:00','DOMINGO');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('13:30:00', '21:30:00','LUNES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('14:30:00', '22:30:00','MARTES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('15:30:00', '23:30:00','MIÉRCOLES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('16:30:00', '00:30:00','JUEVES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('17:30:00', '01:30:00','JUEVES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('18:30:00', '02:30:00','VIERNES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('19:30:00', '03:30:00','SÁBADO');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('20:30:00', '04:30:00','LUNES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('21:30:00', '05:30:00','MARTES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('22:30:00', '06:30:00','MIÉRCOLES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('23:30:00', '07:30:00','JUEVES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('08:15:00', '16:15:00','VIERNES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('09:15:00', '17:15:00','SÁBADO');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('10:15:00', '18:15:00','LUNES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('11:15:00', '19:15:00','MARTES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('12:15:00', '20:15:00','MIÉRCOLES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('13:15:00', '21:15:00','JUEVES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('14:15:00', '22:15:00','VIERNES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('15:15:00', '23:15:00','VIERNES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('16:15:00', '00:15:00','LUNES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('17:15:00', '01:15:00','MARTES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('18:15:00', '02:15:00','MIÉRCOLES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('19:15:00', '03:15:00','JUEVES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('20:15:00', '04:15:00','VIERNES');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('21:15:00', '05:15:00','SÁBADO');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('22:15:00', '06:15:00','DOMINGO');
INSERT INTO HORARIO (hora_entrada, hora_salida,dia_semana) VALUES ('23:15:00', '07:15:00','LUNES');

INSERT INTO CATEGORIA(nombre_categoria) VALUES('Medicamento');
INSERT INTO CATEGORIA(nombre_categoria) VALUES('Cuidado personal');
INSERT INTO CATEGORIA(nombre_categoria) VALUES('Suplementos y Vitaminas');
INSERT INTO CATEGORIA(nombre_categoria) VALUES('Equipos y Dispositivos Médicos');
INSERT INTO CATEGORIA(nombre_categoria) VALUES('Botiquín');
INSERT INTO CATEGORIA(nombre_categoria) VALUES('Dietética');
INSERT INTO CATEGORIA(nombre_categoria) VALUES('Cosmética');
INSERT INTO CATEGORIA(nombre_categoria) VALUES('Infantil');
INSERT INTO CATEGORIA(nombre_categoria) VALUES('Ortopedia');

INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='08:00:00' and hora_salida='16:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '18485412')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='09:00:00' and hora_salida='17:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '15200135')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='10:00:00' and hora_salida='18:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '21131494')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='11:00:00' and hora_salida='19:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '29987210')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='12:00:00' and hora_salida='20:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '19335806')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='13:00:00' and hora_salida='21:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '27472755')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='14:00:00' and hora_salida='22:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '27965641')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='15:00:00' and hora_salida='23:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '30720094')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='16:00:00' and hora_salida='00:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '28180142')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='17:00:00' and hora_salida='01:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '19606815')));--
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='18:00:00' and hora_salida='02:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '25755819')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='19:00:00' and hora_salida='03:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '15040464')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='20:00:00' and hora_salida='04:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '14021832')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='21:00:00' and hora_salida='05:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '24210484')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='22:00:00' and hora_salida='06:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '21262403')));--
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='23:00:00' and hora_salida='07:00:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '28180142')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='08:30:00' and hora_salida='16:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '18364270')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='09:30:00' and hora_salida='17:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '17148667')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='10:30:00' and hora_salida='18:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '16413537')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='11:30:00' and hora_salida='19:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '16556250')));--
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='12:30:00' and hora_salida='20:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '16382963')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='13:30:00' and hora_salida='21:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '17719600')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='14:30:00' and hora_salida='22:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '16682634')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='15:30:00' and hora_salida='23:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '17641976')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='16:30:00' and hora_salida='00:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '30468132')));--
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='17:30:00' and hora_salida='01:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '15403505')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='18:30:00' and hora_salida='02:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '13636795')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='19:30:00' and hora_salida='03:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '17642304')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='20:30:00' and hora_salida='04:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '15613660')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='21:30:00' and hora_salida='05:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '17116471')));--
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='22:30:00' and hora_salida='06:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '24216176')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='23:30:00' and hora_salida='07:30:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '24577571')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='08:15:00' and hora_salida='16:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '26459925')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='09:15:00' and hora_salida='17:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '25234284')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='10:15:00' and hora_salida='18:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '24812956')));--
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='11:15:00' and hora_salida='19:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '15506254')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='12:15:00' and hora_salida='20:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '15337842')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='13:15:00' and hora_salida='21:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '19022950')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='14:15:00' and hora_salida='22:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '24723408')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='15:15:00' and hora_salida='23:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '30115310')));--
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='16:15:00' and hora_salida='00:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '16411632')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='17:15:00' and hora_salida='01:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '17977425')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='18:15:00' and hora_salida='02:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '13748084')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='19:15:00' and hora_salida='03:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '20793899')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='20:15:00' and hora_salida='04:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '15574606')));--
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='21:15:00' and hora_salida='05:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '24210444')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='22:15:00' and hora_salida='06:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '29861711')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='23:15:00' and hora_salida='07:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '29861430')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='22:15:00' and hora_salida='06:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '27741713')));
INSERT INTO C_H(fk_horario,contrato_fk) VALUES((SELECT id_horario FROM HORARIO WHERE hora_entrada='23:15:00' and hora_salida='07:15:00'),(SELECT id_contrato FROM CONTRATO_EMPLEADO WHERE fk_emp= (SELECT cedula_emp FROM EMPLEADO WHERE cedula_emp= '28308698')));

INSERT INTO CARGO(nombre_cargo,sueldo_hora) VALUES('Farmacéutico titular',6);
INSERT INTO CARGO(nombre_cargo,sueldo_hora) VALUES('Farmacéutico co-titular',5.5);
INSERT INTO CARGO(nombre_cargo,sueldo_hora) VALUES('Farmacéutico regente',4.5);
INSERT INTO CARGO(nombre_cargo,sueldo_hora) VALUES('Farmacéutico sustituto',3.5);
INSERT INTO CARGO(nombre_cargo,sueldo_hora) VALUES('Farmacéutico adjunto',3);
INSERT INTO CARGO(nombre_cargo,sueldo_hora) VALUES('Auxiliar mayor diplomado',2.75);
INSERT INTO CARGO(nombre_cargo,sueldo_hora) VALUES('Auxiliar diplomado',2.5);
INSERT INTO CARGO(nombre_cargo,sueldo_hora) VALUES('Técnico en farmacia',2.25);
INSERT INTO CARGO(nombre_cargo,sueldo_hora) VALUES('Personal auxiliar',2.15);

INSERT INTO CLIENTE (cedula_cli, nombre_cli, apellido_cli, genero, fk_lugar) VALUES
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'John', 'Smith', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Jane', 'Doe', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Michael', 'García', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Isabella', 'López', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'William', 'Martínez', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Sophia', 'Sánchez', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Alexander', 'Pérez', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Olivia', 'González', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Ethan', 'Rodríguez', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Emma', 'Hernández', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Daniel', 'Brown', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Ava', 'Wilson', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Matthew', 'Miller', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Mia', 'Moore', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'James', 'Gutiérrez', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Amelia', 'Díaz', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Benjamin', 'Ruiz', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Emily', 'Ortiz', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'William', 'Soto', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Evelyn', 'Nuñez', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Liam', 'González', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Sofía', 'Jiménez', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Lucas', 'Torres', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Avery', 'Reyes', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Ella', 'Cruz', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Alexander', 'Flores', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Victoria', 'Álvarez', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Daniel', 'Romero', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Madison', 'Gómez', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Michael', 'Morales', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Abigail', 'Pérez', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'William', 'Díaz', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Sophia', 'Santos', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Daniel', 'Rivera', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Olivia', 'Herrera', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Matthew', 'Suárez', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Emily', 'López', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Jackson', 'Martínez', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Ava', 'García', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Liam', 'Rodríguez', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Charlotte', 'Fernández', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Noah', 'Sánchez', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Amelia', 'González', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Lucas', 'Gutiérrez', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Isabella', 'Hernández', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Mason', 'Díaz', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Evelyn', 'Pérez', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Ethan', 'Ortega', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'Harper', 'Martínez', 'F', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1)),
(FLOOR(11000000 + RAND() * (27000000 - 11000000)), 'James', 'Reyes', 'M', (SELECT id FROM LUGAR WHERE tipo='parroquia' ORDER BY RAND() LIMIT 1));

INSERT INTO C_C (fecha_inicio, fecha_fin, sueldo, fk_cargo, cont_fk) VALUES
('2023-01-01', '2023-12-31', 5000, 1, 1),
('2023-02-01', '2023-12-31', 6000, 2, 2),
('2023-03-01', '2023-12-31', 5500, 3, 3),
('2023-04-01', '2023-12-31', 7000, 4, 4),
('2023-05-01', '2023-12-31', 6500, 5, 5),
('2023-06-01', '2023-12-31', 7500, 6, 6),
('2023-07-01', '2023-12-31', 7000, 7, 7),
('2023-08-01', '2023-12-31', 8000, 8, 8),
('2023-09-01', '2023-12-31', 7500, 9, 9),
('2023-10-01', '2023-12-31', 5000, 1, 10),
('2023-11-01', '2023-12-31', 6000, 2, 11),
('2023-12-01', '2023-12-31', 5500, 3, 12),
('2024-01-01', '2024-12-31', 7000, 4, 13),
('2024-02-01', '2024-12-31', 6500, 5, 14),
('2024-03-01', '2024-12-31', 7500, 6, 15),
('2024-04-01', '2024-12-31', 7000, 7, 16),
('2024-05-01', '2024-12-31', 8000, 8, 17),
('2024-06-01', '2024-12-31', 7500, 9, 18),
('2024-07-01', '2024-12-31', 5000, 1, 19),
('2024-08-01', '2024-12-31', 6000, 2, 20),
('2024-09-01', '2024-12-31', 5500, 3, 21),
('2024-10-01', '2024-12-31', 7000, 4, 22),
('2024-11-01', '2024-12-31', 6500, 5, 23),
('2024-12-01', '2024-12-31', 7500, 6, 24),
('2022-01-01', '2022-12-31', 7000, 7, 25),
('2022-02-01', '2022-12-31', 8000, 8, 26),
('2022-03-01', '2022-12-31', 7500, 9, 27),
('2022-04-01', '2022-12-31', 5000, 1, 28),
('2022-05-01', '2022-12-31', 6000, 2, 29),
('2022-06-01', '2022-12-31', 5500, 3, 30),
('2022-07-01', '2022-12-31', 7000, 4, 31),
('2022-08-01', '2022-12-31', 6500, 5, 32),
('2022-09-01', '2022-12-31', 7500, 6, 33),
('2022-10-01', '2022-12-31', 7000, 7, 34),
('2022-11-01', '2022-12-31', 8000, 8, 35),
('2022-12-01', '2022-12-31', 7500, 9, 36),
('2023-01-01', '2023-12-31', 5000, 1, 37),
('2023-02-01', '2023-12-31', 6000, 2, 38),
('2023-03-01', '2023-12-31', 5500, 3, 39),
('2023-04-01', '2023-12-31', 7000, 4, 40),
('2023-05-01', '2023-12-31', 6500, 5, 41),
('2023-06-01', '2023-12-31', 7500, 6, 42),
('2023-07-01', '2023-12-31', 7000, 7, 43),
('2023-08-01', '2023-12-31', 8000, 8, 44),
('2023-09-01', '2023-12-31', 7500, 9, 45),
('2023-10-01', '2023-12-31', 5000, 1, 46),
('2023-11-01', '2023-12-31', 6000, 2, 47),
('2023-12-01', '2023-12-31', 5500, 3, 48),
('2022-01-01', '2022-12-31', 7000, 4, 49),
('2022-02-01', '2022-12-31', 6500, 5, 50);

INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(300,1);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(310,2);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(200,3);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(207,4);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(150,5);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(100,6);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(80,7);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(110,8);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(205,9);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(104,10);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(50,11);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(34,12);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(20,13);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(32,14);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(29,15);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(44,16);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(16,17);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(25,18);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(20,19);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(35,20);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(48,21);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(41,22);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(39,23);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(28,24);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(30,25);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(15,26);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(22,27);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(16,28);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(59,29);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(51,30);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(38,31);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(44,32);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(42,33);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(50,34);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(31,35);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(49,36);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(55,37);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(56,38);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(61,39);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(47,40);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(40,41);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(38,42);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(35,43);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(25,44);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(30,45);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(18,46);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(60,47);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(55,48);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(51,49);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(49,50);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(59,51);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(33,52);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(24,53);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(22,54);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(65,55);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(59,56);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(44,57);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(64,58);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(35,59);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(56,60);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(68,61);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(70,62);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(66,63);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(54,64);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(51,65);
INSERT INTO INVENTARIO(cantidad_disp,producto_fk) VALUES(60,66);

INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-01-01',5.12,9950001,13636795);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-10-14',3.86,9987456,13748084);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-12-10',6.98,10234567,14021832);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-02-09',3.76,10234576,15040464);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-21',2.51,11000011,15200135);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-06-17',13.5,11000022,15337842);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-07-24',2.90,11123456,15403505);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-05-25',1.59,11345422,15506254);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-01-08',2.62,11614418,15574606);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-01-11',3.60,12045678,16382963);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-06-29',4.60,12045689,16411632);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-05-18',4.52,12054756,16413537);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-03-15',11.26,12308554,15613660);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-09-01',9.58,12430454,16556250);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-11-20',5.94,12717345,17116471);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-07-19',3.28,12845689,16682634);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-02-06',2.12,13098765,17148667);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-04-10',11.15,13098776,17116471);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-08-14',1.36,13208665,17641976);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-04-22',8.16,13598776,17719600);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-04-02',5.49,13655448,17642304);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-07-03',6.48,14012345,17977425);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-12-15',6.55,14012356,18485412);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-11-24',45.43,14122888,18364270);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-01-31',0.33,14712356,19022950);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-06-12',0.52,14783565,19335806);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-11-11',0.44,15098765,20793899);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-02-13',0.70,15477443,21131494);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-03-28',8.87,15498765,19606815);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-01-07',1.39,15547986,21262403);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-09-23',1.41,15661510,24210484);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-08-02',3.80,16019296,24210444);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-04-19',0.40,16078901,24216176);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-08-10',2.72,16078912,24577571);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-06-20',2.43,16234576,24723408);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-03-30',4.15,16336685,24812956);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-01',5.91,16578912,25234284);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-10-21',7.05,16602898,25755819);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-11-19',12.44,16887503,27472755);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-09-15',7.55,17045678,26459925);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-03-11',7.30,17045689,26647943);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-03-24',1.73,17345689,27965641);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-05-12',13.87,17559952,28180142);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-03-22',6.85,17747963,28308698);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-04',1.75,18012345,27741713);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-07-23',2.07,18012356,29861711);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-08-17',1.77,18039766,29987210);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-05-29',12.57,18268829,30468132);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-10',6.48,18812356,30115310);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-04-08',3.61,19078654,30720094);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-03-11',17.05,19078665,26647943);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-03-24',5.28,19467056,27965641);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-05-12',5.03,19756181,28180142);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-03-22',19.31,19811166,28308698);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-04',6.61,19898647,27741713);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-07-23',8.35,19978665,29861711);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-08-17',2.05,20014567,29987210);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-05-29',2.84,20014576,30468132);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-10',3.74,20035886,30115310);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-04-08',6.98,20199358,30720094);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-09-23',3.18,21034567,24210484);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-08-02',6.22,21034576,24210444);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-04-19',5.36,21134576,24216176);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-08-10',4.56,21213344,24577571);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-06-20',10.50,21429485,24723408);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-03-30',2.72,21464913,24812956);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-01',3.31,21811424,25234284);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-10-21',2.30,22012356,25755819);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-11-19',6.6,22438566,27472755);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-09-15',7.67,22568992,26459925);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-03-30',2.62,22712356,24812956);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-01',0.44,22743594,25234284);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-10-21',2.85,23169584,25755819);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-11-19',1.39,23523278,27472755);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-09-15',10.50,23600805,26459925);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-07-23',0.44,23645689,29861711);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-08-17',2.26,23998704,29987210);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-05-29',0.40,24041353,30468132);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-10',6.55,24112356,30115310);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-04-08',4.60,24249675,30720094);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-08-17',45.43,24669548,29987210);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-05-29',3.85,24914817,30468132);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-10',13.10,24940795,30115310);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-04-08',5.12,25000134,30720094);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-03-30',11.15,25014576,24812956);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-01',12.44,25067890,25234284);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-10-21',3.28,25067891,25755819);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-11-19',2.51,25070134,27472755);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-01',2.78,25212454,25234284);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-10-21',1.92,25603881,25755819);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-11-19',6.55,26002353,27472755);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2022-08-17',3.28,26018341,29987210);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-05-29',1.73,26034567,30468132);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-10',2.78,26034576,30115310);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-05-29',15.75,26405290,30468132);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-10',3.80,26563720,30115310);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-01',0.44,26581858,25234284);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2023-10-21',6.98,26674883,25755819);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-01',3.86,27012345,25234284);
INSERT INTO FACTURA(fecha_emision,total,cliente_fk,fk_empleado) VALUES('2024-02-01',2.05,27012356,25234284);

INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,10,2.20,1,2);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,15,3.69,1,1);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,3.86,2,3);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,6.98,3,5);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,3.76,4,4);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.51,5,6);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,6.76,6,7);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,1.45,7,8);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,1.59,8,9);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,1.31,9,10);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,1.80,10,11);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,2.30,11,12);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.26,12,13);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.64,13,14);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.64,13,14);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,3.35,13,15);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,5.27,13,16);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.99,14,17);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,10,7.32,14,18);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,5.94,15,19);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,1.64,16,20);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,30,1.64,17,21);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,11.15,18,22);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,1.36,19,23);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,8.16,20,24);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,5.49,21,25);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,6.48,22,26);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,6.55,23,27);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,45.43,24,28);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(3,0,0.11,25,29);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(4,0,0.13,26,30);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,0.44,27,31);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,0.70,28,33);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,8.87,29,32);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,1.39,30,34);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,1.41,31,35);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,1.90,32,36);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(4,0,0.10,33,37);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,1.36,34,38);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.43,35,39);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,4.15,36,40);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,5.91,37,41);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,7.05,38,42);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,6.22,39,43);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,7.55,40,44);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,3.65,41,45);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,1.73,42,46);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,3.01,43,47);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,7.85,43,48);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.85,44,49);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.08,44,50);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,1.92,44,51);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,1.75,45,52);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,15,2.44,46,53);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,1.77,47,54);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,12.57,48,55);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,20,4.05,49,56);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,3.61,50,57);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,5.25,51,58);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,6.55,51,59);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,5.28,52,60);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,5.03,53,62);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,19.31,54,63);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,6.61,55,64);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,8.35,56,61);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.05,57,65);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.84,58,66);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,15,2.20,59,2);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,6.98,60,5);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(3,30,1.51,61,21);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,6.22,62,43);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,1.36,63,38);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.08,63,50);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,1.92,63,51);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,2.26,64,13);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,5.25,65,58);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,1.36,66,23);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,10,3.69,67,1);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.30,68,12);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,10,7.32,69,18);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,15,2.20,70,2);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,30,1.51,70,21);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,0.70,70,33);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.99,70,17);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,1.31,71,10);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,0.44,72,31);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.85,73,49);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,1.39,74,34);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,5.25,75,58);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,0.44,76,31);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.26,77,13);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(4,0,0.10,78,37);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,6.55,79,59);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,2.30,80,12);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,45.43,81,28);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.08,82,50);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,1.77,82,54);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,6.55,83,59);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,10,2.20,84,2);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,15,3.69,84,1);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,11.15,85,22);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,6.22,86,43);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,1.64,87,20);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.51,88,6);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,1.39,89,34);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,1.92,90,51);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,6.55,91,27);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,1.64,92,20);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,1.73,93,46);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,1.39,94,34);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(3,0,5.25,95,58);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(2,0,1.90,96,36);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,0.44,97,31);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,6.98,98,5);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,3.86,99,3);
INSERT INTO DETALLE_FACTURA(cantidad_prod,descuento,precio_unitario,fk_factura,fk_inventario) VALUES(1,0,2.05,100,65);

INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(3.69,'2022-01-01',null,1);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.20,'2022-01-01',null,2);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(3.86,'2022-01-01',null,3);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(3.76,'2022-01-01',null,4);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(6.98,'2022-01-01',null,5);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.51,'2022-01-01',null,6);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(6.76,'2022-01-01',null,7);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.45,'2022-01-01',null,8);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.59,'2022-01-01',null,9);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.31,'2022-01-01',null,10);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.80,'2022-01-01',null,11);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.30,'2022-01-01',null,12);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.26,'2022-01-01',null,13);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.64,'2022-01-01',null,14);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(3.35,'2022-01-01',null,15);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(5.27,'2022-01-01',null,16);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.99,'2022-01-01',null,17);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(7.32,'2022-01-01',null,18);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(5.94,'2022-01-01',null,19);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.64,'2022-01-01',null,20);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.51,'2022-01-01',null,21);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(11.15,'2022-01-01',null,22);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.36,'2022-01-01',null,23);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(8.16,'2022-01-01',null,24);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(5.49,'2022-01-01',null,25);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(6.48,'2022-01-01',null,26);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(6.55,'2022-01-01',null,27);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(45.43,'2022-01-01',null,28);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(0.11,'2022-01-01',null,29);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(0.13,'2022-01-01',null,30);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(0.44,'2022-01-01',null,31);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(8.87,'2022-01-01',null,32);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(0.70,'2022-01-01',null,33);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.39,'2022-01-01',null,34);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.41,'2022-01-01',null,35);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.90,'2022-01-01',null,36);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(0.10,'2022-01-01',null,37);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.36,'2022-01-01',null,38);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.43,'2022-01-01',null,39);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(4.15,'2022-01-01',null,40);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(5.91,'2022-01-01',null,41);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(7.05,'2022-01-01',null,42);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(6.22,'2022-01-01',null,43);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(7.55,'2022-01-01',null,44);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(3.65,'2022-01-01',null,45);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.73,'2022-01-01',null,46);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(3.01,'2022-01-01',null,47);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(7.85,'2022-01-01',null,48);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.85,'2022-01-01',null,49);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.08,'2022-01-01',null,50);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.92,'2022-01-01',null,51);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.75,'2022-01-01',null,52);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.44,'2022-01-01',null,53);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.77,'2022-01-01',null,54);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.57,'2022-01-01',null,55);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(4.05,'2022-01-01',null,56);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(3.61,'2022-01-01',null,57);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(5.25,'2022-01-01',null,58);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(6.55,'2022-01-01',null,59);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(5.28,'2022-01-01',null,60);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(8.35,'2022-01-01',null,61);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(5.03,'2022-01-01',null,62);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(19.31,'2022-01-01',null,63);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(6.61,'2022-01-01',null,64);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.05,'2022-01-01',null,65);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.84,'2022-01-01',null,66);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(3.15,'2021-01-01','2021-12-31',1);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.99,'2021-01-01','2021-12-31',2);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(3.50,'2021-01-01','2021-12-31',3);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(3.14,'2021-01-01','2021-12-31',4);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(6.40,'2021-01-01','2021-12-31',5);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.04,'2021-01-01','2021-12-31',6);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(6.28,'2021-01-01','2021-12-31',7);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.11,'2021-01-01','2021-12-31',8);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.26,'2021-01-01','2021-12-31',9);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(0.99,'2021-01-01','2021-12-31',10);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.18,'2021-01-01','2021-12-31',11);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.00,'2021-01-01','2021-12-31',12);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.89,'2021-01-01','2021-12-31',13);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.00,'2021-01-01','2021-12-31',14);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(3.04,'2021-01-01','2021-12-31',15);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(5.00,'2021-01-01','2021-12-31',16);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.45,'2021-01-01','2021-12-31',17);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(7.08,'2021-01-01','2021-12-31',18);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(5.66,'2021-01-01','2021-12-31',19);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.31,'2021-01-01','2021-12-31',20);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.21,'2021-01-01','2021-12-31',21);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(11.07,'2021-01-01','2021-12-31',22);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.12,'2021-01-01','2021-12-31',23);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(7.98,'2021-01-01','2021-12-31',24);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(5.09,'2021-01-01','2021-12-31',25);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(6.20,'2021-01-01','2021-12-31',26);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(6.19,'2021-01-01','2021-12-31',27);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(45.23,'2021-01-01','2021-12-31',28);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(0.09,'2021-01-01','2021-12-31',29);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(0.10,'2021-01-01','2021-12-31',30);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(0.39,'2021-01-01','2021-12-31',31);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(8.56,'2021-01-01','2021-12-31',32);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(0.60,'2021-01-01','2021-12-31',33);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.17,'2021-01-01','2021-12-31',34);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.32,'2021-01-01','2021-12-31',35);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.85,'2021-01-01','2021-12-31',36);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(0.09,'2021-01-01','2021-12-31',37);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.14,'2021-01-01','2021-12-31',38);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.13,'2021-01-01','2021-12-31',39);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(3.99,'2021-01-01','2021-12-31',40);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(5.54,'2021-01-01','2021-12-31',41);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(6.99,'2021-01-01','2021-12-31',42);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(6.12,'2021-01-01','2021-12-31',43);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(7.46,'2021-01-01','2021-12-31',44);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(3.24,'2021-01-01','2021-12-31',45);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.00,'2021-01-01','2021-12-31',46);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.59,'2021-01-01','2021-12-31',47);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(7.77,'2021-01-01','2021-12-31',48);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.80,'2021-01-01','2021-12-31',49);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.88,'2021-01-01','2021-12-31',50);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.54,'2021-01-01','2021-12-31',51);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.00,'2021-01-01','2021-12-31',52);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.15,'2021-01-01','2021-12-31',53);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.05,'2021-01-01','2021-12-31',54);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(1.23,'2021-01-01','2021-12-31',55);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(4.0,'2021-01-01','2021-12-31',56);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(3.66,'2021-01-01','2021-12-31',57);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(5.00,'2021-01-01','2021-12-31',58);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(6.25,'2021-01-01','2021-12-31',59);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(4.88,'2021-01-01','2021-12-31',60);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(7.45,'2021-01-01','2021-12-31',61);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(4.94,'2021-01-01','2021-12-31',62);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(18.30,'2021-01-01','2021-12-31',63);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(5.61,'2021-01-01','2021-12-31',64);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.00,'2021-01-01','2021-12-31',65);
INSERT INTO HIST_PRECIO_VENTA(valor_pv,fecha_inicio_pv,fecha_fin_pv,fk_inv) VALUES(2.75,'2021-01-01','2021-12-31',66);
