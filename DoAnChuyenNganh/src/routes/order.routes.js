const express = require('express');
const router = express.Router();
const { createOrder } = require('../controllers/order.controller');

// Create new order
router.post('/', createOrder);

module.exports = router;