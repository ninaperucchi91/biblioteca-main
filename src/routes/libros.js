const express = require("express");
const router = express.Router();

//LISTADO
router.get("/", async (req, res) => {
  req.getConnection(async (err, conn) => {
    if (err) res.json(err);
    conn.query(
      `
      select   idLibro, nombre, stock, ISBN, editorial.NombreEditorial, autor.NombreAutor, categoria.categorianombre from libros
        inner join categoria on libros.Categoria_idCategoria = categoria.idCategoria
        inner join autor on libros.Autor_idAutor = autor.idAutor
        inner join editorial on libros.idEditorial = editorial.idEditorial
        inner join isbn on libros.ISBN_idISBN= isbn.idISBN;
        SELECT * from autor; 
      SELECT * from editorial; 
      SELECT * from categoria; 
      SELECT * from isbn;`,

      function (err, results) {
        if (err) throw err;
        console.log(results[0])
        res.render("libros", {
          data: results[0],
          autores: results[1],
          editoriales: results[2],
          categorias: results[3],
          isbn: results[4],
        });
      }
    );
  });
});

// ADD ACTION
router.post("/add", (req, res) => {
  const data = req.body;
  console.log("asd", data);
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query("INSERT INTO libros set ?", [data], (err, row) => {
      if (err) res.json(err);
      console.log(row);
      res.redirect("/libros");
    });
  });
});

// DELETE ACTION
router.get("/delete/:id", (req, res) => {
  const { id } = req.params;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query(

      "DELETE FROM libros WHERE idLibro = ?",
      [id],
      (err, row) => {
        if (err) res.json(err);
        console.log(row);
        res.redirect("/libros");
      }
    );
  });
});

// EDIT
router.get("/edit/:id", (req, res) => {
  const { id } = req.params;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query(
      `
      select * from libros where idLibro= ?;
        SELECT * from autor; 
      SELECT * from editorial; 
      SELECT * from categoria; 
      SELECT * from isbn;`,
[id],
     function  (err, results) {
        if (err) res.json(err);
        console.log(results);
        res.render("libros_edit", { 
          data: results[0][0],
          autores: results[1],
          editoriales: results[2],
          categorias: results[3],
          isbn: results[4],
         });
      }
    );
  });
});

// EDIT ACTION
router.post("/edit/:id", (req, res) => {
  const { id } = req.params;
  const data = req.body;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query(
      "update libros SET ? WHERE idLibro= ?",
      [data, id],
      (err, row) => {
        if (err) res.json(err);
        console.log(row);
        res.redirect("/libros");
      }
    );
  });
});

module.exports = router;
