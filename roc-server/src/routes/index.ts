/**
 * @class       : routes
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Wednesday Apr 07, 2021 11:37:54 EDT
 * @description : routes
 */

import * as express from 'express';

import {db} from '../db';
import {dbg} from '../utils';
import * as auth from '../auth';

export const register = (app: express.Application) => {
  // app.use(express.json())
  app.get(
    '/test',
    (
      req: express.Request,
      res: express.Response,
      _next: express.NextFunction
    ) => {
      dbg(req.body);
      res.json(req.body);
    }
  );

  app.post(
    '/authTest',
    auth.passport.authenticate('local', {session: false}),
    (req: express.Request, res: express.Response) => {
      dbg(req.body);
      res.send('SUCCESSFUL AUTH');
    }
  );

  app.get(
    '/authTest',
    auth.passport.authenticate('local', {session: false}),
    (req: express.Request, res: express.Response) => {
      dbg(req.body);
      res.send('SUCCESSFUL AUTH');
    }
  );

  app.get(
    '/',
    (
      _req: express.Request,
      res: express.Response,
      _next: express.NextFunction
    ) => {
      res.render('index.html', {pagename: 'TestPage'});
    }
  );

  app.get(
    '/region/:id',
    auth.passport.authenticate('local', {session: false}),
    async (req: express.Request, res: express.Response) => {
      const id = Number(req.params.id);
      const region = await db.dbquery.getRegion(id);
      res.json(region);
    }
  );

  app.get(
    '/allregions',
    auth.passport.authenticate('local', {session: false}),
    async (_req: express.Request, res: express.Response) => {
      const regions = await db.dbquery.getAllRegions();
      res.json(regions);
    }
  );

  app.get(
    '/targetnames', 
    auth.passport.authenticate('local', {session: false}),
    async (_req: express.Request, res: express.Response) => {
      const targets = await db.dbquery.getRegionNames();
      res.json(targets);
    }
  );

  app.get(
    '/target/:id',
    auth.passport.authenticate('local', {session: false}),
    async (req: express.Request, res: express.Response) => {
      const id = Number(req.params.id);
      const target = await db.dbquery.getRegion(id);
      res.json(target);
    }
  )};

  app.get(
    '/primarynames', 
    auth.passport.authenticate('local', {session: false}),
    async (_req: express.Request, res: express.Response) => {
      const primaries = await db.dbquery.getRegionNames();
      res.json(primaries);
    }
  );

  app.get(
    '/fractionations',
    auth.passport.authenticate('local', {session: false}),
    async (_req: express.Request, res: express.Response) => {
      const fractionations = await db.dbquery.getFractionations();
      res.json(fractionations);
    }
  );

  app.get(
    '/search',
    auth.passport.authenticate('local', {session: false}),
    async (req: express.Request, res: express.Response) => {
      dbg(req.body);
      const target = req.body.target || null;
      const oncprimary = req.body.oncprimary || null;
      const fractionation = req.body.fractionation || null;
      const intent = req.body.intent || null;
      const importance = req.body.importance || null;

      const regions = await db.dbquery.searchRegions(
        target,
        oncprimary,
        fractionation,
        intent,
        importance
      );
      res.json(regions);
    }
  );
 )
