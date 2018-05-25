'use strict';

var sleep = require('sleep');
var crypto = require('crypto');
const express = require('express');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';
const GIT_SHA = process.env.GIT_SHA || 'undefined_sha';
const GIT_BRANCH = process.env.GIT_BRANCH || 'undefined_branch';

// App
const app = express();

//console.log(process.env);

function spincpu() {
  var rando = crypto.randomBytes(500000).toString('hex');
  console.log('sleeping 5');
  sleep.sleep(5);
}

app.get('/', (req, res) => {
  spincpu();
  res.send('<img src="https://shift.io/images/logo.svg"><h1>CI/CD PoC #1</h1>\n<br \><pre>sha:'+GIT_SHA+'</pre><pre>branch:'+GIT_BRANCH+'</pre>');
});

app.get('/healthCheck', (req, res) => {
  spincpu();
  res.send('healthy\n');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);


