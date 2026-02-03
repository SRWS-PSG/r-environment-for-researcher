# ChatGPT Diagnostic Accuracy Study

## 論文情報

- **タイトル**: Evaluation of ChatGPT as a diagnostic tool for medical learners and clinicians
- **DOI**: [10.1371/journal.pone.0307383](https://doi.org/10.1371/journal.pone.0307383)
- **掲載誌**: PLOS ONE
- **概要**: ChatGPT（大規模言語モデル）の診断精度を150のMedscapeケースチャレンジを用いて評価した研究

## 主要な知見

- 正答率: 49% (74/150)
- 全体精度: 74%
- 感度: 48.67%
- 特異度: 82.89%
- AUC: 0.66

## ディレクトリ構成

```
chatgpt_diagnostic_study/
├── data/
│   ├── raw/              # 元データ（論文PDF、Supporting Information）
│   └── processed/        # 加工済みデータ
├── docs/                 # 論文テキスト、参考資料
├── scripts/              # 解析スクリプト
├── output/               # 出力結果（図表、レポート）
└── README.md
```

## データソース

1. **論文PDF** → `docs/paper.txt`（テキスト化）
2. **S1 File (XLSX)** → `data/raw/s1_file.xlsx`
   - Supporting Information: 150ケースの詳細データ
   - ダウンロード: https://doi.org/10.1371/journal.pone.0307383.s001

## 使い方

1. 論文のPDFをテキスト化して `docs/paper.txt` に配置
2. S1 FileのXLSXを `data/raw/` にダウンロード
3. 解析スクリプトを `scripts/` で実行
