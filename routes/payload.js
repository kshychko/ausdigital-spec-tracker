/**
 * Created by Kseniya on 2/3/2017.
 */
var express = require('express');
var router = express.Router();
var exec = require('child_process').exec;

/* GET home page. */
router.post('/', function (req, res, next) {
    console.log("Received:\n")
    var repoURL = req.body.repository.git_url;
    var repoName = req.body.repository.name;
    console.log(repoURL)
    exec('sh sh/git-pull.sh' + ' -d ' + repoName+ ' -u ' + repoURL, function (err, stdout, stderr) {
        console.log(err, stdout, stderr);
    })
    res.send('webhook was received');
});

module.exports = router;
