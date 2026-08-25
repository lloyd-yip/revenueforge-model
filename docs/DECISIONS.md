# RevenueForge — Decision Log

**Why the model's parameters are what they are. Conclusions live in the model; arguments live here.**

Live model: https://lloyd-yip.github.io/revenueforge-model/ — the tabs hold *what* was decided.
This file holds *why*, what was rejected, and what would overturn it.

Written 2026-08-23 from a working session. Specific numbers are preserved verbatim.
Connections that were inferred rather than stated are marked `[inferred]`.

**Stranded document:** an earlier brief lives at
`vast-sunspot/revenueforge/project-control/unit_economics_model_BRIEF.md` — inside the
dissolving, locked monorepo, and as of this writing 8 commits unpushed to `monorepo-backup`.
Pending rehoming; not migrated here because that is a gated migration, not a side effect.

---

## 1. The model runs backwards, not forwards

**Decided:** `capacity → starts → closes → audits → invites`. Delivery hours decide how many
clients can start; that decides how many deals may be closed; that decides how many audits are
needed; that decides invite volume.

**Why.** The model originally ran forwards — run audits at calendar capacity, close what closes,
start what fits, queue the rest. At the conservative preset that produced **65 deals closed and 23
clients started in year one**, with a backlog peaking at **25 sold-but-unstarted clients** by M12.
Lloyd's rule: *you start everything you close, therefore you only close what you can start,
therefore you only run the audits those closes require.*

**Consequence:** there is no queue. `closes === starts` on every row, verified across all three
presets. Month one went from *21.6 audits / 5 closed / 1 started* to *4 audits / 1 closed /
1 started*.

**Rejected:** a queue-depth throttle (pause selling when the backlog exceeds N months). Built as a
mockup, then discarded — it reduced the queue rather than eliminating it, and it did not touch
month one at all, because the queue starts empty.

---

## 2. Hours are not attention

**Decided:** a cap on **concurrent builds in flight**, separate from hours. Default 2 for the
founding pair, +3 per delivery hire.

**Why.** The model spread 85 delivery hours over 3 months (28.3/month), so 160 monthly hours
"allowed" 5.65 simultaneous onboardings — and the model duly started 5 clients in one month for a
two-person team. Nothing was arithmetically wrong. The missing constraint was that two people
cannot run five kickoffs, discoveries and architectures at once.

**Cost of the correction:** year-one clients fell 23 → 10, cash $666k → ~$300k.

**The slots-per-hire number is load-bearing.** A delivery hire adds 77 effective hours; a build at
the efficiency floor costs 11.3 hrs/month, so on hours alone they could carry ~6.8 concurrent
builds. It was initially set to 1. At 1 the model needed **13 delivery people** to reach 7
starts/month; at 3 it needs **5** — identical revenue, **$64k/month** difference in payroll.

---

## 3. Efficiency is only a growth story if it shortens the build

**Decided:** an explicit lever for how much of an efficiency gain also compresses build *duration*,
not just hours. Defaulted to 50%.

**Why.** Once a concurrency cap binds, cutting hours-per-build produces **zero** extra throughput —
a slot stays occupied for the full spread whether the build costs 85 hours or 34. Throughput is
work-in-flight ÷ cycle time, and reducing hours-per-unit moves neither term. Measured: a 2.5×
efficiency improvement left year-one starts flat at 8.

**The lever's range swung year-two clients from 22 to 54.** Its honest setting is partial, because
the part that will not compress is the same human-contact residue that sets the efficiency floor:
client availability, data access, approvals.

---

## 4. The binding constraint switches, and each hire flips it

**Observed, not designed.** With architects capped at 2:

```
M1–M15    delivery-short   → throttle the funnel, get better instead
M14,16,19 +delivery ×3
M16       first flip       → delivery room the calendar cannot fill
M21       +ARCHITECT
M23       +delivery
M25       +ARCHITECT
M28       +delivery
```

Fifteen months of holding the funnel back before the first flip. The hiring sequence emerges from
the constraint alternating rather than from a schedule.

**Hiring triggers were re-keyed off the queue onto the binding constraint:** hours or in-flight →
hire delivery; calendar → hire sales; **invites → hire nobody**, because more salespeople cannot fix
a lead shortage. Before that fix, the model hired architects 4 → 20 while invite-bound, ~$100k/month
buying nothing.

---

## 5. Pricing: the initial sale is prescribed

**Decided:** one prescribed package — Pipeline Engine, Wingman, SalesPulse, Revenue Dashboard — at
one price. No line items shown, no component selection.

**Why.** Every individual component is commoditised; the assembled system is not, because nobody
sells it assembled. The moment "Automated SDR — $7k/mo" appears on a page, the buyer puts it next to
a $97/month tool. A menu also invites the client to talk themselves out of the pieces that make the
whole thing work.

