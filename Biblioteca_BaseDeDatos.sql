BEGIN;


CREATE TABLE IF NOT EXISTS public.autor
(
    nombre VARCHAR(20),
    apellido VARCHAR(80),
    fecha_nacimiento date,
    fecha_muerte date,
    id_autor SERIAL,
    PRIMARY KEY (id_autor)
);

COMMENT ON TABLE public.autor
    IS 'Contien el listado de Autores y sus datos';

COMMENT ON COLUMN public.autor.nombre
    IS 'Nombre del autor';

COMMENT ON COLUMN public.autor.apellido
    IS 'Apellido del Autor';

COMMENT ON COLUMN public.autor.fecha_nacimiento
    IS 'Almacena la fecha de nacimiento';

COMMENT ON COLUMN public.autor.fecha_muerte
    IS 'Almacena la fecha de la muerte';

COMMENT ON COLUMN public.autor.id_autor
    IS 'Clave unica Autor';

CREATE TABLE IF NOT EXISTS public.autores_libro
(
    tipo_autor VARCHAR(20) NOT NULL,
    id_autores SERIAL,
    id_autor smallint,
    id_isbn CHAR(15),
    PRIMARY KEY (id_autores)
);

COMMENT ON COLUMN public.autores_libro.tipo_autor
    IS 'El tipo de autor Principal o Co-Autor';

COMMENT ON COLUMN public.autores_libro.id_autores
    IS 'Clave Primaria de registros tabla AUTORES_LIBRO';

COMMENT ON COLUMN public.autores_libro.id_autor
    IS 'Clave foranea Identificador de Autor';

CREATE TABLE IF NOT EXISTS public.libro
(
    titulo VARCHAR(80) NOT NULL,
    numero_paginas smallint,
    id_isbn CHAR(15),
    PRIMARY KEY (id_isbn)
);

COMMENT ON TABLE public.libro
    IS 'Listado de Libros de la Biblioteca';

COMMENT ON COLUMN public.libro.numero_paginas
    IS 'Campo con el numero de paginas del Libro';

COMMENT ON COLUMN public.libro.id_isbn
    IS 'Clave Unica Identificador de Libro';

CREATE TABLE IF NOT EXISTS public.prestamo
(
    id_prestamo SERIAL,
    id_isbn CHAR(15),
    id_rut CHAR(13),
    fecha_inicio date,
    fecha_fin date,
    fecha_entrega_real date,
    PRIMARY KEY (id_prestamo)
);

COMMENT ON TABLE public.prestamo
    IS 'Tabla con el listado de prestamos';

COMMENT ON COLUMN public.prestamo.id_prestamo
    IS 'Clave primaria de la tabla PRESTAMO';

COMMENT ON COLUMN public.prestamo.id_isbn
    IS 'Clave foranea Identificador de Libro';

COMMENT ON COLUMN public.prestamo.id_rut
    IS 'Clave foranea Identificador del SOCIO que pidio el libro';

COMMENT ON COLUMN public.prestamo.fecha_inicio
    IS 'Almacena la fecha de incio del prestamo';

COMMENT ON COLUMN public.prestamo.fecha_fin
    IS 'Almacena la fecha de entrega del prestamo';

COMMENT ON COLUMN public.prestamo.fecha_entrega_real
    IS 'Almacena la fecha de entrega real del prestamo';

CREATE TABLE IF NOT EXISTS public.socio
(
    id_rut CHAR(13),
    nombre VARCHAR(20),
    apellido VARCHAR(80),
    direccion VARCHAR(120),
    telefono VARCHAR(15),
    PRIMARY KEY (id_rut)
);

COMMENT ON COLUMN public.socio.id_rut
    IS 'Clave primaria de la tabla SOCIO, corresponde al RUT del socio';

COMMENT ON COLUMN public.socio.nombre
    IS 'Nombre del Socio';

COMMENT ON COLUMN public.socio.apellido
    IS 'Al o los dos apellidos del SOCIO';

COMMENT ON COLUMN public.socio.direccion
    IS 'Direccion del SOCIO. Incluye calle, numero, comuna, ciudad';

COMMENT ON COLUMN public.socio.telefono
    IS 'Telefono Fijo o Celular';

ALTER TABLE IF EXISTS public.autores_libro
    ADD FOREIGN KEY (id_autor)
    REFERENCES public.autor (id_autor) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.autores_libro
    ADD FOREIGN KEY (id_isbn)
    REFERENCES public.libro (id_isbn) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.prestamo
    ADD FOREIGN KEY (id_isbn)
    REFERENCES public.libro (id_isbn) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.prestamo
    ADD FOREIGN KEY (id_rut)
    REFERENCES public.socio (id_rut) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;
