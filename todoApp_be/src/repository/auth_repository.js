const { user } = require("../models");

class AuthRepository {
  async register(userData) {
    return await user.create(userData);
  }

  async login(userData) {
    return await user.findOne({
      where: { email: userData.email, password: userData.password },
    });
  }

  async findByEmail(email) {
    return await user.findOne({ where: { email } });
  }
}

module.exports = new AuthRepository();
