const express = require("express");
const router = express.Router();

//LISTADO
router.get("/", (req, res) => {
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query("SELECT * FROM tiposusuario", (err, filas) => {
      if (err) res.json(err);
      res.render("tipousuarios", {
        data: filas,
      });
    });
  });
});

// ADD ACTION
router.post("/add", (req, res) => {
  const data = req.body;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query("INSERT INTO tiposusuario set ?", [data], (err, row) => {
      if (err) res.json(err);
      console.log(row);
      res.redirect("/tipousuarios");
    });
  });
});

// DELETE ACTION
router.get("/delete/:id", (req, res) => {
  const { id } = req.params;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query("DELETE FROM tiposusuario WHERE idTipoUsuario = ?", [id], (err, row) => {
      if (err) res.json(err);
      console.log(row);
      res.redirect("/tipousuarios");
    });
  });
});

// EDIT
router.get("/edit/:id", (req, res) => {
  const { id } = req.params;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query("SELECT * FROM tiposusuario WHERE idTipoUsuario = ?", [id], (err, row) => {
      if (err) res.json(err);
      console.log(row);
      res.render("tipousuarios_edit", { data: row[0] });
    });
  });
});

// EDIT ACTION
router.post("/edit/:id", (req, res) => {
  const { id } = req.params;
  const data = req.body;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query(
      "UPDATE tiposusuario set ? WHERE idTipoUsuario = ?",
      [data, id],
      (err, row) => {
        if (err) res.json(err);
        console.log(row);
        res.redirect("/tipousuarios");
      }
    );
  });
});

module.exports = router;
