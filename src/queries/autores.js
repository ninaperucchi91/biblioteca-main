module.exports = {
  getAll: "SELECT * FROM autor",
  new: "INSERT INTO autor set ?",
  delete: "DELETE FROM autor WHERE idAutor = ?",
  getById: "SELECT * FROM autor WHERE idAutor = ?",
  update: "UPDATE autor set ? WHERE idAutor = ?",
};
