# Guía MySQL

**Workbench:** abre tu conexión a MySQL; desde File → Open SQL Script ejecuta `sql/biblioteca_mysql_completo.sql`. **Advertencia:** elimina las siete tablas de la biblioteca y las crea de nuevo. Después ejecuta `sql/03_consultas.sql`.

**CMD de Windows:** en la carpeta `bin` de MySQL Server escribe `mysql.exe -u root -p`; introduce la contraseña, y luego:

```sql
USE biblioteca_universitaria;
SHOW TABLES;
SELECT * FROM ESTUDIANTES;
SELECT * FROM PRESTAMOS;
```

Para verificar los registros ejecuta `sql/04_verificacion.sql`. Es recomendable guardar capturas del resultado de las cinco consultas SQL.
