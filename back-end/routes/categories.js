const router = require('express').Router();
const controller = require('../controllers/api-categories');

router.get('/',controller.getAll);

module.exports = router