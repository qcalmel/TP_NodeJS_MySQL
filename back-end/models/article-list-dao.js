const dao = require('./dao');





dao.findAllArticleFromList = async (id)=>{
    const sql = 'SELECT a.*, c.category_name, l.list_name FROM article as a INNER JOIN category as c INNER JOIN list as l INNER JOIN list_article as l_a  ON a.category_id = c.id AND l_a.article_id = a.id AND l.id = l_a.list_id WHERE l.id = ?';
    const result = await dao.query(sql,[id]);
    return result[0];
};


module.exports = dao;