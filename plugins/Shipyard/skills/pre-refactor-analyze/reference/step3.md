# Layer 3 — 版本差异与语义漂移

**何时加载：** 仅 **对比模式**（同时存在 v1、v2）且两侧 Layer 2 JSON 已就绪。

**上游输入：** `reasoning_v1.json` 与 `reasoning_v2.json`（字段结构以 `reference/step2.md` 为准）。可选附带关键 BLIR 差异摘要；不得引入未出现在 Layer 2 中的新业务结论而不标注为假设。

**下游消费：** `reference/step4.md`。

---

## 角色与目标

扮演 **迁移审计专家**：对比两版 **业务语义是否仍等价**，识别 breaking change、隐式破坏、数据与并发层面的兼容性风险，并粗估迁移形态。

## 必做清单

1. **结构差异表** — 领域模型、状态机、对外接口等维度：`变化类型` + `影响（兼容 / 需适配 / 破坏）`。
2. **语义漂移** — 伪等价、真差异、隐式破坏；每条给出建议的 **验证手段**（测试、双跑、契约、日志对比）。
3. **数据兼容性** — 序列化、DB schema、配置项映射。
4. **并发与次序** — 同步/异步、锁粒度、共享状态方式的改变及可能违背的时序假设。
5. **迁移工作量** — 按模块标为 `direct | adapter | rewrite` 之一，可附粗略量级说明（文件数、大致 risk），避免虚假精确 LOE。

## 输出契约

```json
{
  "schema_version": "delta-1",
  "structural_delta": [
    {
      "dimension": "",
      "v1": "",
      "v2": "",
      "change_type": "",
      "impact": "compatible|adapter_needed|breaking"
    }
  ],
  "semantic_drift": [
    {
      "category": "pseudo_equivalent|real_difference|implicit_breakage",
      "description": "",
      "v1_location": "",
      "v2_location": "",
      "risk": "high|medium|low",
      "verification_method": ""
    }
  ],
  "data_compatibility": {
    "serialization": [],
    "database_schema": [],
    "configuration": []
  },
  "concurrency_risks": [],
  "migration_effort": [
    {
      "module": "",
      "effort_type": "direct|adapter|rewrite",
      "notes": ""
    }
  ]
}
```

## 质量闸

若两侧 Layer 2 基于的代码范围不对等，在根上增加 `"scope_warning": "..."`，禁止输出「完全一致」类结论。