**Line-item prices exist internally only** — surfaced in exactly one situation: an upsell, for the
single item being added.

**Corollary [inferred]:** this is *easier* to hand to an AI Revenue Architect later than an à la
carte configurator, so the choice made for convenience now also serves the hire.

---

## 6. $20k upfront is a floor, not a variable

**Decided:** minimum **total** upfront ~$20k. Not per item, not per item-count.

**Why the recurring/upfront tradeoff was analysed and then abandoned.** Holding contract value
constant and shifting from `$20k + $3k/mo` to `$8k + $4k/mo` raised recurring share 59% → 81% and
moved the business from the 7–10× band to 10–14× — roughly **$22m of exit value for $3k per client**.

**That framing was wrong.** The upfront is a largely fixed onboarding cost; the monthly scales with
what the client takes. So **item count repairs the revenue mix without touching the upfront**:

| Items | Monthly | Year-1 | Recurring share | Band |
|---|---|---|---|---|
| 2 | $3k | $47k | 59% | 7–10× |
| **4** | $6k | $74k | **74%** | **10–14×** |
| 6 | $9k | $101k | 81% | 10–14× |

**The minimum commit is therefore a valuation decision disguised as a sales policy.**

**Disqualification rule that falls out of it:** a client who can only *just* reach the minimum is
telling you either that they cannot identify enough use cases they want, or that they cannot afford
it. Both are reasons to decline. This replaced an earlier concern about the minimum being a "cliff
that gets gamed" — clients near the cliff are clients you do not want.

---

## 7. The recurring is never discounted

**Decided:** discounts come out of the **upfront only**, hard-capped in advance.

**Why.** The upfront has a genuine cost economy — discovery, integrations, credentials and training
are shared across items, so item four really does cost less to set up than item one. **The recurring
has no such economy**: six running workflows cost roughly six times as much to monitor and maintain
as one. Discounting it gives away margin with no cost basis *and* damages the metric that sets the
exit multiple.

**Order of negotiation levers:** (1) extend payment terms on the upfront, (2) discount the upfront
against a longer commitment, (3) only then remove a system — cutting both its upfront and its
monthly. Removing scope is last because it means a worse result, a weaker case study, and less
reason to stay.

**Rejected:** "we'll freeze your price for three years if you commit for three." At a 5% uplift cap
the freeze is worth ~15% over three years — not enough for anyone to trade contract length for.

---

## 8. Value sets the price; complexity sets the floor

**Decided:** complexity decides *whether* an item goes on the menu. It does not decide what the item
costs.

**Why.** Cost-plus pricing is an agency billing hours in disguise, and it produces a perverse result:
**your most expensive items become the ones you are worst at building**. As a build drops from 85
hours to 34, cost-plus says charge less for the same outcome.

**Method for pricing an item:** estimate annual value to the client → price the annual contract at
10–20% of it → split between upfront and monthly → sanity-check against the delivery-cost floor.
**Revenue-generating items price far higher than time-saving ones**, which argues for weighting the
menu toward the former.

---

## 9. Launch pricing is deliberately below target

**Decided:** launch at **$20k + $3–4k/month**; target once proven ~**$22k + $7.5k/month**.

**Why the target monthly is that number, not a round one:** $7.5k is the level that holds recurring
share above 75% at a $22k upfront, which is the boundary between the 7–10× and 10–14× bands.

**Why launch below it:** price elasticity is unknown at zero clients, and erring toward letting more
people in buys learning that no amount of modelling will.

**Founding cohort:** capped at **ten clients or six months, whichever comes first**, with the future
price written into the original contract — not merely a statement that pricing may change.

**The failure mode is not the low price. It is never raising it.** By month seven those ten clients
are friends and case studies, and a vague clause is one nobody has the stomach to exercise. A number
already on paper converts an uncomfortable negotiation into a reminder of something agreed. Capping
by count as well as time matters because a six-month window fails precisely when things go well.

---

## 10. Persona: $5–15m sweet spot, ~$25m hard stop

**Decided:** floor $2.5m, sweet spot $5–15m, stretch to $25m, hard stop there.

**The ceiling driver specific to this business:** past ~$25m the sales cycle lengthens to 3+ months.
The whole engine assumes audits convert within the month — **a long cycle means audits sitting in a
pipeline for a quarter, which is precisely the queue this model was rebuilt to eliminate.** That is
a harder constraint than procurement friction.

**Other ceiling drivers:** they can justify one or two engineers on internal tooling (~$25–35m);
procurement and legal appear ($25–50m); the CRM stops being templatable.

**Better qualifiers than revenue:** sales team size (3–20 reps), CRM maturity (standard vs 5+ years
of custom config), who decides (one person vs committee).

