import express from 'express';
import * as httpErrors from '@curveball/http-errors';
import * as path from 'path';
import cookieParser from 'cookie-parser';
import logger from 'morgan';
import * as nunjucks from 'nunjucks';

import * as routes from './routes';

const app = express();
const port = 3000;
app.listen(port, () => {
  console.log(`Listening on http://127.0.0.1:${port}`);
});

nunjucks.configure(path.join(__dirname, 'templates'), {
  autoescape: true,
  express: app,
});
console.log(
  `Templates configured for 'nunjucks' using path ${path.join(
    __dirname,
    'templates'
  )}`
);

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({extended: false}));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'static')));

routes.register(app);

app.use((req: any, res: any, next: any) => {
  next(new httpErrors.NotFound());
});

// error handler
app.use((err: any, req: any, res: any, next: any) => {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  next(res.render('error.html'));
});
