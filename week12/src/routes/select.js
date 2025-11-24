import express from "express";
import { selectSql, createSql } from '../database/sql';

const router = express.Router();

router.get('/', async function (req, res) {
    const Classes = await selectSql.getClasses();
    const myId = await selectSql.getMyId(req.cookies.user);
    const Enrollments = await selectSql.getEnrollments(myId);
    
    if (req.cookies.user) {
        res.render('select', { 
            user: req.cookies.user,
            title: 'Course completion list',
            title2: 'Course List (Registration)',
            classes: Enrollments,
            allClass: Classes
         });
    } else {
        res.render('/')
    }

});

router.post('/', async(req, res) => {
    const remain = Number(req.body.remain);
    const data = {
        cId: req.body.applyBtn,
        sId: req.cookies.user,
    };
    if (remain === 0) {
        console.log('수강 인원 초과');
    } else {
        await createSql.addClass(data);
    }

    res.redirect('/sugang');
});

module.exports = router;