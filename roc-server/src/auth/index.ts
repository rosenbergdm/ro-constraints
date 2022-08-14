/**
 * @module      : auth
 * @author      : David M. Rosenberg (dmr@davidrosenberg.me)
 * @created     : Tuesday Apr 13, 2021 07:36:22 EDT
 * @description :
 */

import 'express';

import {User} from './../user';
import * as passport from 'passport';

import {Strategy} from 'passport-local';

export const users = [
  new User('dmr', 'dmr5669', false),
  new User('test', 'dmr5669', false),
];

passport.use(
  new Strategy(async (username, password, done) => {
    const authUser = User.findUser(username);
    if (!authUser) {
      return done(null, false, {message: 'User does not exist'});
    }
    const match = await authUser.checkPassword(password);
    if (match) {
      return done(null, authUser);
    } else {
      return done(null, false, {message: 'Incorrect password'});
    }
  })
);

// eslint-disable-next-line @typescript-eslint/no-explicit-any
passport.serializeUser(
  (u: Express.User, cb: (err: Error, id?: unknown) => void) => {
    cb(null, u.username);
  }
);

// eslint-disable-next-line @typescript-eslint/no-explicit-any
passport.deserializeUser(async (username: string, done: any) => {
  const u: User = User.findUser(username);
  if (!u) {
    return done(new Error('User not found'));
  }
  return done(null, u);
});

export default passport;
