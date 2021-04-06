/**
 * @class       : app
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Monday Apr 05, 2021 10:40:56 EDT
 * @description : app
 */

let sql = require('sqlite3').verbose();
let express = require('express');

const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})

