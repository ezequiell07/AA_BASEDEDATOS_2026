USE biblioteca_universitaria;

-- CINCO CONSULTAS EXACTAS DEL INFORME U1. Ejecutar una consulta a la vez.
-- Fecha de referencia de la consulta 1: 2026-11-09.

-- CONSULTA 1. Préstamos vencidos sin devolver
SELECT p.id_prestamo, e.nombres, e.apellidos, l.titulo,
       x.codigo_inventario, p.fecha_limite
FROM PRESTAMOS p
JOIN ESTUDIANTES e ON e.id_estudiante = p.id_estudiante
JOIN EJEMPLARES x ON x.id_ejemplar = p.id_ejemplar
JOIN LIBROS l ON l.id_libro = x.id_libro
WHERE p.fecha_devolucion IS NULL
  AND p.fecha_limite < '2026-11-09'
ORDER BY p.fecha_limite;

-- CONSULTA 2. Correos de lectores de Programación o Bases de datos (UNIÓN)
SELECT DISTINCT e.correo
FROM ESTUDIANTES e
JOIN PRESTAMOS p ON p.id_estudiante = e.id_estudiante
JOIN EJEMPLARES x ON x.id_ejemplar = p.id_ejemplar
JOIN LIBROS l ON l.id_libro = x.id_libro
JOIN CATEGORIAS c ON c.id_categoria = l.id_categoria
WHERE c.nombre = 'Programación'
UNION
SELECT DISTINCT e.correo
FROM ESTUDIANTES e
JOIN PRESTAMOS p ON p.id_estudiante = e.id_estudiante
JOIN EJEMPLARES x ON x.id_ejemplar = p.id_ejemplar
JOIN LIBROS l ON l.id_libro = x.id_libro
JOIN CATEGORIAS c ON c.id_categoria = l.id_categoria
WHERE c.nombre = 'Bases de datos'
ORDER BY correo;

-- CONSULTA 3. Libros que nunca fueron prestados (DIFERENCIA)
SELECT l.id_libro, l.titulo
FROM LIBROS l
WHERE NOT EXISTS (
  SELECT 1
  FROM EJEMPLARES x
  JOIN PRESTAMOS p ON p.id_ejemplar = x.id_ejemplar
  WHERE x.id_libro = l.id_libro
)
ORDER BY l.id_libro;

-- CONSULTA 4. Préstamos pendientes con estudiante, libro y categoría (JOIN)
SELECT p.id_prestamo, e.nombres, e.apellidos, l.titulo,
       c.nombre AS categoria, x.codigo_inventario, p.fecha_limite
FROM PRESTAMOS p
JOIN ESTUDIANTES e ON e.id_estudiante = p.id_estudiante
JOIN EJEMPLARES x ON x.id_ejemplar = p.id_ejemplar
JOIN LIBROS l ON l.id_libro = x.id_libro
JOIN CATEGORIAS c ON c.id_categoria = l.id_categoria
WHERE p.fecha_devolucion IS NULL
ORDER BY p.id_prestamo;

-- CONSULTA 5. Categorías con dos o más préstamos (AGRUPACIÓN)
SELECT c.nombre AS categoria,
       COUNT(p.id_prestamo) AS total_prestamos,
       COUNT(DISTINCT p.id_estudiante) AS estudiantes_distintos
FROM CATEGORIAS c
JOIN LIBROS l ON l.id_categoria = c.id_categoria
JOIN EJEMPLARES x ON x.id_libro = l.id_libro
JOIN PRESTAMOS p ON p.id_ejemplar = x.id_ejemplar
GROUP BY c.id_categoria, c.nombre
HAVING COUNT(p.id_prestamo) >= 2
ORDER BY total_prestamos DESC, categoria;
