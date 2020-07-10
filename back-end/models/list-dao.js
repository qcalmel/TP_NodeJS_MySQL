const dao = require('./dao');

//dao.setTableName("list");
const TableName = 'list'


dao.findAllList = async () => {
  const rows = await dao.query("SELECT * FROM ?? WHERE list_name != 'temporary_list' ", [TableName]);
  return rows[0];
}

dao.insertOneList = async data => {
  const sql = 'INSERT INTO ?? SET ?';
  console.log(data);
  const result = await dao.query(sql, [TableName, data]);
  return result[0];
};

dao.findOneByList = async (fieldName, value) => {
  const rows = await dao.query('SELECT * FROM ?? WHERE ??=?', [
    TableName,
    fieldName,
    value,
  ]);
  return rows[0][0];
};

dao.copyArticleToList = async(article_id,list_id) =>{
  const sql = 'INSERT INTO list_article SET article_id=? AND list_id=?'
  const result = await dao.query(sql, [article_id,list_id]);
}

dao.findAllIdArticleFromList = async (id)=>{
  const sql = 'SELECT a.id as article_id FROM article as a INNER JOIN category as c INNER JOIN list as l INNER JOIN list_article as l_a  ON a.category_id = c.id AND l_a.article_id = a.id AND l.id = l_a.list_id WHERE l.id = ?';
  const result = await dao.query(sql,[id]);
  return result[0];
};

module.exports = dao;