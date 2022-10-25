const mysql = require('mysql');

const mysqlConnection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'tienda_virtual',
  multipleStatements: true
});

// const mysqlConnection = mysql.createConnection({
//   host: 'i1rf7b.stackhero-network.com',
//   user: 'root',
//   password: 'IFhkS7pD1QOvZ7fRZXuHDw5mPyDf0PB0',
//   database: 'tienda_virtual',
//   multipleStatements: true
// });

mysqlConnection.connect(function (err) {
  if (err) {
    console.error(err);
    return;
  } else {
    console.log('base de datos connected');
  }
});

module.exports = mysqlConnection;
