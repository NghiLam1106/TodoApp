const authService = require("../service/auth_service");

class AuthController {
  async register(req, res) {
    try {
      await authService.register(req.body);
      return res.status(201).json({ message: "Đăng ký thành công" });
    } catch (error) {
      return res.status(400).json({ error: error.message });
    }
  }
}

module.exports = new AuthController();
