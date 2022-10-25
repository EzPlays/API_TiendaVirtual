const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

router.get('/productos', (req, res) => {
  mysqlConnection.query('SELECT id, nombre, descripcion, precio_venta FROM productos', (err, rows, fields) => {
    if (!err) {
      res.json(rows);
    } else {
      console.log(err);
    }
  });
});

router.get('/productos/:id', (req, res) => {
  const { id } = req.params;
  mysqlConnection.query('SELECT * FROM productos WHERE id = ?', [id], (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    } else {
      console.log(err);
    }
  });
});

router.delete('/productos/:id', (req, res) => {
  const { id } = req.params;
  mysqlConnection.query('DELETE FROM productos WHERE id = ?', [id], (err, rows, fields) => {
    if (!err) {
      res.json({ status: 'producto eliminado' });
    } else {
      console.log(err);
    }
  });
});

router.post('/productos', (req, res) => {
  const { nombre, descripcion, costo, precio_venta } = req.body;
  const query = "INSERT INTO productos (nombre, descripcion, costo, precio_venta) VALUES (?, ?, ?, ?)";
  mysqlConnection.query(query, [nombre, descripcion, costo, precio_venta], (err, rows, fields) => {
    if (!err) {
      res.json({ status: 'producto guardado' });
    } else {
      res.status(423).json(err);
    }
  });

});

router.put('/productos/:id', (req, res) => {
  const { nombre, descripcion, costo, precio_venta } = req.body;
  const { id } = req.params;
  const query = "UPDATE productos SET nombre = ?, descripcion = ?, costo = ?, precio_venta = ?  WHERE id = ?";
  mysqlConnection.query(query, [nombre, descripcion, costo, precio_venta, id], (err, rows, fields) => {
    if (!err) {
      res.json({ status: 'producto actualizado' });
    } else {
      console.log(err);
    }
  });
});

module.exports = router;