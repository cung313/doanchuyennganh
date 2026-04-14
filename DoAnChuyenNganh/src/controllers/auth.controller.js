const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const pool = require('../db/pool');

const login = async (req, res) => {
  const { ten_dang_nhap, mat_khau } = req.body;

  try {
    const result = await pool.query(
      'SELECT * FROM nguoi_dung WHERE ten_dang_nhap = $1',
      [ten_dang_nhap]
    );

    if (result.rows.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'User not found',
      });
    }

    const user = result.rows[0];

    const match = await bcrypt.compare(mat_khau, user.mat_khau_hash);
    if (!match) {
      return res.status(400).json({
        success: false,
        message: 'Invalid credentials',
      });
    }

    const token = jwt.sign(
      { userId: user.ma_nd, role: user.vai_tro },
      process.env.JWT_SECRET,
      { expiresIn: '1h' }
    );

    return res.status(200).json({
      success: true,
      token,
      user: {
        ma_nd: user.ma_nd,
        ho_ten: user.ho_ten,
        ten_dang_nhap: user.ten_dang_nhap,
        vai_tro: user.vai_tro,
      },
    });
  } catch (error) {
    console.error('❌ Error during login:', error);
    return res.status(500).json({
      success: false,
      message: 'Server error',
    });
  }
};

const register = async (req, res) => {
  const { ho_ten, ten_dang_nhap, email, mat_khau } = req.body;

  try {
    if (!ho_ten || !ten_dang_nhap || !email || !mat_khau) {
      return res.status(400).json({
        success: false,
        message: 'Thiếu thông tin bắt buộc',
      });
    }

    const existingUser = await pool.query(
      'SELECT ma_nd FROM nguoi_dung WHERE ten_dang_nhap = $1',
      [ten_dang_nhap]
    );

    if (existingUser.rows.length > 0) {
      return res.status(409).json({
        success: false,
        message: 'Tên đăng nhập đã tồn tại',
      });
    }

    const existingEmail = await pool.query(
      'SELECT ma_nd FROM nguoi_dung WHERE email = $1',
      [email]
    );

    if (existingEmail.rows.length > 0) {
      return res.status(409).json({
        success: false,
        message: 'Email đã tồn tại',
      });
    }

    const passwordHash = await bcrypt.hash(mat_khau, 10);

    const result = await pool.query(
      `
      INSERT INTO nguoi_dung (
        ho_ten,
        ten_dang_nhap,
        email,
        mat_khau_hash,
        vai_tro,
        trang_thai
      )
      VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING ma_nd, ho_ten, ten_dang_nhap, email, vai_tro, trang_thai
      `,
      [
        ho_ten,
        ten_dang_nhap,
        email,
        passwordHash,
        'NV_BAN_HANG',
        true,
      ]
    );

    return res.status(201).json({
      success: true,
      message: 'Đăng ký thành công',
      user: result.rows[0],
    });
  } catch (error) {
    console.error('❌ Error during register:', error);
    return res.status(500).json({
      success: false,
      message: 'Server error',
    });
  }
};

module.exports = {
  login,
  register,
};