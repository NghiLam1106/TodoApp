'use strict';
const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class todo extends Model {
    static associate(models) {
      // todo -> user
      todo.belongsTo(models.user, {
        foreignKey: 'user_id',
      });

      // todo -> category
      todo.belongsTo(models.category, {
        foreignKey: 'category_id',
      });
    }
  }

  todo.init(
    {
      id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
      },
      user_id: {
        type: DataTypes.INTEGER,
        allowNull: false,
      },
      category_id: {
        type: DataTypes.INTEGER,
      },
      title: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      description: {
        type: DataTypes.TEXT,
      },
      is_completed: {
        type: DataTypes.BOOLEAN,
        defaultValue: false,
      },
      priority: {
        type: DataTypes.INTEGER,
      },
      due_date: {
        type: DataTypes.DATE,
      },
      status: {
        type: DataTypes.STRING,
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
      modelName: 'todo',
      tableName: 'todos',
      timestamps: true,
      underscored: true,
    }
  );

  return todo;
};
