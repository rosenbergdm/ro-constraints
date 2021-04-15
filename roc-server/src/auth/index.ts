/**
 * @module      : auth
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Tuesday Apr 13, 2021 07:36:22 EDT
 * @description :
 */

import 'express';

import passport from 'passport';
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
  ) => Promise<string | false>;
  setPassword: (password: string, hashed?: boolean) => void;
}

export class RoOptions implements argon2.Options {
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

export class ROUser implements Authenticable {
  readonly username: string;
  hashedpw = Buffer.from('00000000000000000000000000000000');
  private _argon_opts: RoOptions = new RoOptions();
  private static userMap: Map<string, ROUser> = new Map();
  public static findUser(username: string, cb?: (err: Error) => ROUser | null) {
    const u = ROUser.userMap.get(username);
    if (u) {
      return u;
    } else {
      if (cb) {
        cb(new Error(`User ${username} not found`));
      }
      return null;
    }
  }
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
  ): Promise<string | false> {
    const pwcheck = await argon2.verify(
      this.hashedpw.toString('utf-8'),
      password,
      this._argon_opts
    );
    if (pwcheck) {
      return this.username;
    } else {
      if (cb) {
        cb(new Error('Password mismatch'));
      }
      return false;
    }
  }
  constructor(username: string, password?: string, hashed?: boolean) {
    this.username = username;
    if (hashed) {
      this.setPassword(password, hashed);
    } else {
      this.setPassword(password);
    }
    ROUser.userMap.set(username, this);
  }
}
// For testing purposed
export const users = [
  new ROUser('dmr', 'dmr5669', false),
  new ROUser('test', 'dmr5669', false),
];

passport.use(
  new Strategy(async (username, password, done) => {
    const authUser: ROUser | null = ROUser.findUser(username);
    if (!authUser) {
      return done(null, false, {message: 'User does not exist'});
    }
    const match = await authUser.checkPassword(password);
    // console.log(`match = '${match}'`);
    if (match) {
      return done(null, authUser);
    } else {
      return done(null, false, {message: 'Incorrect password'});
    }
  })
);

passport.serializeUser((user, cb: any) => {
  cb(null, user);
});

passport.deserializeUser(async (username: string, done: any) => {
  const user = await ROUser.findUser(username);
  if (!user) {
    return done(new Error('User not found'));
  }
  return done(null, user);
});

export {passport};
