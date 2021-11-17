const express = require("express");
const router = express.Router();

const libroQuery = `SELECT idLibro, numero_inventario, stock, nombre, autor.NombreAutor, 
    editorial.NombreEditorial, categoria.categorianombre, isbn.ISBN FROM libros 
    inner join autor on libros.Autor_idAutor = autor.idAutor
    inner join editorial on libros.idEditorial = editorial.idEditorial
    inner join categoria on libros.Categoria_idCategoria = categoria.idCategoria
    inner join isbn on libros.ISBN_idISBN = isbn.idISBN
    where idLibro = ?;`;

const usuariosListQuery = `SELECT usuarios.*, tiposusuario.Descripcion, 
    carrera.NombreCarrera, carrera.AñoCarrera 
    from usuarios
    inner join tiposusuario on usuarios.idTipoUsuario = tiposusuario.idTipoUsuario
    inner join carrera on usuarios.idCarrera = carrera.idCarrera;`;

const usuarioQuery = `SELECT usuarios.*, tiposusuario.Descripcion, 
    carrera.NombreCarrera, carrera.AñoCarrera 
    from usuarios
    inner join tiposusuario on usuarios.idTipoUsuario = tiposusuario.idTipoUsuario
    inner join carrera on usuarios.idCarrera = carrera.idCarrera
    where idUsuario = ?;`;

const tiempoEstadiaQuery = `SELECT * from tiempoestadia;`;

const addMovimientoQuery = `INSERT INTO movimientos set ?;`;

const quitarStockQuery = `UPDATE libros
    SET stock = stock - ?
    WHERE idLibro = ?;`;

//NEW
router.get("/new/:idLibro-:idUsuario", (req, res) => {
  const { idLibro, idUsuario } = req.params;
  console.log(idLibro, idUsuario);
  if (idUsuario == "0") {
    req.getConnection((err, conn) => {
      if (err) res.json(err);
      conn.query(libroQuery + usuariosListQuery, [idLibro], (err, row) => {
        if (err) res.json(err);
        if (row[0].length > 0) {
          res.render("prestamos_new", {
            data: row[0][0],
            usuarios: row[1],
            step: 2,
          });
        } else {
          res.redirect("/");
        }
      });
    });
  } else {
    req.getConnection((err, conn) => {
      if (err) res.json(err);
      conn.query(
        libroQuery + usuarioQuery + tiempoEstadiaQuery,
        [idLibro, idUsuario],
        (err, row) => {
          if (err) res.json(err);
          console.log(row);
          res.render("prestamos_new", {
            data: row[0][0],
            usuario: row[1][0],
            tiempoEstadia: row[2],
            step: 3,
          });
        }
      );
    });
  }
});

//NEW ACTION

router.post("/new/:idLibro-:idUsuario", (req, res) => {
  const { idLibro, idUsuario } = req.params;
  let data = req.body;
  data["idLibro"] = idLibro;
  data["idEstudiante"] = idUsuario;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query(
      addMovimientoQuery + quitarStockQuery,
      [data, data.cantidad, idLibro],
      (err, row) => {
        if (err) res.json(err);
        console.log(row);
        if (row.length > 0) {
          res.redirect("/prestamo");
        }
      }
    );
  });
});

module.exports = router;
