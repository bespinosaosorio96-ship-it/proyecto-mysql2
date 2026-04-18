# proyecto-mysql2

gaseosas del valle s.a. - sistema de gestión de inventario y ventas
este proyecto consiste en el diseño e implementación de una base de datos relacional para la empresa gaseosas del valle s.a., automatizando el control de stock, el cálculo de impuestos y la generación de reportes estratégicos.

🚀 características principales
automatización de inventario: mediante triggers, el stock se actualiza automáticamente al registrar una venta.

auditoría de precios: seguimiento histórico de cambios en los precios de los productos.

cálculos inteligentes: funciones integradas para el cálculo de iva (19%) y validación de disponibilidad.

reportes dinámicos: vistas preconfiguradas para conocer las ventas por sede y alertas de stock bajo.

📂 estructura de archivos
el proyecto está dividido en módulos para facilitar su mantenimiento:

database.sql: creación de la base de datos, tablas (sedes, productos, clientes, pedidos, detalles) e inserción de datos maestros.

function.sql: lógica programada para cálculos de iva y mensajes de validación de stock.

triggers.sql: disparadores para la actualización automática de inventario y registro de auditoría.

views.sql: vistas para reportes rápidos (ventas por sede, stock mínimo y clientes activos).

query.sql: consultas analíticas para toma de decisiones (productos más vendidos, filtros de fechas, etc.).

🛠️ instrucciones de instalación
para desplegar el sistema en dbeaver o cualquier cliente mysql, sigue este orden:

ejecuta el archivo database.sql para crear la estructura y cargar los datos de prueba.

ejecuta function.sql para habilitar las funciones de cálculo.

ejecuta triggers.sql para activar la automatización de procesos.

ejecuta views.sql para generar los reportes predefinidos.

📊 modelo de datos
el sistema utiliza un modelo relacional que conecta clientes, pedidos y sedes, garantizando la integridad referencial y evitando la duplicidad de información.

📝 notas de desarrollo
iva: se aplica un factor de 1.19 (19%) sobre el subtotal de los pedidos.

stock: el sistema impide (lógicamente) ventas si el stock es insuficiente mediante la función de validación.

auditoría: cualquier cambio manual en la tabla productos (precio) queda registrado con fecha y valores anterior/nuevo.
