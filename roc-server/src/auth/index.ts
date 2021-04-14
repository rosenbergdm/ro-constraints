/**
 * @module      : auth
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Tuesday Apr 13, 2021 07:36:22 EDT
 * @description :
 */

import * as passport from 'passport';
import {Strategy} from 'passport-local';
import * as argon2 from 'argon2';

export const promiseWithTimeout = (
  timeoutMs: number,
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  promise: Promise<any>
) => {
  let timeoutHandle: NodeJS.Timeout;
  const timeoutPromise = new Promise((_resolve, reject) => {
    timeoutHandle = setTimeout(() => reject(), timeoutMs);
  });

  return Promise.race([promise, timeoutPromise]).then(result => {
    clearTimeout(timeoutHandle);
    return result;
  });
};

export interface Authenticable {
  username: string;
  hashedpw: Buffer;
  checkPassword: (
    password: string,
    cb: (err: Error) => void
  ) => Promise<string | void>;
  setPassword: (password: string, hashed?: boolean) => void;
}

class RoOptions implements argon2.Options {
  timeCost: number;
  memoryCost: number;
  type: 0 | 1 | 2;
  saltLength: number;
  raw: false;

  constructor() {
    this.timeCost = 15;
    this.memoryCost = 32768;
    this.type = 2;
    this.saltLength = 32;
    this.raw = false;
  }
}

export class User implements Authenticable {
  readonly username: string;
  hashedpw = Buffer.from('00000000000000000000000000000000');
  private _tempval: true | false = true;
  private _argon_opts: RoOptions = new RoOptions();
  static userMap: Map<string, User> = new Map();
  async setPassword(password: string, hashed?: boolean) {
    if (hashed) {
      this.hashedpw = Buffer.from(password, 'utf8');
    } else {
      this.hashedpw = Buffer.from(
        await argon2.hash(password, this._argon_opts)
      );
    }
    return;
  }
  async checkPassword(
    password: string,
    cb?: (err: Error) => void
  ): Promise<string | void> {
    if (
      await argon2.verify(
        this.hashedpw.toString('utf8'),
        password,
        this._argon_opts
      )
    ) {
      return this.username;
    } else {
      if (cb) {
        cb(new Error('Password mismatch'));
        return;
      } else {
        return;
      }
    }
  }
  constructor(username: string, password?: string, hashed?: boolean) {
    this.username = username;
    if (hashed) {
      this.setPassword(password, hashed);
    } else {
      this.setPassword(password);
    }
    this.userMap.set(username, this);
  }
  static findUser(username: string, cb?: (err: Error) => void) => User | null {
    let u = User.userMap.get(username);
    if (u) {
      return u;
    } else {
      if (cb) {
        cb(new Error(`User ${username} not found`))
      }
      return;
    }
  
}

/* 
passport.use(new Strategy( (usrname, password, done) => {
    return done("OK");
  }
));
*/


// For testing purposed
export const users = [
  new User('dmr', 'dmr5669', false),
  new User('test', 'dmr5669', false),
];


// passport.use(new Strategy( (username, password, done) => {
//   return done(null, "OK");
// }));
