# Layer 1 — 业务逻辑中间表示（BLIR）

**何时加载：** 执行 `pre-refactor-analyze` 的 Layer 1 时完整阅读本文后再输出。

**上游输入：** 用户给定的文件路径、模块范围或由代理读取的源码正文。  
**下游消费：** `reference/step2.md`（业务推理）仅依赖本层 JSON，不得依赖未写入 BLIR 的臆测。

---

## 角色与目标

扮演 **资深静态分析工程师**：把多语言源码压成 **与语法无关的结构化中间表示**，让后续层只做语义推理、不做基础扫文件。

## 分析单元

默认 **一文件一对象**；若单文件过大，可在顶层增加 `"analysis_unit": "file|module"` 并在 `"module_id"` 标明聚合范围（在 `SUMMARY.md` 中说明理由）。

## 必做清单

对当前单元提取：

1. **符号表** — 类型、函数/方法签名、可见性；常量与环境变量读取点；泛型/类型别名。
2. **CFG 摘要** — 关键函数的入口条件、主要分支语义、循环形态、错误返回、副作用（I/O、可变状态、外部调用）。
3. **DFG 摘要** — 核心数据生命周期；不可变流水线 vs 原地修改；跨边界传递方式（参数、共享状态、消息、回调）。
4. **依赖与边界** — 内部模块边、外部库/服务、并发原语（锁、channel、async、线程池等）。

无法解析的段落：在输出中增加 `"parse_notes": ["..."]`，勿留空键冒充完成。

## 输出契约

输出 **一个合法 JSON 对象**（可多行格式化）。根字段必须与下列 schema 一致；无信息用 `[]`、`null` 或省略子键（仅当 schema 注明 optional），禁止编造路径。

```json
{
  "schema_version": "blir-1",
  "analysis_unit": "file",
  "file_path": "relative/path/from/repo/root.ext",
  "module_id": null,
  "symbols": {
    "classes": [
      {
        "name": "",
        "fields": [],
        "methods": [],
        "extends": null,
        "implements": []
      }
    ],
    "functions": [
      {
        "name": "",
        "args": [],
        "returns": null,
        "visibility": "public|private|internal|unknown"
      }
    ],
    "constants": [
      {
        "name": "",
        "value_preview": null,
        "location": "file:line"
      }
    ]
  },
  "control_flow": [
    {
      "function": "",
      "entry_checks": [],
      "branches": [
        {
          "condition": "",
          "semantic": "",
          "outcome": ""
        }
      ],
      "loops": [{ "type": "", "semantic": "" }],
      "error_paths": [],
      "side_effects": []
    }
  ],
  "data_flow": {
    "entities": [{ "name": "", "lifecycle": [] }],
    "immutable_chains": [],
    "mutable_state": []
  },
  "dependencies": {
    "internal": [],
    "external": [{ "name": "", "usage": "" }],
    "concurrency": []
  },
  "parse_notes": []
}
```

## 与用户材料的衔接

代理应将「当前文件路径」写入 `file_path`，源码片段在会话内用于填空；若仅能给目录，把该目录下相对路径一并写入 `parse_notes`。
