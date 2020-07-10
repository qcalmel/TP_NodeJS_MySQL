const dao = require('./dao');

//dao.setTableName("category");
const TableName = 'category'

dao.findAllCategory = async ()=>{
    const rows = await dao.query("SELECT * FROM ??",[TableName]);
    return rows[0];
}

module.exports = dao;