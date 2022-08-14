"use strict";
exports.__esModule = true;
exports.promiseWithTimeout = exports.dbg = void 0;
var dbg = function (msg) {
    if (process.env.DEBUG_ROC_SERVER !== undefined &&
        Number(process.env.DEBUG_ROC_SERVER) > 0) {
        console.log(msg);
    }
};
exports.dbg = dbg;
var promiseWithTimeout = function (timeoutMs, 
// eslint-disable-next-line @typescript-eslint/no-explicit-any
promise) {
    var timeoutHandle;
    var timeoutPromise = new Promise(function (_resolve, reject) {
        timeoutHandle = setTimeout(function () { return reject(); }, timeoutMs);
    });
    return Promise.race([promise, timeoutPromise]).then(function (result) {
        clearTimeout(timeoutHandle);
        return result;
    });
};
exports.promiseWithTimeout = promiseWithTimeout;
