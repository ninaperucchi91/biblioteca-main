const express = require("express");
const router = express.Router();

//LISTADO
router.get("/", async (req, res) => {
  req.getConnection(async (err, conn) => {
    if (err) res.json(err);
    conn.query(
      `select idUsuario, nombre_apellido, dni, telefono, CorreoUsuario, UsuariosDireccion, 
      tiposusuario.Descripcion, carrera.NombreCarrera, carrera.AñoCarrera 
      from usuarios 
      inner join tiposusuario on usuarios.idTipoUsuario = tiposusuario.idTipoUsuario
      inner join carrera on usuarios.idCarrera = carrera.idCarrera;
      SELECT * from carrera;
      SELECT * from tiposusuario;`,

      function (err, results) {
        if (err) throw err;
        console.log(results[0]);
        res.render("usuarios", {
          data: results[0],
          carrera: results[1],
          tipos_usuario: results[2],
        });
      }
    );
  });
});

// ADD ACTION
router.post("/add", (req, res) => {
  const data = req.body;
  console.log("req", data);
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query("INSERT INTO usuarios set ?", [data], (err, row) => {
      if (err) res.json(err);
      console.log(row);
      res.redirect("/usuarios");
    });
  });
});

// DELETE ACTION
router.get("/delete/:id", (req, res) => {
  const { id } = req.params;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query("DELETE FROM usuarios WHERE idUsuario = ?", [id], (err, row) => {
      if (err) res.json(err);
      console.log(row);
      res.redirect("/usuarios");
    });
  });
});

// EDIT
router.get("/edit/:id", (req, res) => {
  const { id } = req.params;
  req.getConnection((err, conn) => {
    if (err) res.json(err);
    conn.query(
      `
      SELECT * from usuarios where idUsuario= ?;
      SELECT * from carrera; 
      SELECT * from tiposusuario;`,
      [id],
      function (err, results) {
        if (err) res.json(err);
        console.log(results);
        res.render("usuarios_edit", {
          data: results[0][0],
          carreras: results[1],
          tiposusuario: results[2],
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
      "update usuarios SET ? WHERE idUsuario= ?",
      [data, id],
      (err, row) => {
        if (err) res.json(err);
        console.log(row);
        res.redirect("/usuarios");
      }
    );
  });
});

module.exports = router;
