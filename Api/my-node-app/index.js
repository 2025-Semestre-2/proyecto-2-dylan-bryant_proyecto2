const express = require('express');
const app = express();
const cors = require('cors'); // << importante
const port = 3000;
app.use(cors());

//Rutas almacenadas en otros archivos
const suppliersRouter = require('./routes/suppliers.js');
const salesRouter = require('./routes/sales.js');
const statsRouter = require('./routes/stats.js');
const customersRouter = require('./routes/customers.js');
const itemsRouter = require('./routes/items.js');

//Direccionar a esas rutas en archivos externos
app.use('/suppliers', suppliersRouter);
app.use('/sales', salesRouter);
app.use('/stats', statsRouter);
app.use('/customers', customersRouter);
app.use('/items', itemsRouter);

app.get('/', (req, res) => {

    res.send('Hello');

});

app.listen(port, '0.0.0.0', () => {

    console.log(`Server running at http://localhost:${port}/`);

});