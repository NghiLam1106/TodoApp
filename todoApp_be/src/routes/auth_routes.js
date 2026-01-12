const express = require('express');
const router = express.Router();
const authController = require('../controller/auth_controller');

// Route Đăng ký: Kiểm tra input trước khi xử lý
router.post('/register', authController.register);

// Route Đăng nhập
router.post('/login', authController.login);

router.post("/logout", authController.logout);

router.post("/refresh-token", authController.refreshToken);


module.exports = router;
