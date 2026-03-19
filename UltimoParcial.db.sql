BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Clientes" (
	"id"	INTEGER,
	"nombre"	TEXT NOT NULL,
	"correo"	TEXT NOT NULL UNIQUE,
	"telefono"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Detalles_Pedido" (
	"id"	INTEGER,
	"pedido_id"	INTEGER NOT NULL,
	"producto_id"	INTEGER NOT NULL,
	"cantidad"	INTEGER NOT NULL,
	"precio_unitario"	REAL NOT NULL,
	"subtotal"	REAL NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("pedido_id") REFERENCES "Pedidos"("id") ON DELETE CASCADE,
	FOREIGN KEY("producto_id") REFERENCES "Productos"("id")
);
CREATE TABLE IF NOT EXISTS "Pedidos" (
	"id"	INTEGER,
	"cliente_id"	INTEGER NOT NULL,
	"fecha"	TEXT NOT NULL DEFAULT (datetime('now')),
	"total"	REAL NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("cliente_id") REFERENCES "Clientes"("id") ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS "Productos" (
	"id"	INTEGER,
	"nombre"	TEXT NOT NULL,
	"precio"	REAL NOT NULL,
	"stock"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "Clientes" VALUES (1,'Juan Jose','juan.jimenezm@upb.com','3008509341');
INSERT INTO "Clientes" VALUES (2,'Valentina Ortiz','valenortiz@upb.com','3166429475');
INSERT INTO "Detalles_Pedido" VALUES (1,1,1,1,50.0,50.0);
INSERT INTO "Detalles_Pedido" VALUES (2,1,2,1,60.0,60.0);
INSERT INTO "Pedidos" VALUES (1,1,'2026-03-18',110.0);
INSERT INTO "Productos" VALUES (1,'Camisa',50.0,30);
INSERT INTO "Productos" VALUES (2,'Pantalon',60.0,25);
INSERT INTO "Productos" VALUES (3,'Buso',125.0,15);


SELECT id, nombre, correo, telefono FROM Clientes;


SELECT p.id AS pedido_id,
       p.fecha,
       p.total,
       (SELECT nombre FROM Clientes WHERE id = p.cliente_id) AS cliente
FROM Pedidos p
ORDER BY p.id;


SELECT dp.pedido_id,
       (SELECT nombre FROM Productos WHERE id = dp.producto_id) AS producto,
       dp.cantidad,
       dp.subtotal
FROM Detalles_Pedido dp
ORDER BY dp.pedido_id;

COMMIT;
