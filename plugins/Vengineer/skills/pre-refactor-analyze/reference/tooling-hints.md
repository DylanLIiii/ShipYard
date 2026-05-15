# 静态分析与工具速查（可选）

在 Layer 1 收集结构信息时，可按语言选用；**工具失败不阻断技能**，把失败原因记入 BLIR 或 `SUMMARY.md`。

| 环节 | Python | Rust | Go | TypeScript / JS |
|------|--------|------|-----|-----------------|
| AST / 结构 | `ast`、`tree-sitter-python` | `syn`、`tree-sitter-rust` | `tree-sitter-go` | `typescript` compiler API、`ts-morph`、`tree-sitter-typescript` |
| 调用关系 | `pyan3` 等 | `cargo-call-stack` 等 | `callgraph` 等 | `ts-morph` 引用查询 |
| 类型 / 风格 | `mypy`、`ruff` | `clippy` | `staticcheck` | `tsc`、`eslint` |

**原则：** 技能产物以 **BLIR / 推理 / delta / patterns** 的 JSON 为准；工具只辅助填实 `symbols`、`dependencies` 等字段，没有则用手工阅读补全。
