const bcrypt = require("bcrypt");
const authRepository = require("../repository/auth_repository");

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
}

module.exports = new AuthService();
