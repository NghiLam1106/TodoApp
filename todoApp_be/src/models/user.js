'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class user extends Model {
    static associate(models) {
      // user -> todos
      user.hasMany(models.todo, {
        foreignKey: 'user_id',
      });

      // user -> categories
      user.hasMany(models.category, {
        foreignKey: 'user_id',
      });
    }
  }

  user.init(
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      username: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
      },
      email: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
      },
      password_hash: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      created_at: {
        type: DataTypes.DATE,
      },
    },
    {
      sequelize,
      modelName: 'user',
      tableName: 'users',     // ⚠️ BẮT BUỘC vì bảng đã tồn tại
      timestamps: false,      // bảng chỉ có created_at
      underscored: true,      // snake_case trong DB
    }
  );

  return user;
};
