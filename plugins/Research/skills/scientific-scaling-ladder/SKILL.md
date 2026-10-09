---
name: scientific-scaling-ladder
description: Design or audit LLM pretraining scaling ladders for recipe prediction, compute allocation, candidate comparison, or hyperparameter transfer. Use for dense, MoE, or data-constrained experiments that extrapolate to a larger training run.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
  - Grep
  - WebFetch
  - WebSearch
  - AskUserQuestion
---

# Scientific Scaling Ladder

Turn small training experiments into a decision about a target run. This is an operational condensation of Jiaxuan Zou's [How to Build a Scientific Scaling Ladder](https://jiaxuanzou0714.github.io/blog/2026/how-to-build-scientific-scaling-ladder/) (2026-09-20, accessed 2026-10-09), with primary sources linked below. It covers pretraining; SFT/RL is an acceptance check when required by the deliverable, not a post-training scaling protocol.

## Input and scope

Accept `$ARGUMENTS` as a research question, experiment plan, or results path. Read existing artifacts first. Ask only for missing inputs that change the decision: objective, target model and stage, budget, data availability, delivery metrics, and hardware/deployment constraints. Mark unknowns rather than invent results. Produce a plan or audit within the authorized scope; planning does not authorize launching costly training.

## 1. Freeze the decision contract

Distinguish **fixed-recipe prediction** (run prescribed scaling rules) from **resource allocation, candidate comparison, or hyperparameter transfer** (require fitting points on the Fully-Tuned Frontier). Freeze evaluation data, aggregation, prompt/scoring versions, minimum meaningful difference, noise-aware thresholds, and holdout allocation before observing acceptance results. Separate proxy loss from delivery capability; floor/saturated accuracy needs a discriminating proxy and cross-scale ranking evidence.

Return **select**, **add experiments**, or **insufficient evidence**. A consumed holdout becomes development data; revised acceptance needs independent evidence. Report scope explicitly when downstream prediction is unvalidated. These gates condense the source article's §§2, 9–10.

## 2. Specify measurements and experimental axes

- Define fitting parameters separately from compute: record body parameters excluding embeddings/head, embedding/head counts, and architecture/kernel-aware training FLOPs including head and attention. Treat `6ND` as an approximation, and state the parameter convention for TPP (`D/N`).
- Record processed tokens, loss-bearing tokens `D`, globally deduplicated unique tokens `U`, and repeated exposure. Fix packing, masking, tokenizer, loss denominator, evaluation distribution, and auxiliary-loss reporting. Compare tokenizers on common raw text using byte-normalized metrics.
- Separate fixed settings, scaling rules, and searched variables. Specify width/depth, warmup, schedule, precision, and effective global batch in tokens. Fixed warmup steps can dominate small runs.

