const dao = require('../models/category-dao');

exports.getAll = async (req, res) => {
    const rows = await dao.findAllCategory();
    res.json(rows);

};