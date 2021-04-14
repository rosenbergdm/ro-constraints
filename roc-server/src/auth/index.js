"use strict";
/**
 * @module      : auth
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Tuesday Apr 13, 2021 07:36:22 EDT
 * @description :
 */
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
exports.__esModule = true;
exports.users = exports.User = exports.promiseWithTimeout = void 0;
// import * as passport from 'passport';
// import {Strategy} from 'passport-local';
var argon2 = require("argon2");
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
var RoOptions = /** @class */ (function () {
    function RoOptions() {
        this.timeCost = 15;
        this.memoryCost = 32768;
        this.type = 2;
        this.saltLength = 32;
        this.raw = false;
    }
    return RoOptions;
}());
var User = /** @class */ (function () {
    function User(username, password, hashed) {
        this.hashedpw = Buffer.from('00000000000000000000000000000000');
        this._tempval = true;
        this._argon_opts = new RoOptions();
        this.username = username;
        if (hashed) {
            this.setPassword(password, hashed);
        }
        else {
            this.setPassword(password);
        }
    }
    User.prototype.setPassword = function (password, hashed) {
        return __awaiter(this, void 0, void 0, function () {
            var _a, _b, _c;
            return __generator(this, function (_d) {
                switch (_d.label) {
                    case 0:
                        if (!hashed) return [3 /*break*/, 1];
                        this.hashedpw = Buffer.from(password, 'utf8');
                        return [3 /*break*/, 3];
                    case 1:
                        _a = this;
                        _c = (_b = Buffer).from;
                        return [4 /*yield*/, argon2.hash(password, this._argon_opts)];
                    case 2:
                        _a.hashedpw = _c.apply(_b, [_d.sent()]);
                        _d.label = 3;
                    case 3: return [2 /*return*/];
                }
            });
        });
    };
    User.prototype.checkPassword = function (password, cb) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, argon2.verify(this.hashedpw.toString('utf8'), password, this._argon_opts)];
                    case 1:
                        if (_a.sent()) {
                            return [2 /*return*/, this.username];
                        }
                        else {
                            if (cb) {
                                cb(new Error('Password mismatch'));
                                return [2 /*return*/];
                            }
                            else {
                                return [2 /*return*/];
                            }
                        }
                        return [2 /*return*/];
                }
            });
        });
    };
    return User;
}());
exports.User = User;
exports.users = [
    new User('dmr', 'dmr5669', false),
    new User('test', 'dmr5669', false),
];
// passport.use(new Strategy( (username, password, done) => {
//   return done(null, "OK");
// }));
