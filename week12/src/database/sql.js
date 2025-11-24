import mysql from "mysql2";

const pool = mysql.createPool(
  process.env.JAWSDB_URL ?? {
    host: 'localhost',
    user: 'root',
    database: 'WEEK12_INHA_DB',
    password: 'admin',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
  }
);

// async / await 사용
const promisePool = pool.promise();

// selec query
export const selectSql = {
  getUsers: async () => {
    const [rows] = await promisePool.query(`select * from student`);
    return rows;
  },
  getMyId: async (studentId) => {
    const [id] = await promisePool.query(`SELECT id FROM student S WHERE S.StudentId=${studentId}`);
    return id[0].id;
  },
  getClasses: async () => {
    const [rows] = await promisePool.query(`SELECT C.*, D.Dname AS Opening_departments, C.Number_of_participant - IFNULL(E.Enrolled_Count, 0) AS Remaining_participants FROM class C LEFT JOIN department D ON C.Did = D.ID LEFT JOIN (SELECT Class_Id, COUNT(*) AS Enrolled_Count FROM class_student GROUP BY Class_Id) AS E ON C.ID=E.Class_Id`);
    return rows;
  },
  getEnrollments: async (id) => {
    const [rows] = await promisePool.query(`SELECT C.*, D.Dname AS Opening_departments FROM class C LEFT JOIN department D ON C.Did=D.ID WHERE C.ID IN (SELECT Class_Id FROM class_student C WHERE C.Student_Id = ${id}) ORDER BY C.id`);
    return rows;
  },
}

export const createSql = {
  addClass: async (data) => {
    const uid = await promisePool.query(`SELECT Id FROM Student WHERE StudentId=${data.sId}`);

    const completionList = await promisePool.query(`SELECT Class_Id FROM class_student WHERE Student_Id=${uid[0][0].Id}`);
    
    let isComplete = false;
    completionList[0].forEach(each => {
      if (Number(data.cId) === Number(each.Class_Id)) {
        isComplete = true;
        return 0;
      }
    });

    if (isComplete) {
      console.log('이미 신청 완료된 강의입니다.');
      return 0;
    }

    const results = await promisePool.query (
      `INSERT INTO class_student VALUES (${uid[0][0].Id}, ${data.cId});`
    );
    return results[0];
  },
}