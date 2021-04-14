"use strict";
exports.__esModule = true;
exports.dbg = void 0;
var dbg = function (msg) {
    if (process.env.DEBUG_ROC_SERVER !== undefined &&
        Number(process.env.DEBUG_ROC_SERVER) > 0) {
        console.log(msg);
    }
};
exports.dbg = dbg;
