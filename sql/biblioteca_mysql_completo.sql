-- Biblioteca Universitaria. ADVERTENCIA: este script recrea las tablas.
CREATE DATABASE IF NOT EXISTS biblioteca_universitaria CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE biblioteca_universitaria;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS PRESTAMOS;
DROP TABLE IF EXISTS EJEMPLARES;
DROP TABLE IF EXISTS LIBRO_AUTOR;
DROP TABLE IF EXISTS LIBROS;
DROP TABLE IF EXISTS ESTUDIANTES;
DROP TABLE IF EXISTS AUTORES;
DROP TABLE IF EXISTS CATEGORIAS;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE CATEGORIAS(id_categoria INT NOT NULL PRIMARY KEY,nombre VARCHAR(60) NOT NULL UNIQUE,descripcion VARCHAR(160) NOT NULL);
CREATE TABLE AUTORES(id_autor INT NOT NULL PRIMARY KEY,nombre VARCHAR(100) NOT NULL,pais VARCHAR(50) NOT NULL);
CREATE TABLE ESTUDIANTES(id_estudiante INT NOT NULL PRIMARY KEY,nombres VARCHAR(60) NOT NULL,apellidos VARCHAR(60) NOT NULL,correo VARCHAR(120) NOT NULL UNIQUE,ciclo INT NOT NULL CHECK(ciclo BETWEEN 1 AND 10));
CREATE TABLE LIBROS(id_libro INT NOT NULL PRIMARY KEY,titulo VARCHAR(160) NOT NULL,isbn CHAR(13) NOT NULL UNIQUE,anio_publicacion INT NOT NULL CHECK(anio_publicacion BETWEEN 1900 AND 2100),id_categoria INT NOT NULL,FOREIGN KEY(id_categoria) REFERENCES CATEGORIAS(id_categoria));
CREATE TABLE LIBRO_AUTOR(id_libro INT NOT NULL,id_autor INT NOT NULL,PRIMARY KEY(id_libro,id_autor),FOREIGN KEY(id_libro) REFERENCES LIBROS(id_libro),FOREIGN KEY(id_autor) REFERENCES AUTORES(id_autor));
CREATE TABLE EJEMPLARES(id_ejemplar INT NOT NULL PRIMARY KEY,id_libro INT NOT NULL,codigo_inventario VARCHAR(20) NOT NULL UNIQUE,estado VARCHAR(20) NOT NULL DEFAULT 'Disponible',CHECK(estado IN ('Disponible','Mantenimiento','Baja')),FOREIGN KEY(id_libro) REFERENCES LIBROS(id_libro));
CREATE TABLE PRESTAMOS(id_prestamo INT NOT NULL PRIMARY KEY,id_estudiante INT NOT NULL,id_ejemplar INT NOT NULL,fecha_prestamo DATE NOT NULL,fecha_limite DATE NOT NULL,fecha_devolucion DATE NULL,CHECK(fecha_limite>=fecha_prestamo),CHECK(fecha_devolucion IS NULL OR fecha_devolucion>=fecha_prestamo),FOREIGN KEY(id_estudiante) REFERENCES ESTUDIANTES(id_estudiante),FOREIGN KEY(id_ejemplar) REFERENCES EJEMPLARES(id_ejemplar));

-- Inserción de 91 registros ficticios
USE biblioteca_universitaria;

INSERT INTO CATEGORIAS (id_categoria,nombre,descripcion) VALUES
(1, 'Programación', 'Lenguajes y desarrollo de software'),
(2, 'Bases de datos', 'Modelado y consultas de bases de datos'),
(3, 'Matemáticas', 'Matemáticas y razonamiento lógico'),
(4, 'Redes', 'Conectividad y comunicación'),
(5, 'Historia', 'Historia local y nacional'),
(6, 'Literatura', 'Narrativa y análisis literario'),
(7, 'Investigación', 'Metodología y producción académica');

INSERT INTO AUTORES (id_autor,nombre,pais) VALUES
(1, 'Elena Andrade', 'Ecuador'),
(2, 'Marco Cueva', 'Ecuador'),
(3, 'Sofía Jiménez', 'Ecuador'),
(4, 'Diego Ríos', 'Perú'),
(5, 'Valeria Torres', 'Ecuador'),
(6, 'Nicolás Paredes', 'Ecuador'),
(7, 'Andrea Aguirre', 'Colombia'),
(8, 'Javier Salcedo', 'Ecuador'),
(9, 'Camila Espinosa', 'Ecuador');

