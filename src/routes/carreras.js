const express = require("express");
const router = express.Router();

//LISTADO
router.get("/", (req, res) => {
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query("SELECT * FROM carrera", (err, filas) => {
      if (err) res.json(err);
      res.render("carreras", {
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
    conn.query("INSERT INTO carrera set ?", [data], (err, row) => {
      if (err) res.json(err);
      console.log(row);
      res.redirect("/carreras");
    });
  });
});

// DELETE ACTION
router.get("/delete/:id", (req, res) => {
  const { id } = req.params;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query("DELETE FROM carrera WHERE idCarrera = ?", [id], (err, row) => {
      if (err) res.json(err);
      console.log(row);
      res.redirect("/carreras");
    });
  });
});

// EDIT
router.get("/edit/:id", (req, res) => {
  const { id } = req.params;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query("SELECT * FROM carrera WHERE idCarrera = ?", [id], (err, row) => {
      if (err) res.json(err);
      console.log(row);
      res.render("carreras_edit", { data: row[0] });
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
      "UPDATE carrera set ? WHERE idCarrera = ?",
      [data, id],
      (err, row) => {
        if (err) res.json(err);
        console.log(row);
        res.redirect("/carreras");
      }
    );
  });
});

module.exports = router;
