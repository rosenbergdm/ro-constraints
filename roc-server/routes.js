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
  var region = await db.getRegion(id)
  res.json(region)
})

router.get('/allregions', async function(req, res) {
  const regions = await db.getAllRegions()
  res.json(regions)
})

module.exports = router

