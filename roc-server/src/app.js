"use strict";
exports.__esModule = true;
var express_1 = require("express");
var http_errors_1 = require("http-errors");
var https = require("https");
var path = require("path");
var cookie_parser_1 = require("cookie-parser");
var morgan_1 = require("morgan");
var nunjucks = require("nunjucks");
var fs = require("fs");
var routes = require("./routes");
var auth = require("./auth");
var utils_1 = require("./utils");
var app = (0, express_1["default"])();
var key = fs.readFileSync('./key.pem');
var cert = fs.readFileSync('./cert.pem');
var port = 3000;
var server = https.createServer({ key: key, cert: cert }, app);
server.listen(port, function () {
    (0, utils_1.dbg)("Listening on http://127.0.0.1:".concat(port));
});
app.use((0, morgan_1["default"])('dev'));
app.use(express_1["default"].json());
app.use(express_1["default"].urlencoded({ extended: false }));
app.use((0, cookie_parser_1["default"])());
app.engine('html', nunjucks.render);
app.set('view engine', 'html');
app.use(express_1["default"].static(path.join(__dirname, 'static')));
nunjucks.configure(path.join(__dirname, '..', 'templates'), {
    autoescape: true,
    express: app
});
(0, utils_1.dbg)("Templates configured for 'nunjucks' using path ".concat(path.join(__dirname, 'templates')));
app.use(auth.passport.initialize());
routes.register(app);
app.use(function (_req, _res, next) {
    next((0, http_errors_1["default"])(404));
});
// error handler
app.use(function (err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};
    // render the error page
    res.status(err.status || 500);
    next(res.render('error.html'));
});
