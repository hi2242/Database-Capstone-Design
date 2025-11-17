import mysql from "mysql2";

require("dotenv").config();

const pool = mysql.createPool({
  host: "localhost",
  port: 3306,
  user: "root",
  password: "admin",
  database: "inha",
});

const promisePool = pool.promise();

// select query
export const selectSql = {
  getBuilding: async () => {
    const sql = "SELECT * FROM building";
    const [result] = await promisePool.query(sql);
    return result;
  },
  getDepartment: async () => {
    const sql = "SELECT * FROM department";
    const [result] = await promisePool.query(sql);
    return result;
  },
  getRoom: async () => {
    const sql = "SELECT * FROM room";
    const [result] = await promisePool.query(sql);
    return result;
  },
  getStudent: async () => {
    const sql = "SELECT * FROM student";
    const [result] = await promisePool.query(sql);
    return result;
  },
  getClass: async () => {
    const sql = "SELECT * FROM class";
    const [result] = await promisePool.query(sql);
    return result;
  },
  getEnrollment: async () => {
    const sql = "SELECT * FROM enrollment";
    const [result] = await promisePool.query(sql);
    return result;
  },
  getMyEnrollment: async (studentId) => {
    const sql = `SELECT * FROM enrollment WHERE Student_Id=${studentId}`;
    const [result] = await promisePool.query(sql);
    console.log(studentId);
    console.log(result);
    return result;
  },
};

export const insertSql = {
  setStudent: async (data) => {
    const sql = `INSERT INTO student VALUES (${data.Id}, "${data.Name}", "${data.Email}", "${data.PhoneNumber}", "${data.Major}")`;
    console.log(data);
    await promisePool.query(sql);
  },
};

export const updateSql = {
  updateStudent: async (data) => {
    const sql = `
      UPDATE student
      SET Id = ${data.Id}, Name = "${data.Name}",
      Email = "${data.Email}", Phone_number = "${data.Phone_number}",
      Major = "${data.Major}"
      WHERE Id = ${data.Id}`;

    console.log(sql);
    await promisePool.query(sql);
  },
  updateDepartment: async (data) => {
    const sql = `
      UPDATE department
      SET Id = "${data.Id}", Name = "${data.Name}",
      Email = "${data.Email}", Phone_number = "${data.Phone_number}",
      Building_Id = "${data.Building_Id}"
      WHERE Id = "${data.Id}"`;

    console.log(sql);
    await promisePool.query(sql);
  },
};

export const deleteSql = {
    deleteEnrollment: async (data) => {
        console.log(`delete Class_Id = ${data.Class_Id} Student_Id = ${data.Student_Id}`);
        const sql = `delete from enrollment where Class_Id="${data.Class_Id}" AND Student_Id=${data.Student_Id}`;
        console.log(sql);
        await promisePool.query(sql);
    },
};