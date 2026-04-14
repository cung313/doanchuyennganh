require('dotenv').config();
const path = require('path');
const express = require('express');
const morgan = require('morgan');
const helmet = require('helmet');
const compression = require('compression');
const rateLimit = require('express-rate-limit');
const session = require('express-session');
const PgSession = require('connect-pg-simple')(session);

const { pool } = require('./src/db/pool');
const security = require('./src/middlewares/security');
const flash = require('./src/middlewares/flash');
const locals = require('./src/middlewares/locals');

// Routes
const authRoutes = require('./src/routes/auth.routes');
const productRoutes = require('./src/routes/product.routes');
const orderRoutes = require('./src/routes/order.routes');
const inventoryRoutes = require('./src/routes/inventory.routes');

const notFound = require('./src/middlewares/notFound');
const errorHandler = require('./src/middlewares/errorHandler');
const cors = require('cors');

const app = express();

// Middleware
app.use(morgan('dev'));
app.use(helmet());
app.use(compression());
app.use(security);
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.use(cors()); 
// Routes
app.use('/api/auth', authRoutes);
app.use('/api/products', productRoutes);
app.use('/api/orders', orderRoutes);
app.use('/api/inventory', inventoryRoutes);
// Error handling
app.use(notFound);
app.use(errorHandler);

const { Client } = require('pg');
const client = new Client({
  host: process.env.PG_HOST,
  port: process.env.PG_PORT,
  user: process.env.PG_USER,
  password: String(process.env.PG_PASSWORD),
  database: process.env.PG_DATABASE,
});

client.connect()
  .then(() => console.log("Database connected successfully"))
  .catch(err => console.error('Connection error', err.stack));

const port = Number(process.env.PORT || 3000);
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});