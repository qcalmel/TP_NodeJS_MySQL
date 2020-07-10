const router = require('express').Router();
const controller = require('../controllers/api-articles');

router.get('/',controller.getAll);
router.post('/:id([0-9]+)', controller.insertOne);
router.delete('/:id([0-9]+)/:id2([0-9]+)', controller.deleteOne);

module.exports = router