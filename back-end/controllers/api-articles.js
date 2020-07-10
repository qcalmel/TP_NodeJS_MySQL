const dao = require('../models/article-dao');

exports.getAll = async (req, res) => {
    const rows = await dao.findAllArticle();
    res.json(rows);

};

exports.insertOne = async (req, res) => {
    const data = {
        article_name: req.body.name,
        category_id: req.body.categoryId
    };
    const id = req.params.id
    // Tester l'existence de la profession
    const test = await dao.findOneByArticle('article_name', data.article_name);
    if (test && 'id' in test) {
        await dao.insertToList(test.id, id);
        res.status(200).json({ id: test.id });
    } else {
        const result = await dao.insertOneArticle(data);
        await dao.insertToList(result.insertId, id);
        res.status(200).json({ id: result.insertId });
    }
};
exports.deleteOne = async (req, res) => {
    const articleId = req.params.id
    const listId = req.params.id2
    await dao.deleteOneArticleOnList(articleId,listId);
    const test = await dao.findOneByArticle('article_id', articleId, 'list_article');
    if (test && 'article_id' in test) {
        res.status(200).json({resultat:"Article supprimé de la liste", id: test.id });
    } else {
        const result = await dao.deleteOneArticleById(articleId);
        res.status(200).json({resultat:"Article supprimé de la BDD", id: result.insertId });
    }


};