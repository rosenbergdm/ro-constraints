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
      next: express.NextFunction
    ) => {
      dbg(req.body);
      res.json(req.body);
    }
  );

  app.post(
    '/authTest',
    auth.passport.authenticate('local', {session: false}),
    (req: express.Request, res: express.Response) => {
      res.send('SUCCESSFUL AUTH');
    }
  );
  app.get(
    '/authTest',
    auth.passport.authenticate('local', {session: false}),
    (req: express.Request, res: express.Response) => {
      res.send('SUCCESSFUL AUTH');
    }
  );

  app.get('/', (req: any, res: any, next: any) => {
    res.render('index.html', {pagename: 'TestPage'});
  });

  app.get('/region/:id', async (req: any, res: any) => {
    const id = Number(req.params.id);
    const region = await db.dbquery.getRegion(id);
    res.json(region);
  });

  app.get('/allregions', async (req: any, res: any) => {
    const regions = await db.dbquery.getAllRegions();
    res.json(regions);
  });

  app.get('/search', async (req: express.Request, res: any) => {
    dbg(req.body);
    const target = req.body.target || null;
    const fractionation = req.body.fractionation || null;
    const intent = req.body.intent || null;
    const importance = req.body.importance || null;

    const regions = await db.dbquery.searchRegions(
      target,
      fractionation,
      intent,
      importance
    );
    res.json(regions);
  });
};
