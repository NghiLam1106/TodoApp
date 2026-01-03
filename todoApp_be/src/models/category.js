'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class category extends Model {
    static associate(models) {
      // category -> user
      category.belongsTo(models.user, {
        foreignKey: 'user_id',
      });

      // category -> todos
      category.hasMany(models.todo, {
        foreignKey: 'category_id',
      });
    }
  }

  category.init(
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      name: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      user_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      created_at: {
        type: DataTypes.DATE,
      },
      updated_at: {
        type: DataTypes.DATE,
      },
    },
    {
      sequelize,
      modelName: 'category',
      tableName: 'categories',
      timestamps: true,
      underscored: true,
    }
  );

  return category;
};
