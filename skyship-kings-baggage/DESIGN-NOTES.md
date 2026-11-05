# The King's Baggage — design notes

Galleon-rigged aerial raider: a displacement-hulled skyship whose gasbag is
cargo, not a blimp. Built under Cayley's rule from *On Aerial Navigation*
(1809–10) — support must be lighter than what it lifts — with the 70/30
rule reading the result: the hull should dominate the silhouette; the bag
is her belly of lifted freight.

## Geometry facts

- Hull sections run x −9.0 to +8.7; waist width 2.14, keel depth −2.55,
  bulwark top +0.27.
- Envelope: spline whale, length 12.3, crest 2.65, dorsal ridge on top.
- **BELLY_DRAFT = 0.62** — one constant squashes everything below the
  waterline (envelope skin, nine whale ribs, transverse seams, vertical
  ribs, all three mast rings), so the bag rides *on* the deck like lashed
  cargo instead of swallowing the hull from below. Belly squash landed
  revs 13–19; envelope offset −1.42 → −0.35.
- Below-camera at boot: `#az=&el=&dist=` in the URL. Negative elevation
  flips the camera under the hull (phi > π/2); el −25° means "under the
  bows," tempered ×0.9 so it never drifts to pure nadir looking up the
  sternpipe. Rev 20.

## Verified views

- Spawn boot: rigging web, lantern row, stern prop, checkered rudder all present.
- Beam profile (el 5°): hull reads as the base mass, bag above it — 70/30 target met.
- Keel view (el −25°): underside reads ship, bag belly clamped at deck level.
- Strake tilt at el 5°: tracks hull banding level, no sag — boot 10.
- Fins/rudder: closed via spawn boot detail pass.

## Check ledger — closed 2026-11-05

- Ring clearance (mast rings vs rigging-tip at full squashed
  geometry): **verified on screen** — keel view, boot 9. Belly clamped
  at deck level; no ring intersects hull bulwark line.
- Strake tilt (squashed belly panels): **verified on screen** — beam
  view, boot 10. Strakes track hull banding level; no sag past
  tolerance.
- Fins/rudder detail pass from directly astern: **closed** — stern
  prop and checkered rudder already confirmed in the spawn boot.
  Detail pass stands.

## Files

- `index.html` — the ship.
- `look.html` — angle picker (named vantages: bows / stern / bagtop /
  below / beam, or raw `az,el[,dist]`), falls back from query string to hash.
- `probe-below.html`, `probe-beam.html` — single-purpose repro pages for
  the two checks above.
