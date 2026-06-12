---
description: Delegate a task to OpenAI Codex CLI with context
---

# Delegate to Codex (Debug Helper)

Codex をデバッグ・アイデア出しに活用。Codex がコード/解決策を生成し、Antigravity がファイル操作を実行。

## Instructions for Antigravity

`/codex [task]` が呼ばれたら:

// turbo
1. **Codex にアイデアを求める**:
   ```powershell
   codex exec "[task] - コードや解決策を提案してください。ファイル作成は不要です。"
   ```

2. **出力をパース**: Codex の提案からコードや修正案を抽出

3. **ファイル操作を実行**: 必要なファイルを作成・編集

4. **検証**: コードを実行してエラーがないか確認

5. **結果を報告**: 実行結果とCodexの提案を要約

## デバッグ用途

- エラーメッセージを `/codex [error message]` で渡すと原因分析
- スタックトレースから修正案を提案
- 既存コードの問題点を指摘