INSERT INTO ESTUDIANTES (id_estudiante,nombres,apellidos,correo,ciclo) VALUES
(1, 'Ana', 'Paredes', 'ana.paredes@ejemplo.edu.ec', 3),
(2, 'Luis', 'Torres', 'luis.torres@ejemplo.edu.ec', 2),
(3, 'María', 'Loja', 'maria.loja@ejemplo.edu.ec', 3),
(4, 'Carlos', 'Vega', 'carlos.vega@ejemplo.edu.ec', 4),
(5, 'Daniela', 'Ríos', 'daniela.rios@ejemplo.edu.ec', 1),
(6, 'Mateo', 'Ruiz', 'mateo.ruiz@ejemplo.edu.ec', 5),
(7, 'Paula', 'Armijos', 'paula.armijos@ejemplo.edu.ec', 6),
(8, 'José', 'Jaramillo', 'jose.jaramillo@ejemplo.edu.ec', 7),
(9, 'Lucía', 'Maldonado', 'lucia.maldonado@ejemplo.edu.ec', 2);

INSERT INTO LIBROS (id_libro,titulo,isbn,anio_publicacion,id_categoria) VALUES
(1, 'Fundamentos de Python', '9781234567019', 2023, 1),
(2, 'Diseño de Bases de Datos', '9781234567026', 2024, 2),
(3, 'Consultas SQL Paso a Paso', '9781234567033', 2025, 2),
(4, 'Matemática Discreta Aplicada', '9781234567040', 2022, 3),
(5, 'Redes para Principiantes', '9781234567057', 2023, 4),
(6, 'Historia de Loja', '9781234567064', 2021, 5),
(7, 'Literatura Andina Contemporánea', '9781234567071', 2020, 6),
(8, 'Metodología de la Investigación', '9781234567088', 2024, 7),
(9, 'Introducción a Java', '9781234567095', 2023, 1),
(10, 'Álgebra Lineal Esencial', '9781234567101', 2022, 3),
(11, 'Seguridad de Redes', '9781234567118', 2025, 4),
(12, 'Archivos de la Universidad', '9781234567125', 2024, 5);

INSERT INTO LIBRO_AUTOR (id_libro,id_autor) VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 3),
(4, 4),
(5, 2),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(8, 9),
(9, 1),
(10, 4),
(11, 5),
(12, 6),
(12, 9);

INSERT INTO EJEMPLARES (id_ejemplar,id_libro,codigo_inventario,estado) VALUES
(1, 1, 'EJ-001', 'Disponible'),
(2, 1, 'EJ-002', 'Disponible'),
(3, 2, 'EJ-003', 'Disponible'),
(4, 2, 'EJ-004', 'Disponible'),
(5, 3, 'EJ-005', 'Disponible'),
(6, 4, 'EJ-006', 'Disponible'),
(7, 5, 'EJ-007', 'Disponible'),
(8, 5, 'EJ-008', 'Disponible'),
(9, 6, 'EJ-009', 'Disponible'),
(10, 7, 'EJ-010', 'Disponible'),
(11, 8, 'EJ-011', 'Disponible'),
(12, 8, 'EJ-012', 'Disponible'),
(13, 9, 'EJ-013', 'Disponible'),
(14, 10, 'EJ-014', 'Disponible'),
(15, 11, 'EJ-015', 'Mantenimiento'),
(16, 12, 'EJ-016', 'Disponible');

INSERT INTO PRESTAMOS (id_prestamo,id_estudiante,id_ejemplar,fecha_prestamo,fecha_limite,fecha_devolucion) VALUES
(1, 1, 1, '2026-09-01', '2026-09-15', '2026-09-14'),
(2, 2, 3, '2026-09-05', '2026-09-19', '2026-09-18'),
(3, 3, 5, '2026-09-09', '2026-09-23', '2026-09-23'),
(4, 4, 6, '2026-09-12', '2026-09-26', '2026-09-20'),
(5, 5, 7, '2026-09-18', '2026-10-02', '2026-10-01'),
(6, 6, 9, '2026-09-21', '2026-10-05', '2026-10-04'),
(7, 7, 10, '2026-09-24', '2026-10-08', '2026-10-08'),
(8, 8, 11, '2026-10-01', '2026-10-15', '2026-10-15'),
(9, 2, 13, '2026-10-05', '2026-10-19', '2026-10-18'),
(10, 3, 14, '2026-10-10', '2026-10-24', '2026-10-21'),
(11, 4, 1, '2026-10-14', '2026-10-28', NULL),
(12, 5, 3, '2026-10-18', '2026-11-01', NULL),
(13, 6, 7, '2026-10-22', '2026-11-05', NULL),
(14, 7, 8, '2026-10-25', '2026-11-08', NULL),
(15, 8, 5, '2026-10-27', '2026-11-10', NULL),
(16, 1, 11, '2026-10-28', '2026-11-11', NULL),
(17, 2, 2, '2026-11-01', '2026-11-15', NULL),
(18, 3, 4, '2026-11-03', '2026-11-17', NULL),
(19, 4, 6, '2026-11-05', '2026-11-19', NULL),
(20, 5, 12, '2026-11-06', '2026-11-20', NULL),
(21, 6, 9, '2026-11-07', '2026-11-21', NULL);

