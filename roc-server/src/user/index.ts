/**
 * @class       : index.ts
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Thursday Apr 15, 2021 09:09:18 EDT
 * @description :
 */

import 'express';
import 'passport';
import * as argon2 from 'argon2';

// export interface Authenticable {
//   username: string;
//   checkPassword: (
//     password: string,
//     cb: (err: Error) => void
//   ) => Promise<string | false>;
//   setPassword: (password: string, hashed?: boolean) => void;
// }

export class RocArgonOpts implements argon2.Options {
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

// eslint-disable-next-line @typescript-eslint/no-namespace
declare global {
  // eslint-disable-next-line @typescript-eslint/no-namespace
  namespace Express {
    export interface User {
      readonly username: string;
      getHashedPw: () => string;
      checkPassword: (
        testPassword: string,
        done?: (err: any, isMatch: boolean) => void
      ) => Promise<string | false>;
      setPassword: (password: string, hashed?: boolean) => void;
    }
  }
}

export class User implements Express.User {
  private static _argon_opts: RocArgonOpts = new RocArgonOpts();
  private static _users: Map<string, User> = new Map();
  private hashedpw = Buffer.alloc(119);
  readonly username: string;

  getHashedPw() {
    return this.hashedpw.toString('utf8');
  }

  static findUser(
    identifier: string | number,
    done?: (err: any, done: any) => void
  ) {
    let u: User;
    if (typeof identifier === 'string') {
      u = User._users.get(identifier);
    } else {
      const iter = User._users.keys();
      let i = 0;
      let _user: string;
      while (i < identifier) {
        _user = iter.next()['value'];
        i++;
      }
      u = User._users.get(_user);
    }
    if (u) {
      return u;
    } else {
      if (done) {
        done(new Error(`User identified by ${identifier} not found`), null);
      }
      return null;
    }
  }
  async setPassword(password: string, hashed?: boolean) {
    if (hashed) {
      this.hashedpw = Buffer.from(password, 'utf8');
    } else {
      this.hashedpw = Buffer.from(
        await argon2.hash(password, User._argon_opts)
      );
    }
    return;
  }
  async checkPassword(
    testPassword: string,
    done?: (err: any, isMatch: boolean) => void
  ): Promise<string | false> {
    const pwcheck = await argon2.verify(
      this.hashedpw.toString('utf-8'),
      testPassword,
      User._argon_opts
    );
    if (pwcheck) {
      return this.username;
    } else {
      if (done) {
        done(new Error('Password mismatch'), null);
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
    User._users.set(username, this);
  }
}
