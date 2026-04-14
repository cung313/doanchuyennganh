function requireAuth(req, res, next) {
  if (req.session?.user) return next();
  return res.redirect('/login');
}

function attachUser(req, res, next) {
  res.locals.currentUser = req.session?.user || null;
  next();
}

module.exports = { requireAuth, attachUser };
