# RevenueForge — Unit Economics & Capacity Model

Interactive model of RevenueForge's delivery capacity and unit economics.
**Phase 1: Lloyd + Geri, no hires.**

**Live:** https://lloyd-yip.github.io/revenueforge-model/

## What it does

Runs in causal order — **capacity → target → funnel**. Delivery capacity is the
binding constraint, so the model works backwards from what can actually be
delivered to the invite volume required to feed it.

- **Capacity is not constant.** Available hours are fixed; what improves is *hours per
  client*. Efficiency slides from 100% to a floor over a set number of months.
- **The efficiency floor is the human-contact residue.** Technical work compresses ~3.5×;
  meetings, training and check-ins barely compress at all. Breaking below the floor needs a
  change of delivery format, not better code.
- **Clients are discrete.** You cannot start 0.6 of an onboarding, and spare hours cannot be
  banked — leftover fractional capacity in a month is lost.
- **Acquisition is throttled by queue depth**, not free hours. At equilibrium free hours sit
  near zero, so a free-hours trigger would switch selling off permanently.

## Using it

Every lever has a `?` with a plain-English explanation. All three charts are hoverable.

State is saved automatically to `localStorage` **and** encoded in the URL hash — so you can
bookmark a scenario or share a link that opens with your exact assumptions. **Reset**
discards saved state.

## Caveats

Everything downstream of the paid-audit gate is an estimate. Only the funnel benchmarks are
observed data. Expansion revenue is off and retention sits at a deliberate floor, so the
model understates the business by design.

Single self-contained HTML file. No build step, no dependencies.
