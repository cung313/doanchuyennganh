const pool = require('../db/pool');

// Tạo đơn hàng
const createOrder = async (req, res) => {
  const { ma_kh, products } = req.body;

  try {
    const result = await pool.query(
      'INSERT INTO don_hang (ma_kh, tong_tien) VALUES ($1, $2) RETURNING *',
      [ma_kh, 1000]  // Tổng tiền tạm thời, cần tính sau khi lấy chi tiết sản phẩm
    );
    const order = result.rows[0];

    for (const product of products) {
      await pool.query(
        'INSERT INTO ct_don_hang (ma_dh, ma_sp, so_luong, don_gia) VALUES ($1, $2, $3, $4)',
        [order.ma_dh, product.ma_sp, product.so_luong, product.don_gia]
      );
    }

    res.status(201).json({ success: true, data: order });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

module.exports = { createOrder };