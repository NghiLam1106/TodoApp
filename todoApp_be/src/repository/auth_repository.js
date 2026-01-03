const { user } = require("../models");

class AuthRepository {
  async register(userData) {
    return await user.create(userData);
  }

  async findByEmail(email) {
    return await user.findOne({ where: { email } });
  }
}

module.exports = new AuthRepository();
