'use strict';

const express = require('express');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';
const GIT_SHA = process.env.GIT_SHA || 'undefined';

// App
const app = express();

//console.log(process.env);

app.get('/', (req, res) => {
  res.send('<h1>CICD poc1</h1>\n<br \>\n<br \><pre>sha:'+GIT_SHA+'</pre>');
});

app.get('/healthCheck', (req, res) => {
  res.send('healthy\n');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
