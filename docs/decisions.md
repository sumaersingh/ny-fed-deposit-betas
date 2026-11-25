# Decisions

Every judgment call that can change a result, with the reason for it. One entry per decision, newest at the bottom.

Template:

```
## D<n>. <short title>

- Date:
- Question:
- Options considered:
- Choice:
- Reason:
- Effect on results (if checked):
```

---

## D1. Base quarters for the hiking cycles

- Date: 2026-11-25
- Question: which quarter is the "before" point that each cycle's cumulative beta is measured from?
- Options considered: (a) the last quarter before the first hike: 2004:Q2, 2015:Q3, 2021:Q4. (b) The quarter of the first hike: 2004:Q2, 2015:Q4, 2022:Q1.
- Choice: (a) 2004:Q2, 2015:Q3, 2021:Q4.
- Reason: it reproduces the NY Fed's stated cycle starts. Their cycles begin in 2004:Q3 and 2015:Q4, and the current one begins "after 2021:Q4". The first 2004 hike was on June 30, the last day of Q2, so it barely moves the Q2 average and 2004:Q2 still works as a base.
- Effect on results: to be checked in Wave 6, which reruns the betas with option (b). Base Fed funds changes by 2 bp (2015) and 4 bp (2022).

## D2. When a cycle ends

- Date: 2026-11-25
- Question: what is the last quarter of each cycle?
- Options considered: (a) the last quarter before the first move in the other direction. (b) The quarter of the last hike.
- Choice: (a). Cycles end 2007:Q2, 2019:Q2 and 2024:Q2.
- Reason: it reproduces the NY Fed's stated end dates of 2007:Q2 and 2019:Q2. The beta at the last hike of the 2022 cycle (2023:Q3) is reported separately in the extension.
- Effect on results: none on the 2022:Q4 benchmark. It sets how far the 2022 cycle line runs in the figures.

## D4. Fed funds series

- Date: 2026-11-25
- Question: which FRED series is averaged to quarters?
- Options considered: (a) DFF, the daily effective rate, averaged over every day in the quarter. (b) FEDFUNDS, the monthly average, averaged over the three months.
- Choice: (a) DFF.
- Reason: it is exactly the NY Fed's stated measure, the quarterly average of the daily effective rate. FEDFUNDS gives each month equal weight whatever its number of days. FEDFUNDS is still downloaded so Wave 6 can report the largest gap between the two.
- Effect on results: a few bp at most, in quarters with a rate move part way through.

## D14. What counts as a match

- Date: 2026-11-25
- Question: how close to the NY Fed's numbers counts as a successful replication?
- Options considered: (a) a beta within 3 percentage points, and a level inside the rounding band of the published number. (b) The same with 5 points. (c) No threshold, only report and explain gaps.
- Choice: (a).
- Reason: it is the threshold in the project brief. The rounding rule is the honest test for numbers published as "1.4%" or "3.7%". For example, 1.4% means our value must be between 1.35% and 1.45%.
- Effect on results: none. It decides which gaps need a divergence log entry.
