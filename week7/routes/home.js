import express from "express";
import { selectSql } from "../database/sql";

const router = express.Router();

router.get('/', (req, res) => {
    res.render('home');
});

router.post('/', async (req, res) => {
    const vars = req.body;
    const students = await selectSql.getStudent();
    
    req.session.user = undefined;

    students.map((student) => {
        console.log('ID :', student.Id);
        if (vars.id === String(student.Id) && vars.password === student.Phone_number) {
            console.log('login success!');
            req.session.user = { id: student.Id, role: 'student', checkLogin: true };
        }
    });

    if (req.session.user == undefined) {
        console.log('login failed!');
        res.send(`<script>
                    alert('login failed!');
                    location.href='/';
                </script>`)
    }
    else if (req.session.user.checkLogin && req.session.user.role === 'student') {
        res.redirect('/select');
    }
});

module.exports = router;