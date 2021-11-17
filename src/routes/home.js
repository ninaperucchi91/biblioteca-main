const express = require("express");
const router = express.Router();

//LISTADO
router.get("/", (req, res) => {
  req.getConnection(async (err, conn) => {
    if (err) res.json(err);
    conn.query(
      ` select idLibro, nombre, numero_inventario, stock, ISBN, editorial.NombreEditorial, autor.NombreAutor, categoria.categorianombre from libros
        inner join categoria on libros.Categoria_idCategoria = categoria.idCategoria
        inner join autor on libros.Autor_idAutor = autor.idAutor
        inner join editorial on libros.idEditorial = editorial.idEditorial
        inner join isbn on libros.ISBN_idISBN= isbn.idISBN;`,

      function (err, results) {
        if (err) throw err;
        console.log(results);
        res.render("home", {
          data: results,
        });
      }
    );
  });
});

module.exports = router;
