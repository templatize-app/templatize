module.exports = {
    clientId: process.env.AUTH0_CLIENT_ID,
    domain: process.env.AUTH0_DOMAIN,
    callbackUrl: process.env.TMPLTZ_CALLBACK ?? 'https://localhost:4200/callback'
  }