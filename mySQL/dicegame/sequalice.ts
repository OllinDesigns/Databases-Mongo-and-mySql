import { Sequelize } from 'sequelize-typescript';

const sequelize = new Sequelize({
  database: 'dicegame', // Replace with your database name
  username: 'OllinDesignsDiceGame', // Replace with your MySQL username
  password: 'cibernarium', // Replace with your MySQL password
  dialect: 'mysql',
  host: 'localhost',
});

export default sequelize;
