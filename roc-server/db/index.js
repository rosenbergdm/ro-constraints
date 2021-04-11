"use strict";
/**
 * @class       : db
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Wednesday Apr 07, 2021 13:37:35 EDT
 * @description : db
 */
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        if (typeof b !== "function" && b !== null)
            throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
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
exports.db = exports.ExtendedClient = void 0;
var pg_1 = require("pg");
function isDefined(value) {
    return value !== undefined && value !== null;
}
var ExtendedClient = /** @class */ (function (_super) {
    __extends(ExtendedClient, _super);
    function ExtendedClient(params) {
        var _this = _super.call(this, params) || this;
        _this.getRegion = function (regionId) {
            return __awaiter(this, void 0, void 0, function () {
                var rows;
                return __generator(this, function (_a) {
                    switch (_a.label) {
                        case 0: return [4 /*yield*/, this.query('SELECT * from region where id = $1', [regionId])];
                        case 1:
                            rows = (_a.sent()).rows;
                            return [2 /*return*/, (rows[0])];
                    }
                });
            });
        };
        _this.searchRegions = function (target, fractionation, intent, importance) {
            if (target === void 0) { target = null; }
            if (fractionation === void 0) { fractionation = null; }
            if (intent === void 0) { intent = null; }
            if (importance === void 0) { importance = null; }
            return __awaiter(this, void 0, void 0, function () {
                var whereClause, query, rows;
                return __generator(this, function (_a) {
                    switch (_a.label) {
                        case 0:
                            whereClause = 'WHERE region.id > 0 ';
                            if (isDefined(target)) {
                                whereClause += "AND target.name in ( " + ("'" + target.join("', '") + "'") + " ) ";
                            }
                            if (fractionation !== null) {
                                if (fractionation.every(function (x) { return typeof (x) === 'number'; })) {
                                    whereClause += "AND fractions_min in (" + fractionation + ") ";
                                }
                                else if (fractionation.length === 3 && typeof (fractionation[1]) === 'string') {
                                    whereClause += "AND fractions_min >= " + fractionation[0] + " " +
                                        (" and (fractions_max <= " + fractionation[2] + " OR fractions_max is null) ");
                                }
                                else {
                                    whereClause +=
                                        "AND fractionation.description in ( " + ("'" + fractionation.join("', '") + "'") + " ) ";
                                }
                            }
                            if (intent !== null) {
                                whereClause +=
                                    " AND intent.description in ( " + ("'" + intent.join("', '") + "'") + " ) ";
                            }
                            if (importance !== null) {
                                whereClause +=
                                    " AND region.importance in ( " + ("'" + importance.join("', '") + "'") + " ) ";
                            }
                            query = "\n    SELECT\n        region.id,\n        target.name,\n        coalesce(fractionation.description, '') || coalesce(fractions_min::text, '') || coalesce('-' || fractions_max::text, '') as fractionation,\n        intent.description,\n        volume::float / 100 || ' ' || vtype.description as volume,\n        volume_deviation::float / 100 || ' ' || vtype2.description as volume_deviation,\n        prv,\n        dose::float / 100 || ' ' || dtype.description as dose,\n        dose_deviation::float / 100 || ' ' || dtype2.description as dose_deviation,\n        conversion,\n        importance\n      FROM\n        region\n        LEFT JOIN target on region.target = target.id\n        LEFT JOIN fractionation on region.fractionation = fractionation.id\n        LEFT JOIN volume_type vtype on region.volume_type = vtype.id\n        LEFT JOIN intent on region.intent = intent.id\n        LEFT JOIN volume_type vtype2 on region.volume_deviation_type = vtype2.id\n        LEFT JOIN dose_type dtype on region.dose_type = dtype.id\n        LEFT JOIN dose_type dtype2 on region.dose_deviation_type = dtype.id\n      " + whereClause + ";";
                            return [4 /*yield*/, this.query(query, [])];
                        case 1:
                            rows = (_a.sent()).rows;
                            return [2 /*return*/, (rows)];
                    }
                });
            });
        };
        _this.getAllRegions = function () {
            return __awaiter(this, void 0, void 0, function () {
                var rows;
                return __generator(this, function (_a) {
                    switch (_a.label) {
                        case 0: return [4 /*yield*/, this.searchRegions()];
                        case 1:
                            rows = _a.sent();
                            return [2 /*return*/, (rows)];
                    }
                });
            });
        };
        return _this;
    }
    return ExtendedClient;
}(pg_1.Client));
exports.ExtendedClient = ExtendedClient;
exports.db = new ExtendedClient({
    database: 'constraints'
});
exports.db.connect(function (err) {
    if (err) {
        console.error('Database connection error', err.stack);
    }
    else {
        console.log("Connection to database 'constraints' successful");
    }
});
