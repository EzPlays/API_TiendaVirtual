const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

router.get('/compras', (req, res) => {
  const { id } = req.body;
  mysqlConnection.query('CALL seleCompra(?)', [id], (err, rows, fields) => {
    if (!err) {
      res.json(rows);
    } else {
      console.log(err);
    }
  });
});

router.get('/compras/:id', (req, res) => {
  const { id } = req.params;
  mysqlConnection.query('CALL seleCompra(?)', [id], (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    } else {
      console.log(err);
    }
  });
});

router.delete('/compras/:id', (req, res) => {
  const { id } = req.params;
  mysqlConnection.query('DELETE FROM compras WHERE id = ?', [id], (err, rows, fields) => {
    if (!err) {
      res.json({ status: 'compra eliminada' });
    } else {
      console.log(err);
    }
  });
});

router.post('/compras', (req, res) => {
  const { usuario_id, producto_id, cantidad, total, estado } = req.body;
  const query = "INSERT INTO compras (usuario_id, producto_id, cantidad, total, estado) VALUES (?, ?, ?, ?, ?)";
  mysqlConnection.query(query, [usuario_id, producto_id, cantidad, total, estado], (err, rows, fields) => {
    if (!err) {
      res.json({ status: 'compra guardada' });
    } else {
      res.status(423).json(err);
    }
  });

});

module.exports = router;