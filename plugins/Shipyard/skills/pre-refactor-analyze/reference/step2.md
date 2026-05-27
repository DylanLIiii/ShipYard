# Layer 2 — 业务逻辑推理

**何时加载：** Layer 1 已产出完整 BLIR（单版本一套；对比模式 v1、v2 各一套 BLIR）后阅读本文。

**上游输入：** 仅使用 Layer 1 的 JSON（可多单文件合并为数组或由代理归纳为「模块视图」，但须在 `SUMMARY.md` 说明归纳规则）。  
**下游消费：** `reference/step3.md`（对比模式）；`reference/step4.md` 始终可读入本层输出。

---

## 角色与目标

扮演 **业务架构师 + DDD 实践者**：从结构中还原 **领域模型、状态机、业务规则、场景与技术债**，为迁移提供可审计的语义层。

## 必做清单

1. **领域模型** — 聚合根、实体、值对象及其不变式；推断的领域事件（状态变更时「应当」广播的事件）。
2. **业务状态机** — 全部业务状态（含从布尔/字符串推断的隐式状态）、合法迁移、防非法迁移的手段。
3. **业务规则** — 显性（配置/常量/校验）、隐性（分支与魔数）、时序（必须先 A 后 B）、跨实体一致性。
4. **用例映射** — 主路径、异常路径（校验失败、超时、限流、部分失败）、补偿（回滚、重试、DLQ）。
5. **技术债** — workaround、魔数/魔串语义、竞态风险、上帝对象或循环依赖等。

## 输出契约

输出 **一个合法 JSON 对象**。根字段如下（`business_rules` 等列表项按需提供，不可留无意义的占位项）。

```json
{
  "schema_version": "reasoning-1",
  "version_label": "v1|v2|main|optional-freeform",
  "source_blir_summary": "human-readable short note on which BLIR inputs were used",
  "domain_model": {
    "aggregates": [
      {
        "name": "",
        "entities": [],
        "invariants": [],
        "notes": ""
      }
    ],
    "value_objects": [],
    "domain_events": []
  },
  "state_machine": {
    "states": [],
    "transitions": [
      {
        "from": "",
        "to": "",
        "trigger": "",
        "guard": null
      }
    ],
    "illegal_transitions_blocked_by": []
  },
  "business_rules": [
    {
      "id": "BR-001",
      "description": "",
      "type": "explicit|implicit|temporal|consistency",
      "source_location": "file:line or module ref",
      "risk_level": "high|medium|low"
    }
  ],
  "use_cases": [
    {
      "name": "",
      "happy_path": [],
      "exception_paths": [],
      "compensation": []
    }
  ],
  "technical_debt": [
    {
      "type": "magic_number|workaround|race_condition|god_object|other",
      "location": "",
      "impact": "",
      "suggestion": ""
    }
  ]
}
```

## 质量闸

若 BLIR 覆盖明显不足（缺关键函数/依赖），在 `source_blir_summary` 中声明缺口，并避免高置信度的业务断言。
