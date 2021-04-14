"use strict";
/**
 * @class       : routes
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Wednesday Apr 07, 2021 11:37:54 EDT
 * @description : routes
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
exports.register = void 0;
var db_1 = require("../db");
var utils_1 = require("../utils");
var register = function (app) {
    // app.use(express.json())
    app.get('/test', function (req, res, next) {
        utils_1.dbg(req.body);
        res.json(req.body);
    });
    app.get('/', function (req, res, next) {
        res.render('index.html', { pagename: 'TestPage' });
    });
    app.get('/region/:id', function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
        var id, region;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    id = Number(req.params.id);
                    return [4 /*yield*/, db_1.db.dbquery.getRegion(id)];
                case 1:
                    region = _a.sent();
                    res.json(region);
                    return [2 /*return*/];
            }
        });
    }); });
    app.get('/allregions', function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
        var regions;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0: return [4 /*yield*/, db_1.db.dbquery.getAllRegions()];
                case 1:
                    regions = _a.sent();
                    res.json(regions);
                    return [2 /*return*/];
            }
        });
    }); });
    app.get('/search', function (req, res) { return __awaiter(void 0, void 0, void 0, function () {
        var target, fractionation, intent, importance, regions;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    utils_1.dbg(req.body);
                    target = req.body.target || null;
                    fractionation = req.body.fractionation || null;
                    intent = req.body.intent || null;
                    importance = req.body.importance || null;
                    return [4 /*yield*/, db_1.db.dbquery.searchRegions(target, fractionation, intent, importance)];
                case 1:
                    regions = _a.sent();
                    res.json(regions);
                    return [2 /*return*/];
            }
        });
    }); });
};
exports.register = register;
