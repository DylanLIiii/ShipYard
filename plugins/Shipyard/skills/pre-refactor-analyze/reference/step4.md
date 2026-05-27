# Layer 4 — 模式、架构与反模式

**何时加载：** Layer 2 完成；对比模式还需 Layer 3（若有）。

**上游输入：**

- **对比模式：** `reasoning_v1.json`、`reasoning_v2.json`、以及 `delta.json`（`reference/step3.md`）。
- **单版本模式：** 仅 `reasoning` JSON（一份）。此时 **禁止** 杜撰「v1→v2 趋势」：只描述当前版本可见的模式与风险，将 `migration` 类字段填 `n/a` 或留空数组并在 `context_note` 说明。

---

## 角色与目标

扮演 **架构演进分析者**：归纳设计/架构模式、反模式、可复用抽象；对比模式额外总结演进驱动力与并发/抽象走向。

## 必做清单

1. **设计模式** — 创建型/结构型/行为型；标注显式 vs 隐式、对比模式下是否被替换、是否合理。
2. **架构模式** — 分层、六边形、CQRS、事件溯源、Actor、管道/数据流等；**紧扣证据**，无证据则标 `unknown`。
3. **反模式与坏味道** — 上帝对象、贫血模型、循环依赖、重复、过早抽象、隐式上下文等。
4. **可复用抽象** — 库边界、契约、可配置规则、统一错误与观测。
5. **演进趋势（仅对比模式）** — 还债 vs 业务驱动、并发与抽象走向；单版本填 `context_note` 即可。

## 输出契约

```json
{
  "schema_version": "patterns-1",
  "context_note": "single_version|migration_pair",
  "design_patterns": [
    {
      "pattern": "",
      "location": { "v1": "", "v2": "" },
      "implementation": "explicit|implicit",
      "migration": "preserved|replaced|introduced|n/a",
      "assessment": "appropriate|over_engineered|missing|unknown"
    }
  ],
  "architectural_patterns": [
    {
      "pattern": "",
      "adherence": "strict|leaky|violated|unknown",
      "observations": []
    }
  ],
  "anti_patterns": [
    {
      "pattern": "",
      "location": "",
      "severity": "critical|warning",
      "refactoring_suggestion": ""
    }
  ],
  "reusable_abstractions": [
    {
      "type": "library|interface|config_engine|observability|other",
      "description": "",
      "benefit": ""
    }
  ],
  "evolution_trend": {
    "primary_driver": "debt_repayment|business_driven|performance|scalability|unknown",
    "concurrency_direction": "sync_to_async|async_to_reactive|unchanged|unknown",
    "abstraction_direction": "concrete_to_generic|unchanged|unknown"
  }
}
```

单版本模式下：`design_patterns[].location` 可仅填 `"v1"` 键或把同一路径写入 `v1` 与 `v2` 相同；`evolution_trend` 各域优先 `unknown`。

## 质量闸

模式名称必须能指回具体模块/文件（`location`）；禁止纯泛化清单。
