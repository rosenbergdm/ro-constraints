
passport.use(
  new Strategy(async (username, password, done) => {
    const authUser2: user.User | null = user.User.findUser(username);
    if (!authUser) {
      return done(null, false, {message: 'User does not exist'});
    }
    const match2 = await authUser.checkPassword(password);
    if (match2) {
      return done(null, authUser);
    } else {
      return done(null, false, {message: 'Incorrect password'});
    }
  })
);
