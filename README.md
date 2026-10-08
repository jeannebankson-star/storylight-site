# Storylight Quest website

Static pages served by GitHub Pages: a landing page, Support, Privacy Policy,
and Terms of Use for the Storylight Quest iOS app. No build step.

## Editing

Each page is a single HTML file sharing `styles.css`. Edit, commit, push;
GitHub Pages redeploys in about a minute.

## Design and assets

The website follows the app's Sunday Storybook UI: paper `#F6FAFB`, warm
surfaces `#FFFEFA`, teal `#246B63`, mint `#DFF1EA`, peach `#FFF0E1` and small
sunflower, coral and lilac accents. Montserrat is served locally with its
SIL Open Font License. There are no JavaScript dependencies or analytics.

The landing page uses actual app screenshots and the original ornate cards.
Card faces and backs retain the app's 5:7 format. See
[assets/README.md](assets/README.md) for source paths and regeneration.

Preview locally with `python3 -m http.server 8874 --bind 127.0.0.1`.
Before publishing, check desktop, tablet and narrow phone layouts, journey
and help disclosures, local links and image loading. Keep the free sampler
copy synchronized with the app: five stories in In the Beginning and five
in Miracles and Parables, with the remaining 90 in the current Full Quest.

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
