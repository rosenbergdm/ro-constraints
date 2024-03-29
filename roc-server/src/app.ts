import express from 'express';
import createError, {HttpError} from 'http-errors';
import * as https from 'https';
import * as path from 'path';
import cookieParser from 'cookie-parser';
import logger from 'morgan';
import * as nunjucks from 'nunjucks';
import * as fs from 'fs';

import * as routes from './routes';
import * as auth from './auth';
import {dbg} from './utils';

export const app = express();

const key = fs.readFileSync('./key.pem');
const cert = fs.readFileSync('./cert.pem');
const port = 3000;

export const server = https.createServer({key: key, cert: cert}, app);
server.listen(port, () => {
  dbg(`Listening on http://127.0.0.1:${port}`);
});

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({extended: false}));
app.use(cookieParser());
app.engine('html', nunjucks.render);
app.set('view engine', 'html');
app.use(express.static(path.join(__dirname, 'static')));

nunjucks.configure(path.join(__dirname, '..', 'templates'), {
  autoescape: true,
  express: app,
});

dbg(
  `Templates configured for 'nunjucks' using path ${path.join(
    __dirname,
    'templates'
  )}`
);

app.use(auth.default.initialize());

routes.register(app);

app.use(
  (
    _req: express.Request,
    _res: express.Response,
    next: express.NextFunction
  ) => {
    next(createError(404));
  }
);

// error handler
app.use(
  (
    err: HttpError,
    req: express.Request,
    res: express.Response,
    next: express.NextFunction
  ) => {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500);
    next(res.render('error.html'));
  }
);
