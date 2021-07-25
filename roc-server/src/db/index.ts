/**
 * @class       : db
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Wednesday Apr 07, 2021 13:37:35 EDT
 * @description : db
 */

import pgPromise from 'pg-promise';
import * as Bluebird from 'bluebird';
import {IInitOptions, IDatabase, IMain} from 'pg-promise';

import {dbg} from '../utils';

const Promise2 = Bluebird as any;

type FRange = [number, '-', number];
type FractionScheme = FRange | number;

function isDefined<T>(value: T | undefined | null): value is T {
  return (value as T) !== undefined && (value as T) !== null;
}

interface IExtensions {
  dbquery: DbQueryInterface;
  promiseLib: Promise<any>;
}

type ExtendedProtocol = IDatabase<IExtensions> & IExtensions;

class DbQueryInterface {
  params: any = null;

  constructor(private db: IDatabase<any>, private pgp: IMain, params: any) {
    this.params = params;
  }

  async getRegion(regionId: number) {
    return this.db.one(`SELECT * from region where id = ${regionId}`);
  }

  async searchRegions(
    target: string[] | null = null,
    oncprimary: string[] | null = null,
    fractionation: FractionScheme[] = null,
    intent: string[] | null = null,
    importance: string[] | null = null
  ) {
    let whereClause = 'WHERE region.id > 0 ';
    if (isDefined(target) && oncprimary !== null) {
      whereClause += `AND target.name in ( ${
        "'" + target.join("', '") + "'"
      } ) `;
    }
    if (isDefined(oncprimary) && oncprimary !== null) {
      whereClause += `AND onctarget.name in ( ${
        "'" + oncprimary.join(", '") + "'"
      } ) `;
    }
    if (fractionation !== null) {
      if (fractionation.every((x: any) => typeof x === 'number')) {
        whereClause += `AND fractions_min in (${fractionation}) `;
      } else if (
        fractionation.length === 3 &&
        typeof fractionation[1] === 'string'
      ) {
        whereClause +=
          `AND fractions_min >= ${fractionation[0]} ` +
          ` and (fractions_max <= ${fractionation[2]} OR fractions_max is null) `;
      } else {
        whereClause += `AND fractionation.description in ( ${
          "'" + fractionation.join("', '") + "'"
        } ) `;
      }
    }
    if (intent !== null) {
      whereClause += ` AND intent.description in ( ${
        "'" + intent.join("', '") + "'"
      } ) `;
    }
    if (importance !== null) {
      whereClause += ` AND region.importance in ( ${
        "'" + importance.join("', '") + "'"
      } ) `;
    }
    const query = `
    SELECT
        region.id,
        target.name targetname,
        oncprimary.name oncprimaryname,
        coalesce(fractionation.description, '') || coalesce(fractions_min::text, '') || coalesce('-' || fractions_max::text, '') as fractionation,
        intent.description,
        volume::float / 100 || ' ' || vtype.description as volume,
        volume_deviation::float / 100 || ' ' || vtype2.description as volume_deviation,
        prv,
        dose::float / 100 || ' ' || dtype.description as dose,
        dose_deviation::float / 100 || ' ' || dtype2.description as dose_deviation,
        conversion,
        importance
      FROM
        region
        INNER JOIN target on region.target = target.id
        INNER JOIN target oncprimary on region.oncprimary = oncprimary.id
        LEFT JOIN fractionation on region.fractionation = fractionation.id
        LEFT JOIN volume_type vtype on region.volume_type = vtype.id
        LEFT JOIN intent on region.intent = intent.id
        LEFT JOIN volume_type vtype2 on region.volume_deviation_type = vtype2.id
        LEFT JOIN dose_type dtype on region.dose_type = dtype.id
        LEFT JOIN dose_type dtype2 on region.dose_deviation_type = dtype2.id

      ${whereClause};`;
    console.log(query);
    return this.db.multi(query, []);
  }

  async getAllRegions(): Promise<any> {
    return this.searchRegions(null, null, null, null, null);
  }
}

const initOptions: IInitOptions<IExtensions> = {
  extend(obj: ExtendedProtocol, dc: any) {
    obj.promiseLib = Promise2;
    obj.dbquery = new DbQueryInterface(obj, pgp, {database: 'constraints'});
  },
};

const pgp: IMain = pgPromise(initOptions);
dbg('Database connected');

export const db: ExtendedProtocol = pgp({database: 'constraints'});
