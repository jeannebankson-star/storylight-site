# Storylight Quest website

Static pages served by GitHub Pages: a landing page, Support, Privacy Policy,
and Terms of Use for the Storylight Quest iOS app. No build step.

## Editing

Each page is a single HTML file sharing `styles.css`. Edit, commit, push;
GitHub Pages redeploys in about a minute.

## Custom domain

1. Add a `CNAME` file containing the bare domain (for example `example.com`).
2. At the registrar, keep the nameservers as they are and add:
   - `A` records for `@` → `185.199.108.153`, `185.199.109.153`,
     `185.199.110.153`, `185.199.111.153`
   - `CNAME` record for `www` → `jeannebankson-star.github.io`
3. In the repo's Settings → Pages, enter the domain and turn on Enforce HTTPS
   once the certificate is issued.

Email forwarding at the registrar is unaffected as long as the nameservers
stay put and the `MX` records are left alone.
