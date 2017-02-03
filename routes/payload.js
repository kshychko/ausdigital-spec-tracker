/**
 * Created by Kseniya on 2/3/2017.
 */
var express = require('express');
var router = express.Router();

/* GET home page. */
router.post('/', function (req, res, next) {
    console.log("Received:\n")
    var repoURL = req.body.repository;
    console.log(repoURL)
    exec('sh sh/git-pull.sh' + ' -u ' + repoURL, function (err, stdout, stderr) {
        console.log(err, stdout, stderr);
    })
    res.send('webhook was received');
});

module.exports = router;
