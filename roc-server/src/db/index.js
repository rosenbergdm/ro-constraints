'use strict';
/**
 * @class       : db
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Wednesday Apr 07, 2021 13:37:35 EDT
 * @description : db
 */
const __awaiter =
  (this && this.__awaiter) ||
  function (thisArg, _arguments, P, generator) {
    function adopt(value) {
      return value instanceof P
        ? value
        : new P(resolve => {
            resolve(value);
          });
    }
    return new (P || (P = Promise))((resolve, reject) => {
      function fulfilled(value) {
        try {
          step(generator.next(value));
        } catch (e) {
          reject(e);
        }
      }
      function rejected(value) {
        try {
          step(generator['throw'](value));
        } catch (e) {
          reject(e);
        }
      }
      function step(result) {
        result.done
          ? resolve(result.value)
          : adopt(result.value).then(fulfilled, rejected);
      }
      step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
  };
const __generator =
  (this && this.__generator) ||
  function (thisArg, body) {
    let _ = {
        label: 0,
        sent: function () {
          if (t[0] & 1) throw t[1];
          return t[1];
        },
        trys: [],
        ops: [],
      },
      f,
      y,
      t,
      g;
    return (
      (g = {next: verb(0), throw: verb(1), return: verb(2)}),
      typeof Symbol === 'function' &&
        (g[Symbol.iterator] = function () {
          return this;
        }),
      g
    );
    function verb(n) {
      return function (v) {
        return step([n, v]);
      };
    }
    function step(op) {
      if (f) throw new TypeError('Generator is already executing.');
      while (_)
        try {
          if (
            ((f = 1),
            y &&
              (t =
                op[0] & 2
                  ? y['return']
                  : op[0]
                  ? y['throw'] || ((t = y['return']) && t.call(y), 0)
                  : y.next) &&
              !(t = t.call(y, op[1])).done)
          )
            return t;
          if (((y = 0), t)) op = [op[0] & 2, t.value];
          switch (op[0]) {
            case 0:
            case 1:
              t = op;
              break;
            case 4:
              _.label++;
              return {value: op[1], done: false};
            case 5:
              _.label++;
              y = op[1];
              op = [0];
              continue;
            case 7:
              op = _.ops.pop();
              _.trys.pop();
              continue;
            default:
              if (
                !((t = _.trys), (t = t.length > 0 && t[t.length - 1])) &&
                (op[0] === 6 || op[0] === 2)
              ) {
                _ = 0;
                continue;
              }
              if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) {
                _.label = op[1];
                break;
              }
              if (op[0] === 6 && _.label < t[1]) {
                _.label = t[1];
                t = op;
                break;
              }
              if (t && _.label < t[2]) {
                _.label = t[2];
                _.ops.push(op);
                break;
              }
              if (t[2]) _.ops.pop();
              _.trys.pop();
              continue;
          }
          op = body.call(thisArg, _);
        } catch (e) {
          op = [6, e];
          y = 0;
        } finally {
          f = t = 0;
        }
      if (op[0] & 5) throw op[1];
      return {value: op[0] ? op[1] : void 0, done: true};
    }
  };
const __importDefault =
  (this && this.__importDefault) ||
  function (mod) {
    return mod && mod.__esModule ? mod : {default: mod};
  };
exports.__esModule = true;
exports.db = void 0;
const pg_promise_1 = __importDefault(require('pg-promise'));
function isDefined(value) {
  return value !== undefined && value !== null;
}
const DbQueryInterface = /** @class */ (function () {
  function DbQueryInterface(db, pgp, params) {
    this.db = db;
    this.pgp = pgp;
    this.params = null;
    this.params = params;
  }
  DbQueryInterface.prototype.getRegion = function (regionId) {
    return __awaiter(this, void 0, void 0, function () {
      return __generator(this, function (_a) {
        return [
          2 /*return*/,
          this.db.one('SELECT * from region where id = ' + regionId),
        ];
      });
    });
  };
  DbQueryInterface.prototype.searchRegions = function (
    target,
    fractionation,
    intent,
    importance
  ) {
    if (target === void 0) {
      target = null;
    }
    if (fractionation === void 0) {
      fractionation = null;
    }
    if (intent === void 0) {
      intent = null;
    }
    if (importance === void 0) {
      importance = null;
    }
    return __awaiter(this, void 0, void 0, function () {
      let whereClause, query;
      return __generator(this, function (_a) {
        whereClause = 'WHERE region.id > 0 ';
        if (isDefined(target)) {
          whereClause +=
            'AND target.name in ( ' + ("'" + target.join("', '") + "'") + ' ) ';
        }
        if (fractionation !== null) {
          if (
            fractionation.every(x => {
              return typeof x === 'number';
            })
          ) {
            whereClause += 'AND fractions_min in (' + fractionation + ') ';
          } else if (
            fractionation.length === 3 &&
            typeof fractionation[1] === 'string'
          ) {
            whereClause +=
              'AND fractions_min >= ' +
              fractionation[0] +
              ' ' +
              (' and (fractions_max <= ' +
                fractionation[2] +
                ' OR fractions_max is null) ');
          } else {
            whereClause +=
              'AND fractionation.description in ( ' +
              ("'" + fractionation.join("', '") + "'") +
              ' ) ';
          }
        }
        if (intent !== null) {
          whereClause +=
            ' AND intent.description in ( ' +
            ("'" + intent.join("', '") + "'") +
            ' ) ';
        }
        if (importance !== null) {
          whereClause +=
            ' AND region.importance in ( ' +
            ("'" + importance.join("', '") + "'") +
            ' ) ';
        }
        query =
          "\n    SELECT\n        region.id,\n        target.name,\n        coalesce(fractionation.description, '') || coalesce(fractions_min::text, '') || coalesce('-' || fractions_max::text, '') as fractionation,\n        intent.description,\n        volume::float / 100 || ' ' || vtype.description as volume,\n        volume_deviation::float / 100 || ' ' || vtype2.description as volume_deviation,\n        prv,\n        dose::float / 100 || ' ' || dtype.description as dose,\n        dose_deviation::float / 100 || ' ' || dtype2.description as dose_deviation,\n        conversion,\n        importance\n      FROM\n        region\n        LEFT JOIN target on region.target = target.id\n        LEFT JOIN fractionation on region.fractionation = fractionation.id\n        LEFT JOIN volume_type vtype on region.volume_type = vtype.id\n        LEFT JOIN intent on region.intent = intent.id\n        LEFT JOIN volume_type vtype2 on region.volume_deviation_type = vtype2.id\n        LEFT JOIN dose_type dtype on region.dose_type = dtype.id\n        LEFT JOIN dose_type dtype2 on region.dose_deviation_type = dtype.id\n      " +
          whereClause +
          ';';
        return [2 /*return*/, this.db.multi(query, [])];
      });
    });
  };
  DbQueryInterface.prototype.getAllRegions = function () {
    return __awaiter(this, void 0, void 0, function () {
      return __generator(this, function (_a) {
        return [2 /*return*/, this.searchRegions()];
      });
    });
  };
  return DbQueryInterface;
})();
const initOptions = {
  extend: function (obj, dc) {
    obj.promiseLib = require('bluebird');
    obj.dbquery = new DbQueryInterface(obj, pgp, {database: 'constraints'});
  },
};
var pgp = pg_promise_1['default'](initOptions);
exports.db = pgp({database: 'constraints'});
