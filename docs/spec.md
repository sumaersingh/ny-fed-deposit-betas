# Spec: replicating the NY Fed's cumulative deposit betas

This spec sets out what I am replicating and how, before any code is written. Each judgment call it mentions is recorded with its reason in `docs/decisions.md`.

## 1. The question

When the Fed raises its policy rate, how much of the increase do banks pass on to depositors, and how fast? The NY Fed answered this for the US banking industry in two Liberty Street Economics posts:

- Kang-Landsberg and Plosser, "How Do Deposit Rates Respond to Monetary Policy?", November 21, 2022.
- Kang-Landsberg, Luck and Plosser, "Deposit Betas: Up, Up, and Away?", April 11, 2023.

I rebuild their main result from raw regulatory data, then extend it past 2022:Q4. That covers the end of the 2022 hiking cycle and the easing cycle that started in September 2024.

## 2. The measure

A deposit beta is the share of a change in the Fed funds rate that shows up in the deposit rate. A beta of 0.4 means that for every 1 point rise in Fed funds, the deposit rate rose 0.4 points.

The cumulative beta measures this over a whole cycle, from a fixed base quarter b:

```
cum_beta[t] = (dep_rate[t] - dep_rate[b]) / (ff[t] - ff[b])
```

- `dep_rate[t]` is the industry deposit rate in quarter t, in percent per year.
- `ff[t]` is the average effective Fed funds rate in quarter t, in percent.
- `b` is the last quarter before the cycle's first rate move.

Why cumulative, and not one beta per rate move: banks reprice deposits with a lag, and a single move can be followed by little change for several quarters. Measuring everything from the start of the cycle shows how much of the total rate rise has reached depositors so far. That makes cycles of different speed and size comparable.

## 3. Data

| | NY Fed | This project |
| --- | --- | --- |
| Bank data | FR Y-9C, summed across all bank holding companies | FFIEC Call Reports, summed across all filing banks |
| Fed funds | H.15 effective rate, quarterly average of daily values | FRED series DFF (the same H.15 daily rate), averaged over every day in the quarter |
| Period | 1994 to 2022:Q4 | 2001:Q1 to the latest quarter |

Call Reports and the Y-9C are not the same sample. The Y-9C covers holding companies only, includes their nonbank subsidiaries, and leaves out small holding companies below a reporting threshold. Call Reports cover every insured bank, and from 2012:Q1 also the former thrifts. I expect close but not identical numbers. Every gap is explained in `docs/divergence_log.md`.

FFIEC bulk data starts in 2001, so I cannot rebuild the NY Fed's 1994 cycle.

## 4. The deposit rate

**Numerator: interest expense on deposits**, from Schedule RI. It is the sum of interest on transaction accounts, on savings deposits including money market deposit accounts, on time deposits, and on deposits in foreign offices. Schedule RI is reported year-to-date, so I convert it to quarterly flows. Q1 is used as reported. Q2 to Q4 are this quarter's year-to-date value minus last quarter's.

**Denominator: average interest-bearing deposits**, from Schedule RC-K. These are already quarterly averages, so they are used as reported. An average balance matches the expense better than a quarter-end balance. The expense builds up over the whole quarter, and a quarter-end balance can be distorted by flows on the last day.

**Rate:** 4 times quarterly expense, divided by average interest-bearing deposits, summed across banks before dividing. This is a deposit-weighted industry rate.

**Main measure:** the interest-bearing deposit rate, as in the NY Fed's headline numbers. **Second measure:** the rate on total deposits, including noninterest-bearing deposits. Neither the Call Report nor the Y-9C reports an average balance for noninterest-bearing deposits, so the denominator for this measure is a decision logged in `docs/decisions.md`.

**2017 code change.** In 2017:Q1 the time deposit items switched from a $100,000 size split to a $250,000 split, with new codes. I add the two size buckets together before and after the switch, so the total is continuous. I check that the series does not jump at the switch. Every code is listed in `docs/data_dictionary.md`.

## 5. Cycles and base quarters

| Cycle | Base quarter | First quarter | Last quarter |
| --- | --- | --- | --- |
| 2004 hiking | 2004:Q2 | 2004:Q3 | 2007:Q2 |
| 2015 hiking | 2015:Q3 | 2015:Q4 | 2019:Q2 |
| 2022 hiking | 2021:Q4 | 2022:Q1 | 2024:Q2 |
| 2024 easing (extension) | 2024:Q2 | 2024:Q3 | to be decided |

The base is the last quarter before the first rate move. This reproduces the NY Fed's stated cycle dates. Their 2004 and 2015 cycles start in 2004:Q3 and 2015:Q4, and they say the current cycle starts after 2021:Q4. A cycle ends in the last quarter before the first move in the other direction, which matches their end dates of 2007:Q2 and 2019:Q2.

The first hike of 2004 was on June 30, the last day of Q2, so it barely moves the Q2 average. That is why 2004:Q2 still works as a base.

## 6. Benchmarks

| Benchmark | NY Fed value | Source |
| --- | --- | --- |
| Average Fed funds, 2022:Q4 | 3.7% | April 2023 post |
| Interest-bearing deposit rate, 2022:Q4 | 1.4% | April 2023 post |
| Cumulative interest-bearing beta, 2022:Q4 | almost 0.4 | April 2023 post |
| Peak cumulative beta, 2004 cycle | approaching 60% | November 2022 post |
| Peak cumulative beta, 2015 to 2019 cycle | never above 40% | November 2022 post |
| Size of the deposit market | about $18 trillion | November 2022 post |

A good result is a cumulative beta within about 3 percentage points of theirs. Level benchmarks should fall inside the rounding of the published number, for example 1.35% to 1.45% for "1.4%".

## 7. Extension

1. Finish the 2022 hiking cycle. Report the cumulative beta at the last hike (July 2023, so 2023:Q3), at its peak, and at the end of the cycle.
2. Compute the easing beta from base 2024:Q2: the cumulative fall in the deposit rate divided by the cumulative fall in Fed funds. Compare it with the hiking beta at the same number of quarters into each cycle.

This part is descriptive only. It says how fast rates moved, not why.

## 8. Out of scope

- The 1994 cycle (no FFIEC bulk data before 2001).
- Betas by bank size or by deposit type.
- Bank-level betas in the style of Drechsler, Savov and Schnabl (2021). That is a later, separate project.
