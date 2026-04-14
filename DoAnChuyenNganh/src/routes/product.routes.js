const express = require('express');
const router = express.Router();
const { getProducts, createProduct } = require('../controllers/product.controller');

// Get all products
router.get('/', getProducts);

// Create new product
router.post('/', createProduct);

module.exports = router;