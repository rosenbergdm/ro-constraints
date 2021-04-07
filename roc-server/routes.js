/**
 * @class       : routes
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Wednesday Apr 07, 2021 11:37:54 EDT
 * @description : routes
 */

const express = require('express')
const db = require('./db')
var router = express.Router()


router.get('/', (req, res, next) => {
  res.render('index.html', { pagename: 'TestPage' })
})

router.get('/region/:id', async function(req, res) {
  var id = req.params.id
  var region = db.getRegion(id)
  res.send(region)
})

module.exports = router

