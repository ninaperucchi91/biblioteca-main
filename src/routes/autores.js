const express = require("express");
const router = express.Router();
const url = require("url");
var Autores = require("../queries/autores");
//LISTADO
router.get("/", (req, res) => {
  const message = ({ titulo, body, type } = req.query);
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query(Autores.getAll, (err, filas) => {
      if (err) res.json(err);
      res.render("autores", {
        data: filas,
        message: message,
      });
    });
  });
});

// ADD ACTION
router.post("/add", (req, res) => {
  const data = req.body;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query(Autores.new, [data], (err, row) => {
      if (err) res.json(err);
      console.log(row);
      res.redirect("/autores");
    });
  });
});

//DELETE ACTION
router.get("/delete/:id", (req, res) => {
  const { id } = req.params;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query(Autores.delete, [id], (err, row) => {
      if (err) {
        if (err.errno == 1451) {
          res.redirect(
            url.format({
              pathname: "/autores",
              query: {
                titulo: "Operacion Invalida",
                body: "No se puede eliminar un autor que ya fue asignado a un libro",
                type: "danger",
              },
            })
          );
        } else {
          console.log(err);
          res.redirect(
            url.format({
              pathname: "/autores",
              query: {
                titulo: "Operacion Invalida",
                body: "Error al eliminar el autor",
                type: "danger",
              },
            })
          );
        }
      } else {
        console.log(row);
        res.redirect("/autores");
      }
    });
  });
});

// EDIT
router.get("/edit/:id", (req, res) => {
  const { id } = req.params;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query(Autores.getById, [id], (err, row) => {
      if (err) res.json(err);
      console.log(row);
      res.render("autores_edit", { data: row[0] });
    });
  });
});

// EDIT ACTION
router.post("/edit/:id", (req, res) => {
  const { id } = req.params;
  const data = req.body;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query(Autores.update, [data, id], (err, row) => {
      if (err) res.json(err);
      console.log(row);
      res.redirect("/autores");
    });
  });
});

module.exports = router;
