---
name: pre-refactor-analyze
description: 迁移或大规模重构前，按四层递进的静态+语义分析产出可机器消费的 JSON 与简短摘要（BLIR → 业务推理 → v1/v2 语义差分 → 模式/反模式）。适用于框架升级、模块拆分、遗留改造、分支对比、Breaking change 审计、以及需要论证业务等价而不仅是文本 diff 的场景。 Triggers：迁移前分析、重构预分析、语义 diff、BLIR、legacy refactor、migration audit、behavior parity、v1 vs v2、迁移评审、breaking change。
allowed-tools:
  - Read
  - Grep
  - Glob
  - SemanticSearch
  - Bash
  - Task
preconditions:
  - 可分析的范围（路径、模块名或文件列表）；对比模式下能定位 v1 与 v2（分支、目录、tag 或由用户粘贴快照）
---

# Pre-Refactor Analyze

**定位：** 分析模式默认 **只读**；除非用户明确要求进入实现，不修改业务代码。

**渐进加载：** 每一层的完整指令、任务拆解与 JSON 字段约定只在对应的 `reference/step*.md` 里展开。进入该层时 **Read 该文件全文一次**，再执行；不要凭记忆补字段。

## 分层索引

| 层 | 产物（建议文件名） | 参考 |
|----|-------------------|------|
| 1 | `layer1/blir/*.json` 或 `layer1/blir.json` | [reference/step1.md](reference/step1.md) |
| 2 | `layer2/reasoning_<version>.json` | [reference/step2.md](reference/step2.md) |
| 3 | `layer3/delta.json`（仅对比模式） | [reference/step3.md](reference/step3.md) |
| 4 | `layer4/patterns.json` | [reference/step4.md](reference/step4.md) |
| — | 可选静态工具速查 | [reference/tooling-hints.md](reference/tooling-hints.md) |

## 路由：选一种模式再执行

**A. 单版本（无 v2）**  
跑 Layer 1 → Layer 2 → Layer 4。Layer 4 时按 `reference/step4.md` 的「单版本」说明，仅基于一份 Layer 2。

**B. 对比迁移（有 v1 与 v2）**  
跑 Layer 1（对两边各自一份 BLIR）→ Layer 2（`reasoning_v1` 与 `reasoning_v2`）→ Layer 3 → Layer 4。

**C. 仅粗粒度入口**  
若用户只给主题、未给路径：先用 Glob / Grep 与用户确认范围，再进入 A 或 B。

## 执行协议

1. **固定输出根目录**  
   默认 `docs/refactor-analysis/YYYY-MM-DD-<slug>/`（`slug` 用小写短横线；用户指定则用用户路径）。其下按上表划分子目录。

2. **Layer 1**  
   Read `reference/step1.md`。对约定范围内的每个分析单元（优先「文件」；过大时可按「目录/模块」聚合，但在 `SUMMARY.md` 说明粒度）生成 BLIR JSON，写入 `layer1/`。

3. **Layer 2**  
   Read `reference/step2.md`。以 Layer 1 结果为唯一结构化上下文，生成业务推理 JSON；对比模式下 v1、v2 各输出一份。

4. **Layer 3（可选）**  
   仅 B 模式：Read `reference/step3.md`，输入两份 Layer 2 JSON，输出 `layer3/delta.json`。

5. **Layer 4**  
   Read `reference/step4.md`。对比模式带入 Layer 3 + 双份 Layer 2；单版本模式按该文件「单版本」条款仅带一份 Layer 2。

6. **收口**  
   在同目录写 `SUMMARY.md`（≤ 80 行）：目标、范围、各层产物路径、P0 风险三条以内、未验证假设、建议的下一步（契约测试 / 双跑 / 监控项）。可选：生成 `layer5/test_matrix.json` 与 `layer5/risk_matrix.json`（结构自定，在 `SUMMARY.md` 一笔带过即可）。

## 并行与大仓库

- 用 **Task** 对 Layer 1 或「多文件 BLIR」分片；合并时统一 `file_path` / 模块键命名，并在 `SUMMARY.md` 说明分片策略。
- 若某文件无法解析，在 BLIR 或 `SUMMARY.md` 中记录原因，禁止静默跳过。

## 约束

- 断言「行为一致」须对应 Layer 3 条目或可执行的验证建议，避免空泛结论。
- Layer 2 质量差则不要强行写满 Layer 3/4：在 `SUMMARY.md` 标明「需补足 Layer 1 覆盖或人工确认」。
- 不替用户执行 git push、不擅自改远程；不写密钥与内网地址到产物。
