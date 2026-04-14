const pool = require('../db/pool');

// Lấy danh sách sản phẩm
const getProducts = async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM san_pham');
    res.status(200).json({ success: true, data: result.rows });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Thêm sản phẩm
const createProduct = async (req, res) => {
  const { ten_sp, ma_dm, gia_ban, gia_nhap, ton_toi_thieu } = req.body;

  try {
    const result = await pool.query(
      'INSERT INTO san_pham (ten_sp, ma_dm, gia_ban, gia_nhap, ton_toi_thieu) VALUES ($1, $2, $3, $4, $5) RETURNING *',
      [ten_sp, ma_dm, gia_ban, gia_nhap, ton_toi_thieu]
    );
    res.status(201).json({ success: true, data: result.rows[0] });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

module.exports = { getProducts, createProduct };