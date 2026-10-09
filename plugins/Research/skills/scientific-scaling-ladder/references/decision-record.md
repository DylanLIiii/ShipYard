# Scaling Ladder Decision Record

Use as a compact handoff template. Fill only relevant fields; mark missing evidence and assumptions explicitly. Suggested destination: `docs/research/YYYY-MM-DD-<topic>-ladder.md`.

## Decision contract

- Objective and target model/stage:
- Fixed recipe or tuned frontier:
- Budget, hardware, deadline, deployment constraints:
- Proxy and delivery metrics; evaluation versions:
- Minimum meaningful difference; acceptance thresholds and noise basis:
- Frozen forecast/contract location and timestamp:

## Experiment plan or inventory

| Run/group ID | Recipe/version | N convention | D / U / repeats | FLOPs / wall time | LR / batch / WD / schedule | Seeds / parent | Fit, development, or holdout | Status |
|---|---|---|---|---|---|---|---|---|

Record fixed settings, scaling rules, tuning coverage, shared prefixes, extrapolation ranges, and total budget accounting next to the table.

## Evidence and decision

| Candidate / N,D | Target metric | Difference and interval | Equivalent compute | Constraints | Validation scope | Select / add experiments / insufficient evidence |
|---|---|---|---|---|---|---|

- Fit script/coefficients and data versions:
- Residual, sensitivity, dependence, and uncertainty diagnostics:
- Holdout results and whether any were consumed for development:
- Combination, stability, implementation, and pilot evidence:
- Missing evidence; next experiment, cost, and uncertainty it resolves:
- Monitoring window, failure response, and revalidation triggers:

Link the original methodology and distinguish measured, fitted, extrapolated, and assumed values. A decision record is not an authorization to execute training.
