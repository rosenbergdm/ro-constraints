/**
 * @class       : routes
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Wednesday Apr 07, 2021 11:37:54 EDT
 * @description : routes
 */

const express = require('express')
const db = require('./db')
var router = express.Router()

router.get('/test', (req, res, next) => {
  console.log(req.body)
  res.json(req.body)
})

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

router.get('/search', async function(req, res) {
  console.log(req.body)
  const target = req.body.target || null
  const fractionation = req.body.fractionation || null
  const intent = req.body.intent || null
  const importance = req.body.importance || null

  const regions = await db.searchRegions(
    target, fractionation, intent, importance)
  res.json(regions)
})

module.exports = router
