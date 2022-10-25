const express = require('express');
const morgan = require('morgan');
const cors = require('cors');

// iniciar express
const app = express();

// Settings
app.set('port', process.env.PORT || 5001);

// Middlewares
app.use(express.json());
app.use(express.urlencoded({ extended: true}));
app.use(morgan('dev'));
app.use(cors());

// Routes
app.use(require('./routes/usuarios'));
app.use(require('./routes/productos'));
app.use(require('./routes/carrito'));
app.use(require('./routes/mis_compras'));


app.get('/', (req, res) => {
  res.json('tienda virtual api');
});

app.use((req, res, next) => {
  res.status(404).json({ message: "Not found" });
});

// Starting the server
app.listen(app.get('port'), () => {
  console.log(`Server on port http://localhost:${app.get('port')}`);
});



