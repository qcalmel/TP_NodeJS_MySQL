const router = require('express').Router();
const controller = require('../controllers/api-lists');

router.get('/',controller.getAll);
router.post('/', controller.insertOne);

module.exports = router