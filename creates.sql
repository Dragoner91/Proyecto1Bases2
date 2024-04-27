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

CREATE TABLE FARMACIA(
    id_farmacia INT AUTO_INCREMENT,
    capacidad INT NOT NULL,
    CONSTRAINT farmacia_pk PRIMARY KEY(id_farmacia)
);

CREATE TABLE ENTRADA_SALIDA(
    id_ent_sal INT AUTO_INCREMENT,
    hora_fecha_entrada DATETIME NOT NULL,
    hora_fecha_salida DATETIME,
    fk_contrato INT NOT NULL,
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
    fk_farmacia INT NOT NULL,
    producto_fk INT NOT NULL,
    CONSTRAINT inventario_pk PRIMARY KEY(id_inventario),
    CONSTRAINT far_inv_fk FOREIGN KEY(fk_farmacia) REFERENCES FARMACIA(id_farmacia),
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

CREATE TABLE HIST_PRECIO_COMPRA(
    id_pc INT AUTO_INCREMENT,
    valor_pc DECIMAL NOT NULL,
    fecha_inicio_pc DATE NOT NULL,
    fecha_fin_pc DATE,
    fk_producto INT,
    CONSTRAINT pc_pk PRIMARY KEY(id_pc),
    CONSTRAINT pc_pro_fk FOREIGN KEY(fk_producto) REFERENCES PRODUCTO(id_producto)
);

CREATE TABLE HIST_TASA_DOLAR(
    id_td INT AUTO_INCREMENT,
    valor_td DECIMAL NOT NULL,
    fecha_inicio_td DATE NOT NULL,
    fecha_fin_td DATE,
    fk_hist_pc INT,
    CONSTRAINT td_pk PRIMARY KEY(id_td),
    CONSTRAINT td_pc_fk FOREIGN KEY(fk_hist_pc) REFERENCES HIST_PRECIO_COMPRA(id_pc)
);

CREATE TABLE HIST_PRECIO_VENTA(
    id_pv INT AUTO_INCREMENT,
    valor_pv DECIMAL NOT NULL,
    fecha_inicio_pv DATE NOT NULL,
    fecha_fin_pv DATE,
    fk_inv INT,
    fk_hist_td INT,
    CONSTRAINT pv_pk PRIMARY KEY(id_pv),
    CONSTRAINT pv_inv_fk FOREIGN KEY(fk_inv) REFERENCES INVENTARIO(id_inventario),
    CONSTRAINT td_pv_fk FOREIGN KEY(fk_hist_td) REFERENCES HIST_TASA_DOLAR(id_td)
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
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '20233-31','202312-12',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='30468132';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-5-27','2024-11-30',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='24216176';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-7-15','2024-3-20',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='24577571';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-4-21','2024-4-11',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='26459925';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-11-11','2024-3-1',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='25234284';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-1-30','2024-2-25',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='24812956';
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2022-12-9','2023-2-29',EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='16411632';
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
INSERT INTO CONTRATO_EMPLEADO(fecha_ingreso,fecha_egreso,fk_emp) SELECT '2023-31-10',null,EMPLEADO.cedula_emp from EMPLEADO where EMPLEADO.cedula_emp='18364270';
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

INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('08:00:00', '16:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('09:00:00', '17:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('10:00:00', '18:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('11:00:00', '19:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('12:00:00', '20:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('13:00:00', '21:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('14:00:00', '22:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('15:00:00', '23:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('16:00:00', '00:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('17:00:00', '01:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('18:00:00', '02:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('19:00:00', '03:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('20:00:00', '04:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('21:00:00', '05:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('22:00:00', '06:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('23:00:00', '07:00:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('08:30:00', '16:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('09:30:00', '17:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('10:30:00', '18:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('11:30:00', '19:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('12:30:00', '20:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('13:30:00', '21:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('14:30:00', '22:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('15:30:00', '23:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('16:30:00', '00:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('17:30:00', '01:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('18:30:00', '02:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('19:30:00', '03:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('20:30:00', '04:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('21:30:00', '05:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('22:30:00', '06:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('23:30:00', '07:30:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('08:15:00', '16:15:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('09:15:00', '17:15:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('10:15:00', '18:15:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('11:15:00', '19:15:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('12:15:00', '20:15:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('13:15:00', '21:15:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('14:15:00', '22:15:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('15:15:00', '23:15:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('16:15:00', '00:15:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('17:15:00', '01:15:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('18:15:00', '02:15:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('19:15:00', '03:15:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('20:15:00', '04:15:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('21:15:00', '05:15:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('22:15:00', '06:15:00');
INSERT INTO HORARIO (hora_entrada, hora_salida) VALUES ('23:15:00', '07:15:00');

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
('2023-01-01', '2023-12-31', 50000, 1, 1),
('2023-02-01', '2023-12-31', 60000, 2, 2),
('2023-03-01', '2023-12-31', 55000, 3, 3),
('2023-04-01', '2023-12-31', 70000, 4, 4),
('2023-05-01', '2023-12-31', 65000, 5, 5),
('2023-06-01', '2023-12-31', 75000, 6, 6),
('2023-07-01', '2023-12-31', 70000, 7, 7),
('2023-08-01', '2023-12-31', 80000, 8, 8),
('2023-09-01', '2023-12-31', 75000, 9, 9),
('2023-10-01', '2023-12-31', 50000, 1, 10),
('2023-11-01', '2023-12-31', 60000, 2, 11),
('2023-12-01', '2023-12-31', 55000, 3, 12),
('2024-01-01', '2024-12-31', 70000, 4, 13),
('2024-02-01', '2024-12-31', 65000, 5, 14),
('2024-03-01', '2024-12-31', 75000, 6, 15),
('2024-04-01', '2024-12-31', 70000, 7, 16),
('2024-05-01', '2024-12-31', 80000, 8, 17),
('2024-06-01', '2024-12-31', 75000, 9, 18),
('2024-07-01', '2024-12-31', 50000, 1, 19),
('2024-08-01', '2024-12-31', 60000, 2, 20),
('2024-09-01', '2024-12-31', 55000, 3, 21),
('2024-10-01', '2024-12-31', 70000, 4, 22),
('2024-11-01', '2024-12-31', 65000, 5, 23),
('2024-12-01', '2024-12-31', 75000, 6, 24),
('2025-01-01', '2025-12-31', 70000, 7, 25),
('2025-02-01', '2025-12-31', 80000, 8, 26),
('2025-03-01', '2025-12-31', 75000, 9, 27),
('2025-04-01', '2025-12-31', 50000, 1, 28),
('2025-05-01', '2025-12-31', 60000, 2, 29),
('2025-06-01', '2025-12-31', 55000, 3, 30),
('2025-07-01', '2025-12-31', 70000, 4, 31),
('2025-08-01', '2025-12-31', 65000, 5, 32),
('2025-09-01', '2025-12-31', 75000, 6, 33),
('2025-10-01', '2025-12-31', 70000, 7, 34),
('2025-11-01', '2025-12-31', 80000, 8, 35),
('2025-12-01', '2025-12-31', 75000, 9, 36),
('2026-01-01', '2026-12-31', 50000, 1, 37),
('2026-02-01', '2026-12-31', 60000, 2, 38),
('2026-03-01', '2026-12-31', 55000, 3, 39),
('2026-04-01', '2026-12-31', 70000, 4, 40),
('2026-05-01', '2026-12-31', 65000, 5, 41),
('2026-06-01', '2026-12-31', 75000, 6, 42),
('2026-07-01', '2026-12-31', 70000, 7, 43),
('2026-08-01', '2026-12-31', 80000, 8, 44),
('2026-09-01', '2026-12-31', 75000, 9, 45),
('2026-10-01', '2026-12-31', 50000, 1, 46),
('2026-11-01', '2026-12-31', 60000, 2, 47),
('2026-12-01', '2026-12-31', 55000, 3, 48),
('2027-01-01', '2027-12-31', 70000, 4, 49),
('2027-02-01', '2027-12-31', 65000, 5, 50);

INSERT INTO farmacia(capacidad) VALUES(250000)
