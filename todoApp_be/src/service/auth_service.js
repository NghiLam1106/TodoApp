const bcrypt = require("bcrypt");
const authRepository = require("../repository/auth_repository");
const refreshTokens = require("../data/refreshTokens");
const jwt = require("jsonwebtoken");
const { generateAccessToken, generateRefreshToken } = require("../utils/jwt");

class AuthService {
  async register(req) {
    const { username, email, passwordHash } = req;
    const existingUser = await authRepository.findByEmail(email);
    if (existingUser) {
      throw new Error("Email đã được sử dụng");
    }
    const hashedPassword = await bcrypt.hash(passwordHash, 10);
    const newUser = await authRepository.register({
      username,
      email,
      password_hash: hashedPassword,
    });
    return true;
  }

  async login(req) {
    const { email, password_hash } = req;
    const user = await authRepository.findByEmail(email);
    if (!user) {
      throw new Error("Email hoặc mật khẩu không đúng");
    }
    const isPasswordValid = await bcrypt.compare(password_hash, user.password_hash);
    if (!isPasswordValid) {
      throw new Error("Email hoặc mật khẩu không đúng");
    }
    const payload = {
      userId: user.id,
      username: user.username,
    };
    const accessToken = generateAccessToken(payload);
    const refreshToken = generateRefreshToken(payload);
    // refreshTokens.push(refreshToken);

    const userData = {
      id: user.id,
      username: user.username,
      email: user.email,
    };
    return { accessToken, refreshToken, userData };
  }

  async logout(req) {
    const { refreshToken } = req.body;

    const index = refreshTokens.indexOf(refreshToken);
    if (index !== -1) {
      refreshTokens.splice(index, 1);
    }

    res.json({ message: "Đăng xuất thành công" });
  }

  async refreshToken(req) {
    const { refreshToken } = req.body;

    if (!refreshToken) {
      throw new Error("Không có refresh token");
    }

    // Kiểm tra refresh token có tồn tại không
    // if (!refreshTokens.includes(refreshToken)) {
    //   throw new Error("Refresh token không hợp lệ");
    // }

    try {
      // Verify refresh token
      const decoded = jwt.verify(refreshToken, process.env.JWT_REFRESH_SECRET);

      const payload = {
        userId: decoded.userId,
        username: decoded.username,
      };

      const newAccessToken = generateAccessToken(payload);

      return newAccessToken;
    } catch (error) {
      throw new Error("Refresh token hết hạn");
    }
  }
}

module.exports = new AuthService();
