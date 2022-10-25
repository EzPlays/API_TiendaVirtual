const express = require('express');
const router = express.Router();
const jwt = require("jsonwebtoken");

const mysqlConnection = require('../database.js');

router.get('/usuarios', (req, res) => {
  mysqlConnection.query('SELECT * FROM usuarios', (err, rows, fields) => {
    if (!err) {
      res.json(rows);
    } else {
      console.log(err);
    }
  });
});


router.post('/usuarios/login', (req, res) => {
  const user = { correo, clave } = req.body;
  const query = `SELECT id FROM usuarios WHERE correo = BINARY ? and clave = BINARY ?`
  if (correo && clave) {
    mysqlConnection.query(query, [correo, clave], (err, rows, fields) => {
      if (!err) {
        if (rows == 0) {
          res.status(401)
          res.send({ message: 'Invalid email y/o clave' })
        } else {
          // res.send({ message: 'login correct' });
          const token = jwt.sign({ user }, 'my_secret_token')
          // var decoded = jwt.decode(token, 'my_secret_token');
          // console.log(decoded);
          res.json({ rows, token });
        }
      } else {
        res.status(500)
        console.log(err);
      }
    });
  }
});


router.get('/usuarios/:id', (req, res) => {
  const { id } = req.params;
  mysqlConnection.query('SELECT * FROM usuarios WHERE id = ?', [id], (err, rows, fields) => {
    if (!err) {
      res.json(rows[0]);
    } else {
      console.log(err);
    }
  });
});


router.delete('/usuarios/:id', (req, res) => {
  const { id } = req.params;
  mysqlConnection.query('DELETE FROM usuarios WHERE id = ?', [id], (err, rows, fields) => {
    if (!err) {
      res.json({ status: 'usuario eliminado' });
    } else {
      console.log(err);
    }
  });
});


router.post('/usuarios', (req, res) => {
  const { nombre_completo, correo, clave } = req.body;
  const query = "INSERT INTO usuarios (nombre_completo, correo, clave) VALUES (?, ?, ?)";
  mysqlConnection.query(query, [nombre_completo, correo, clave], (err, rows, fields) => {
    if (!err) {
      res.json({ status: 'usuario guardado' });
    } else {
      res.status(423).json(err);
    }
  });

});


router.put('/usuarios/:id', (req, res) => {
  const { nombre_completo, correo, clave } = req.body;
  const { id } = req.params;
  const query = "UPDATE usuarios SET nombre_completo = ?, correo = ?, clave = ?  WHERE id = ?";
  mysqlConnection.query(query, [nombre_completo, correo, clave, id], (err, rows, fields) => {
    if (!err) {
      res.json({ status: 'usuario actualizado' });
    } else {
      console.log(err);
    }
  });
});

module.exports = router;