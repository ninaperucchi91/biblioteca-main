-- El uso del trigger BEFORE DELETE para controlar relaciones, es innecesario ya que es preferible asignar un RESTRICT y capturar el error
-- De todas formas de ser necesario, el trigger quedaria de la siguiente manera...
-- Primero ejecutar la creacion del trigger antes de hacer un DELETE. 
DELIMITER //

CREATE TRIGGER
  autor_delete BEFORE DELETE ON mydb.autor
FOR EACH ROW
BEGIN

    IF EXISTS (SELECT * FROM mydb.libros L WHERE L.Autor_idAutor = OLD.idAutor) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No puede eliminarse el autor ya que esta asignado a un libro';
    END IF;

END;//

insert into mydb.autor values (100, "Pedro")

DELETE FROM mydb.autor A
WHERE A.idAutor = 100;

DELIMITER ;

-- Trigger para alterar el stock de libros al realizarse un movimiento
-- Primero ejecutar la creacion del trigger antes de hacer un INSERT. 

DELIMITER //

CREATE TRIGGER movimiento_new
AFTER INSERT
ON mydb.movimientos FOR EACH ROW
BEGIN
    IF NEW.esRetiro = 0 THEN
        UPDATE mydb.libros L
		SET L.stock = L.stock - NEW.cantidad
		WHERE L.idLibro = NEW.IdLibro;
	ELSE
        UPDATE mydb.libros L
		SET L.stock = L.stock + NEW.devueltos
		WHERE L.idLibro = NEW.IdLibro;
    END IF;
END;//

DELIMITER ;

insert into mydb.movimientos (idEstudiante, IdLibro, cantidad, TiempoEstadia_idTiempoEstadia) values (1,2,2, 1);
insert into mydb.movimientos (idEstudiante, IdLibro, cantidad, esRetiro, TiempoEstadia_idTiempoEstadia, devueltos) values (1,2,2,1,1,2);
insert into mydb.movimientos (idEstudiante, IdLibro, cantidad, esRetiro, TiempoEstadia_idTiempoEstadia, devueltos) values (1,2,2,3,1,2);