**`[inferred, untested]` An existing RevOps *function* is a disqualifier, not a green flag.** They
will want to build it themselves, will have opinions about how, and you partly threaten their remit.
The ideal buyer has the pain and nobody who owns it.

**Frame that works:** labour replacement, not percentage lift. The stack covers $250–430k/yr of
function (SDR $60–150k, sales ops $50–70k, enablement $80–120k, reporting $60–90k) — $89k against
that is 3–5× and needs no faith in a percentage. **The lift frame under-prices at every size below
$10m**: a $5m business growing 30% generates $1.5m of new revenue; a 10% lift is $150k; at 10–20% of
value that only justifies $15–30k.

---

## 11. Exit: recurring share decides the band

**The largest single finding.** Retention does not just increase revenue — it changes what kind of
business you are:

| Retention | Revenue | Recurring share | Reads as | Band |
|---|---|---|---|---|
| 6 months | $8.6m | **32%** | project business with a subscription | 4–6× |
| 12 months | $14.1m | 59% | hybrid | 7–10× |
| 24 months | $25.0m | **77%** | recurring-revenue business | 10–14× |

Roughly **$17–26m at six months versus $125–175m at twenty-four** — not a 3× difference in outcome,
closer to 7–10×, because retention moves both the profit and the multiple applied to it.

**The plateau trap.** The model terminates by flattening — the last six months of the arc are
identical. Acquirers buy forward growth. The same business, same margin, is worth 5–7× flat and
10–14× still climbing. On $7m EBITDA that is **$42m vs $84m**, which reframes the second acquisition
channel as a valuation decision rather than a marketing project.

**Scale threshold:** below roughly $3m EBITDA, double-digit multiples are not available regardless of
quality — too small for the buyers who pay them.

**The model's `net` is not EBITDA.** It counts hire salaries only — no founder comp, no ad spend, no
tooling, no admin, legal or insurance. Realistic EBITDA is ~45–55% of revenue. Using the model's net
overstates the business by roughly a third.

**Comparable set is MSPs, not SaaS and not agencies.** Nine structural characteristics match
(upfront then recurring, high ticket, sticky, low starting capital, headcount scaling,
provider-operated, SMB/mid-market, fragmented competition). MSPs traded at 8–14× through the
2018–2024 rollup wave. **RevenueForge has their economics without their two structural handicaps —
geography and distribution** — which are exactly what kept that industry fragmented and made it a
rollup target. What it lacks is their defensiveness: IT is recession-resistant spend, growth
infrastructure is not.

---

## 12. Corrections made during the session

Recorded because they are the parts most likely to be re-litigated.

- **The SaaS comparison was the wrong template.** Enterprise SaaS spends 20–30% of revenue on R&D
  and 40–60% on S&M permanently; most run 0–15% EBITDA at scale. RevenueForge's modelled revenue per
  employee is **$594–614k** against an enterprise-SaaS median of $150–250k. Both of its equivalent
  lines are near zero — no R&D line, and the $897 audit liquidates acquisition at the point of sale.
- **Item count, not a lower upfront**, fixes the revenue mix (§6).
- **The minimum is not a cliff to engineer around** — clients near it are disqualified (§6).
- **The three-year price freeze is worthless at a 5% cap** (§7).
- **Adoption is deliberately not modelled.** Too situational to put a slider on; false precision
  would be worse than an honest gap. It is handled in ownership and in the delivery→client-success
  handoff instead.

---

## 13. Unresolved

- **The day-one menu does not exist.** Every pricing question is downstream of it.
- **The AI Revenue Architect's close rate** — the model assumes 90% of Lloyd's. At 50% the arc
  terminates at $5.7m/yr; at 90% it reaches $8.6m. This is the only failure mode raised in the
  session that survived argument, and it cannot be reasoned away — only observed. Strongest argument
  for hiring the first architect *earlier than the model triggers it*, purely to learn the answer
  while being wrong is still cheap.
- **Whether an anchor item is required.** Without one, the cheapest combination clearing $20k is the
  rational client choice, and the book drifts toward low-value, low-stickiness items.
- **Whether recurring starts at signing or go-live.** Currently go-live, gifting ~3 months of fees —
  worth $9–21k of lifetime value per client.
- **Retention has a price but not yet a mechanism.** The hosted-dependency argument is strong, but
  lock-in and loyalty look identical on a churn report. The test: at month six, ask the first clients
  what they would do if a competitor offered to rebuild and migrate them free. **Their hesitation is
  the real number.**

---

## 14. The three tests that settle most of the above

1. Do 10 audits convert above 20% into a build? — proves price and demand.
2. At month six, are the first three clients still using it, and can they say why they pay? —
   proves retention has a mechanism.
3. Does build #5 take materially fewer hours than build #1? — proves the repeatability thesis.