Measurement and warmup cautions are supported by [Porian et al., §§3.2–3.5 and Appendix B](https://arxiv.org/html/2406.19146v1).

Choose a grid, IsoFLOP, or sparse design together with its fitting form. Vary `N` and `D` independently when estimating both effects: fixed TPP alone cannot identify them. Cover target TPP and the intended extrapolation direction; reserve larger-scale acceptance points separately from development validation. Report target compute / maximum fitting compute and target / maximum holdout compute. Count search, seeds, evaluation, failed runs, and reserves in the budget. Use pilots to estimate noise and throughput; do not impose universal size counts or budget percentages. See [Choshen et al., §§6–8](https://arxiv.org/html/2410.11840v1).

## 3. Tune and compare fairly

For frontier decisions, jointly explore LR/BSZ at small scales, check WD/schedule, then confirm transferred values locally at larger scales. Expand a search whose optimum lies on its boundary. Record coverage and local joint perturbations; claim near-optimality only within the searched region and a tolerance no smaller than observed seed noise. Re-evaluate selected configurations with fresh seeds. See [Lourie et al., §§3–5](https://arxiv.org/html/2608.11859v1).

For multiple TPP regimes, model hyperparameters using separate `N,D` dependencies; literature coefficients are hypotheses to calibrate, not defaults. See [Step Law](https://arxiv.org/html/2503.04715v3). Tune each candidate separately, disclose search costs, and compare completed annealing endpoints at comparable budgets. Intermediate rankings may reverse; an early-stopping proxy needs validation. See [Fantastic Pretraining Optimizers](https://arxiv.org/abs/2509.02046).

## 4. Fit, diagnose, and propagate uncertainty

Compare an additive candidate `L=E+A/N^alpha+B/D^beta` with a coupled candidate `L=E+(A/N^alpha+B/D^beta)^k` when data supports it. Sparse layouts still need identifiability and independent extrapolation checks. See [Skaling](https://arxiv.org/html/2608.07222v1).

Before fitting, record loss/log-loss target, floor treatment, objective, constraints, starts/convergence, trajectory weights, checkpoint truncation, and outlier policy. Choose these on development data. Inspect residuals across `N,D`, stage, and influential runs; check sensitivity to model form and leave-one-scale-out fits. Resample independent runs or appropriate correlated groups, preserving shared prefixes and checkpoint dependence. [Delphi](https://openathena.ai/blog/delphi/) illustrates grouped bootstrap rather than treating correlated runs as independent.

Separate seed/evaluation noise, parameter confidence, future-run prediction intervals, and model-form uncertainty. For each refit, recompute target configurations and paired candidate differences, retaining covariance. Also report absolute loss gaps and equivalent compute: solve fitted curves at equal loss; the local approximation `log(C2/C1) ≈ deltaL/[gamma*(L-E)]` requires `L=E+A*C^-gamma`, a signed gap, and a valid local range. Low average residual error alone does not establish a reliable ranking or allocation.

Choose repeats for seed-dominated uncertainty, targeted larger points for divergent extrapolations, and longer representative runs for changing rankings. State which decision each added experiment could resolve.

## 5. Apply only relevant extensions

- **MoE:** record total/active body parameters, expert count/granularity, routing and load balancing. Separate scale, sparsity, and granularity axes; include dense controls and communication/memory costs.
- **Data constrained:** vary unique data and repetition, fit diminishing returns/overfitting, constrain each mixture bucket by capacity and repeat limit, and match proxy repetition to the target. See [Scaling Data-Constrained Language Models](https://arxiv.org/html/2305.16264v5).
- **Mixture or stages:** compare mixture baselines on fixed evaluation data; record checkpoint/state transitions and stage budgets. Confirm selected mixtures across scales and the complete stage combination. Long-context checks include short-context regressions and varied retrieval/reasoning tasks.

## 6. Validate and hand off

Accept holdout results against the frozen contract. Validate the final combined recipe, stability, and target implementation: controlled-batch forward/loss/gradient/update comparisons, short trajectories, accumulation/reduction, and checkpoint recovery. For large extrapolation gaps, require a budget-appropriate intermediate pilot using production hardware, parallelism, kernels, and precision, with its predicted curve frozen beforehand. Do not recommend target launch after a failed pilot with unresolved causes.

Measure wall time, throughput, memory, recovery costs, and deployment constraints separately from FLOPs. Validate combined gains rather than adding isolated improvements; [Marin's efficiency report](https://openathena.ai/blog/pretraining-speedup/) distinguishes theoretical and realized efficiency.

Use [the decision-record template](references/decision-record.md) to hand off the plan or audit under `docs/research/`. Link raw runs, scripts, coefficients, frozen forecasts, and diagnostics. Keep unique run IDs, versions, seeds, parent checkpoints, hardware/precision, and statuses (completed, stopped, algorithm failure, infrastructure failure, implementation error). On sustained forecast deviation, check measurements/configuration, then data/implementation/hardware before revising the law. Preserve unresolved causes and define revalidation triggers for recipe, data, tokenizer, precision, or infrastructure changes.
