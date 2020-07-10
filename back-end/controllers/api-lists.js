const dao = require('../models/list-dao');


exports.getAll = async (req, res) => {
    const rows = await dao.findAllList();
    res.json(rows);

};

exports.insertOne = async (req, res) => {
    const data = {
      list_name: req.body.name,
    };
    const id = req.body.id
    // Tester l'existence de la list
    const test = await dao.findOneByList('list_name', data.list_name);
    if (test && 'id' in test) {
      res.status(200).json({ id: test.id });
    } else {
      const result = await dao.insertOneList(data);
      const rows = await dao.findAllIdArticleFromList(id)
      for(index in rows){
        await dao.copyArticleToList(rows[index].article_id,result.insertId );
      }
    
 
      
    
      res.status(200).json({ id: result.insertId });
    }
  };