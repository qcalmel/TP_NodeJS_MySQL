const dao = require('../models/article-list-dao');


exports.getAllFromList = async (req, res) => {
    id = req.params.id
    const rows = await dao.findAllArticleFromList(id);
    res.json(rows);

};
