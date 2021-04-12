"use strict";
exports.__esModule = true;
var express_1 = require("express");
var httpErrors = require("@curveball/http-errors");
var path = require("path");
var cookie_parser_1 = require("cookie-parser");
var morgan_1 = require("morgan");
var nunjucks = require("nunjucks");
var routes = require("./routes");
var app = express_1["default"]();
var port = 3000;
app.listen(port, function () {
    console.log("Listening on http://127.0.0.1:" + port);
});
nunjucks.configure(path.join(__dirname, 'templates'), {
    autoescape: true,
    express: app
});
console.log("Templates configured for 'nunjucks' using path " + path.join(__dirname, 'templates'));
app.use(morgan_1["default"]('dev'));
app.use(express_1["default"].json());
app.use(express_1["default"].urlencoded({ extended: false }));
app.use(cookie_parser_1["default"]());
app.use(express_1["default"].static(path.join(__dirname, 'static')));
routes.register(app);
app.use(function (req, res, next) {
    next(new httpErrors.NotFound());
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
