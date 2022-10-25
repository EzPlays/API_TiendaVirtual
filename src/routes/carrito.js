const express = require('express');
const router = express.Router();

const mysqlConnection = require('../database.js');

router.get('/carrito', (req, res) => {
    const { id } = req.body;
    mysqlConnection.query('CALL seleCarrito(?)', [id], (err, rows, fields) => {
        if (!err) {
            res.json(rows[0]);
        } else {
            console.log(err);
        }
    });
});

router.get('/carrito/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('CALL seleCarrito(?)', [id], (err, rows, fields) => {
        if (!err) {
            res.json(rows[0]);
        } else {
            console.log(err);
        }
    });
});

router.delete('/carrito/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('DELETE FROM carrito WHERE id = ?', [id], (err, rows, fields) => {
        if (!err) {
            res.json({ status: 'producto del carrito eliminado' });
        } else {
            console.log(err);
        }
    });
});

router.post('/carrito', (req, res) => {
    const { usuario_id, producto_id, cantidad } = req.body;
    const query = "INSERT INTO carrito (usuario_id, producto_id, cantidad) VALUES (?, ?, ?)";
    mysqlConnection.query(query, [usuario_id, producto_id, cantidad], (err, rows, fields) => {
        if (!err) {
            res.json({ status: 'producto del carrito guardado' });
        } else {
            res.status(423).json(err);
        }
    });

});

module.exports = router;