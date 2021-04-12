/**
 * @class       : db
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Wednesday Apr 07, 2021 13:37:35 EDT
 * @description : db
 */
import {IDatabase, IMain} from 'pg-promise';
declare type FRange = [number, '-', number];
declare type FractionScheme = FRange | number;
interface IExtensions {
  dbquery: DbQueryInterface;
  promiseLib: Promise<any>;
}
declare type ExtendedProtocol = IDatabase<IExtensions> & IExtensions;
declare class DbQueryInterface {
  private db;
  private pgp;
  params: any;
  constructor(db: IDatabase<any>, pgp: IMain, params: any);
  getRegion(regionId: number): Promise<any>;
  searchRegions(
    target?: string[] | null,
    fractionation?: FractionScheme[],
    intent?: string[] | null,
    importance?: string[] | null
  ): Promise<any[][]>;
  getAllRegions(): Promise<any>;
}
export declare const db: ExtendedProtocol;
export {};
