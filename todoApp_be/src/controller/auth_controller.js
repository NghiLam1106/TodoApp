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

  async login(req, res) {
    try {
      const result = await authService.login(req.body);
      return res.status(200).json({ result });
    } catch (error) {
      return res.status(400).json({ error: error.message });
    }
  }

  async logout(req, res) {
    try {
      await authService.logout(req.body);
      return res.status(201).json({ message: "Đăng xuất thành công" });
    } catch (error) {
      return res.status(400).json({ error: error.message });
    }
  }

  async refreshToken(req, res) {
    try {
      const newAccessToken = await authService.refreshToken(req.body);
      return res.status(201).json({ accessToken: newAccessToken });
    } catch (error) {
      return res.status(400).json({ error: error.message });
    }
  }
}

module.exports = new AuthController();
