/**
 * Created by Kseniya on 2/3/2017.
 */
var express = require('express');
var router = express.Router();
var exec = require('child_process').exec;
var log4js = require('log4js');
log4js.configure({
    appenders: [
        { type: 'console' },
        { type: 'file', filename: 'app.log', category: 'app' }
    ]
});
var logger = log4js.getLogger('app');


/* GET home page. */
router.post('/', function (req, res, next) {
    console.log("Received:\n")
    var repoURL = req.body.repository.git_url;
    var repoName = req.body.repository.name;
    var authorEmail = req.body.head_commit.author.email;
    var authorName = req.body.head_commit.author.name;
    var commitMessage = req.body.head_commit.message;
    logger.log("repoURL - ", repoURL);
    logger.log("repoName - ", repoName);
    logger.log("authorEmail - ", authorEmail);
    logger.log("authorName - ", authorName);
    logger.log("commitMessage - ", commitMessage);
    exec('sh sh/git-pull.sh'
        + ' -n ' + repoName
        + ' -u ' + repoURL
        + ' -a ' + authorName
        + ' -b ' + authorEmail
        + ' -c ' + commitMessage
        + ' -t ' + 'ausdigital.github.io'
        + ' -r ' + 'git@github.com:kshychko/ausdigital.github.io.git'
        , function (err, stdout, stderr) {
            logger.error(err)
            logger.log(stdout)
            logger.error(stderr)
            res.send('webhook was received');
        });
});

module.exports = router;
