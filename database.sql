CREATE DATABASE GaseosasValle;
USE GaseosasValle;

-- 1. Tabla de Sedes
CREATE TABLE sedes (
    id_sede INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sede VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(150),
    capacidad_almacenamiento INT,
    encargado VARCHAR(100)
);
-- 2. Tabla de Productos
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    precio DECIMAL(10,2) NOT NULL,
    volumen_ml INT,
    stock_actual INT NOT NULL,
    stock_minimo INT NOT NULL
);

-- 3. Tabla de Clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    identificacion VARCHAR(20) UNIQUE NOT NULL,
    direccion VARCHAR(200),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100)
);

-- 4. Tabla de Pedidos (Cabecera)
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT,
    id_sede INT,
    total_sin_iva DECIMAL(12,2) DEFAULT 0,
    total_con_iva DECIMAL(12,2) DEFAULT 0,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_sede) REFERENCES sedes(id_sede)
);

-- 5. Tabla Detalle de Pedido (Relación N a N)
CREATE TABLE detalle_pedido (
    id_detalle int auto_increment primary key,
    id_pedido INT,
    id_producto INT,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
describe detalle_pedido; 
-- 6. Tabla de Auditoría
CREATE TABLE auditoria_precios (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    precio_anterior DECIMAL(10,2),
    precio_nuevo DECIMAL(10,2),
    fecha_cambio DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);


INSERT INTO sedes (nombre_sede, ubicacion, capacidad_almacenamiento, encargado) VALUES
('Sede Principal Girón', 'Calle 12 #25-10, Girón', 5000, 'Carlos Martínez'),
('Bodega Bucaramanga Norte', 'Carrera 15 #2-40, Bucaramanga', 3000, 'Elena Gómez'),
('Distribuidora Piedecuesta', 'Calle 8 #4-12, Piedecuesta', 2500, 'Ricardo Mora'),
('Punto de Venta Cañaveral', 'C.C. Cañaveral, Floridablanca', 1000, 'Sofía Ruiz'),
('Sede Centro BGA', 'Calle 36 #18-20, Bucaramanga', 1500, 'Javier López');

INSERT INTO productos (nombre, categoria, precio, volumen_ml, stock_actual, stock_minimo) VALUES
('Valle Cola 2.5L', 'Cola', 7500.00, 2500, 500, 50),
('Valle Cola 400ml', 'Cola', 2500.00, 400, 1200, 100),
('Valle Limón 1.5L', 'Cítrica', 4500.00, 1500, 300, 40),
('Valle Naranja 1.5L', 'Frutal', 4500.00, 1500, 280, 40),
('Valle Uva 1.5L', 'Frutal', 4500.00, 1500, 150, 40),
('Agua Valle Pura 600ml', 'Agua', 1800.00, 600, 2000, 200),
('Soda Gasificada 300ml', 'Mezclador', 3200.00, 300, 450, 60),
('Valle Piña 2.5L', 'Frutal', 7200.00, 2500, 180, 50),
('Valle Manzana 400ml', 'Frutal', 2500.00, 400, 800, 100),
('Toronja Light 1.5L', 'Light', 5200.00, 1500, 90, 30),
('Valle Energy 250ml', 'Energizante', 4000.00, 250, 600, 100),
('Té Limón Valle 500ml', 'Té', 3500.00, 500, 400, 80),
('Té Durazno Valle 500ml', 'Té', 3500.00, 500, 380, 80),
('Valle Zero 2.5L', 'Light', 7800.00, 2500, 120, 40),
('Soda Limonada 1.5L', 'Cítrica', 4800.00, 1500, 210, 50);

INSERT INTO clientes (nombre_completo, identificacion, direccion, telefono, correo_electronico) VALUES
('Tienda La Esquina', '900.123.456-1', 'Calle 10 #5-20, Girón', '6461234', 'esquina@mail.com'),
('Supermercado El Vecino', '800.555.222-2', 'Cra 27 #36-10, BGA', '6305555', 'vecino@mail.com'),
('Minimarket Piedecuesta', '700.888.999-3', 'Calle 5 #8-15, Piedecuesta', '6559999', 'mini_piede@mail.com'),
('Restaurante El Sabor', '1098765432', 'Calle 12 #10-05, Girón', '3157778899', 'sabor@mail.com'),
('Distribuidora Norte', '900.777.111-0', 'Calle 1 #15-30, BGA', '6401111', 'norte@mail.com'),
('Tienda Doña Rosa', '37888999', 'Transversal 2 #40-10, Girón', '3102223344', 'rosa@mail.com'),
('GastroBar Cañaveral', '901.222.333-5', 'CC La Florida', '6334455', 'bar@mail.com'),
('AutoServicio Express', '800.111.000-4', 'Cra 15 #45-12, BGA', '6700011', 'express@mail.com'),
('Cafetería Central', '63444555', 'Calle 35 #19-01, BGA', '3004445566', 'central@mail.com'),
('Colegio San Juan (Cafetería)', '890.333.222-1', 'Vereda Chocoita, Girón', '6460000', 'sanjuan@mail.com'),
('Hotel Bucarica', '800.000.111-9', 'Calle 35 #12-20, BGA', '6301010', 'hotel@mail.com'),
('Licores El Paisa', '13444555', 'Calle 7 #9-30, Piedecuesta', '3124445555', 'paisa@mail.com'),
('Salsamentaria Real', '900.444.555-8', 'Cra 25 #10-10, Girón', '6464455', 'real@mail.com'),
('Club Campestre', '800.222.111-3', 'Km 5 Vía Piedecuesta', '6771122', 'club@mail.com'),
('Tienda El Triunfo', '1095222333', 'Barrio Mutis, BGA', '3189990011', 'triunfo@mail.com');

INSERT INTO pedidos (id_cliente, id_sede, total_sin_iva, total_con_iva) VALUES
(1, 1, 0, 0), (2, 2, 0, 0), (3, 3, 0, 0), (4, 1, 0, 0), (5, 2, 0, 0),
(6, 1, 0, 0), (7, 4, 0, 0), (8, 2, 0, 0), (9, 5, 0, 0), (10, 1, 0, 0),
(11, 5, 0, 0), (12, 3, 0, 0), (13, 1, 0, 0), (14, 3, 0, 0), (15, 2, 0, 0);

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal) VALUES
(1, 1, 10, 75000.00),   
(1, 2, 5, 12500.00),    
(2, 3, 20, 90000.00),   
(3, 8, 15, 108000.00), 
(4, 1, 2, 15000.00),   
(5, 6, 50, 90000.00),   
(6, 10, 5, 26000.00),   
(7, 11, 12, 48000.00),
(8, 4, 10, 45000.00),   
(9, 15, 8, 38400.00),   
(10, 2, 100, 250000.00),
(11, 12, 6, 21000.00),
(12, 5, 4, 18000.00),   
(13, 7, 10, 32000.00),  
(14, 14, 2, 15600.00),  
(15, 9, 20, 50000.00); 

select *  from productos;
