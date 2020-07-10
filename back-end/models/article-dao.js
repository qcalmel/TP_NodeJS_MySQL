const dao = require('./dao');

//dao.settableName("article");
const tableName = 'article'

dao.findAllArticle = async ()=>{
    const sql = 'SELECT * FROM view_article';
    const result = await dao.query(sql);
    return result[0];
};



dao.insertOneArticle = async (data) => {
    const sql = 'INSERT INTO ?? SET ?';
    
    const result = await dao.query(sql, [tableName, data]);

    
    return result[0];
  };

dao.insertToList = async (article_id,list_id) => {
    

    const sql = 'INSERT INTO list_article SET article_id = ?,list_id= ?'
    const result = await dao.query(sql, [article_id, list_id]);
    return result[0];
  };

dao.findOneByArticle = async (fieldName, value, table = tableName ) => {
    const rows = await dao.query('SELECT * FROM ?? WHERE ??=?', [
        table,
      fieldName,
      value,
    ]);
    return rows[0][0];
  };

  dao.deleteOneArticleById = async id => {
    const result = await dao.query('DELETE FROM ?? WHERE id=?', [tableName, id]);
    return result[0];
  };

  dao.deleteOneArticleOnList = async (article_id,list_id) => {
    const result = await dao.query('DELETE FROM list_article WHERE article_id=? AND list_id=?', [article_id,list_id]);
    return result[0];
  };
module.exports = dao;