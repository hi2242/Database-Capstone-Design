import express from "express";
import { insertSql } from "../database/sql";

const router = express.Router();

router.get("/", (_req, res) => {
  res.render("insert", { data: [] });
});

router.post("/", async (req, res) => {
  const vars = req.body;
  console.log(vars);
  const data = {
    Id: vars.id,
    Name: vars.name,
    Email: vars.email,
    PhoneNumber: vars.phoneNumber,
    Major: vars.major,
  };
  console.log(`이전 ${data}`);
  await insertSql.setStudent(data);

  res.redirect('/select');
});

module.exports = router;
