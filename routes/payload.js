/**
 * Created by Kseniya on 2/3/2017.
 */
var express = require('express');
var router = express.Router();

/* GET home page. */
router.post('/', function(req, res, next) {
console.log("Received:\n", req.body)
});

module.exports = router;
