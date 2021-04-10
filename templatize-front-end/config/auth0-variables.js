module.exports = {
    clientId: process.env.AUTH0_WEB_CLIENT_ID,
    domain: process.env.AUTH0_DOMAIN,
    webUrl: process.env.TMPLTZ_DOMAIN,
    callbackUrl: process.env.TMPLTZ_CALLBACK ?? 'https://localhost:4200/callback'
  }