"use strict";
exports.__esModule = true;
exports.server = exports.app = void 0;
var express_1 = require("express");
var http_errors_1 = require("http-errors");
var path = require("path");
var cookie_parser_1 = require("cookie-parser");
var morgan_1 = require("morgan");
var nunjucks = require("nunjucks");
var routes = require("./routes");
var utils_1 = require("./utils");
exports.app = express_1["default"]();
var port = 3000;
exports.server = exports.app.listen(port, function () {
    utils_1.dbg("Listening on http://127.0.0.1:" + port);
});
exports.app.use(morgan_1["default"]('dev'));
exports.app.use(express_1["default"].json());
exports.app.use(express_1["default"].urlencoded({ extended: false }));
exports.app.use(cookie_parser_1["default"]());
exports.app.engine('html', nunjucks.render);
exports.app.set('view engine', 'html');
exports.app.use(express_1["default"].static(path.join(__dirname, 'static')));
nunjucks.configure(path.join(__dirname, '..', 'templates'), {
    autoescape: true,
    express: exports.app
});
utils_1.dbg("Templates configured for 'nunjucks' using path " + path.join(__dirname, 'templates'));
routes.register(exports.app);
exports.app.use(function (_req, _res, next) {
    next(http_errors_1["default"](404));
});
// error handler
exports.app.use(function (err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};
    // render the error page
    res.status(err.status || 500);
    next(res.render('error.html'));
});
