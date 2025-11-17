import express from 'express';
import { selectSql, deleteSql } from '../database/sql';

const router = express.Router();

router.get('/class', async (req, res) => {
    if (req.session.user != undefined && req.session.user.role === 'student') {
        const enrollment = await selectSql.getMyEnrollment(String(req.session.user.id));
        res.render('delete', {
            title: "Delete",
            enrollment,
        });
    } else{
        res.redirect('/');
    }
});

router.post('/class', async (req, res) => {
    const data = {
        Student_Id: req.body.studentId,
        Class_Id: req.body.classId
    };

    await deleteSql.deleteEnrollment(data);

    res.redirect('/delete/class');
});

module.exports = router;
