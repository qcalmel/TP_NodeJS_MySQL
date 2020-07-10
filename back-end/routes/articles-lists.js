const router = require('express').Router();
const controller = require('../controllers/api-articles-lists');

router.get('/:id([0-9]+)',controller.getAllFromList);

module.exports = router