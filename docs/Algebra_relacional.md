# Consultas del informe: álgebra relacional

Las reuniones ⋈ se realizan según las claves PK/FK del diagrama. Fecha fija: 9 de noviembre de 2026.

1. **Vencidos:** `π_{id_prestamo,nombres,apellidos,titulo,codigo_inventario,fecha_limite}(σ_{fecha_devolucion IS NULL ∧ fecha_limite<'2026-11-09'}(PRESTAMOS ⋈ ESTUDIANTES ⋈ EJEMPLARES ⋈ LIBROS))` — **4 registros**.

2. **Correos:** Sea `R=ESTUDIANTES ⋈ PRESTAMOS ⋈ EJEMPLARES ⋈ LIBROS ⋈ CATEGORIAS`. `π_correo(σ_nombre='Programación'(R)) ∪ π_correo(σ_nombre='Bases de datos'(R))` — **6 correos únicos**.

3. **Nunca prestados:** `π_{id_libro,titulo}(LIBROS ⋈ (π_id_libro(LIBROS) − π_id_libro(EJEMPLARES ⋈ PRESTAMOS)))` — **2 títulos**.

4. **Pendientes:** `π_{id_prestamo,nombres,apellidos,titulo,categoria,codigo_inventario,fecha_limite}(σ_fecha_devolucion IS NULL(PRESTAMOS ⋈ ESTUDIANTES ⋈ EJEMPLARES ⋈ LIBROS ⋈ CATEGORIAS))` — **11 préstamos**.

5. **Agrupación:** `σ_total_prestamos≥2(γ_categoria;COUNT(id_prestamo)→total_prestamos,COUNT_DISTINCT(id_estudiante)→estudiantes_distintos(CATEGORIAS ⋈ LIBROS ⋈ EJEMPLARES ⋈ PRESTAMOS))` — **6 categorías**.

[Consultar las cinco traducciones SQL](../sql/03_consultas.sql).
