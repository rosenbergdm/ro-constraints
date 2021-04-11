/**
 * @class       : routes
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Wednesday Apr 07, 2021 11:37:54 EDT
 * @description : routes
 */

// const express = require('express')
// var db = require('../db')
import { db } from '../db';
import * as express from 'express';

export const register = (app: express.Application) => {

  app.get('/test', (req: any, res: any, next: any) => {
    console.log(req.body)
    res.json(req.body)
  })

  app.get('/', (req: any, res: any, next: any) => {
    res.render('index.html', { pagename: 'TestPage' })
  })

  app.get('/region/:id', async (req: any, res: any) => {
    const id: number = Number(req.params.id)
    const region = await db.getRegion(id)
    res.json(region)
  })

  app.get('/allregions', async (req: any, res: any) => {
    const regions = await db.getAllRegions()
    res.json(regions)
  })

  app.get('/search', async (req: any, res: any) => {
    console.log(req.body)
    const target = req.body.target || null
    const fractionation = req.body.fractionation || null
    const intent = req.body.intent || null
    const importance = req.body.importance || null

    const regions = await db.searchRegions(target, fractionation, intent, importance)
    res.json(regions);
  })
}

