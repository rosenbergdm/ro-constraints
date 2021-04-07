/**
 * @class       : app
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Monday Apr 05, 2021 10:40:56 EDT
 * @description : app
 */

const sql = require('sqlite3')
const path = require('path')
const express = require('express')
const nunjucks = require('nunjucks')

const app = express()
const port = 3000

nunjucks.configure(path.join(__dirname, 'templates'), {
  autoescape: true,
  express: app
})



app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.get('/test', (req, res) => {
  res.render('test.html',  { pagename: 'TestPage'})
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})

