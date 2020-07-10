const mysql = require('../database/mysql');
let tableName;

const query = async(sql,data = [])=>{
    const db = await mysql.db
    const result = await db.query(sql,data);
    return result;
}

const findAll = async ()=>{
    const rows = await query("SELECT * FROM ??",[this.tableName]);
    console.log(this.tableName);
    return rows[0];
}

const insertOne = async data => {
    const sql = 'INSERT INTO ?? SET ?';
    const result = await query(sql, [this.tableName, data]);
    return result[0];
  };

  const findOneBy = async (fieldName, value) => {
    const rows = await query('SELECT * FROM ?? WHERE ??=?', [
      this.tableName,
      fieldName,
      value,
    ]);
    return rows[0][0];
  };

  const deleteOneById = async id => {
    const result = await query('DELETE FROM ?? WHERE id=?', [this.tableName, id]);
    console.log(result);
    return result[0];
  };

module.exports = {
    findAll,
    query,
    insertOne,
    findOneBy,
    deleteOneById,
    setTableName : name => (this.tableName = name),
};