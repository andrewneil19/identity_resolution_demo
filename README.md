# Identity Resolution for County Commissioners

A demonstration project showcasing entity matching and deduplication using SQL, BigQuery, and transformer embeddings.

## Problem Statement

Clean energy advocacy organizations track county commissioners who make permitting decisions on renewable energy projects. Commissioner information comes from multiple sources:
- Official county websites
- News articles  
- Meeting minutes
- Public records databases
- Email contact lists

**Challenge:** Different sources format the same person's information differently:
- "Stan Sallee" vs "Commissioner Sallee" vs "Sallee, S." vs "Sallee, Stan"

This project demonstrates how to identify when different records refer to the same person.

## Approach

### 1. Data Pipeline (SQL + BigQuery)
- Created realistic test dataset (17 commissioners, 85 total records with variations)
- Used BigQuery for cloud data warehousing
- SQL self-join with intelligent filtering to generate 730 candidate pairs

### 2. Identity Resolution (NLP + Embeddings)
- Transformer-based embeddings (`all-MiniLM-L6-v2`, BERT encoder)
- Cosine similarity to compare name variations
- Threshold optimization for precision/recall balance

### 3. Evaluation
- Achieved 100% precision, 95.3% recall
- 98.9% overall accuracy
- Identified 8 edge cases for future improvement

## Technical Stack

- **Cloud:** Google Cloud Platform (BigQuery, Colab Enterprise)
- **Languages:** Python, SQL
- **Libraries:** 
  - `sentence-transformers` (embeddings)
  - `google-cloud-bigquery` (data warehousing)
  - `pandas`, `scikit-learn` (data manipulation, metrics)

## Results

| Metric | Value |
|--------|-------|
| Precision | 100.0% |
| Recall | 95.3% |
| F1 Score | 0.976 |
| Accuracy | 98.9% |

**Key Finding:** Embedding-based matching works well for most name variations but struggles when first names are completely dropped. Future work could combine embeddings with rule-based approaches.

## Project Structure
```
identity-resolution-demo/
├── README.md
├── import_data_and_identity_resolution.ipynb
├── requirements.txt
└── .gitignore
```

## How to Run

### Prerequisites
- Google Cloud Platform account
- BigQuery dataset created
- Python 3.8+

### Setup
```bash
# Install dependencies
pip install -r requirements.txt

# Run in Google Colab Enterprise or local Jupyter
jupyter notebook import_data_and_identity_resolution.ipynb
```

### Steps
1. Generate synthetic commissioner data
2. Load to BigQuery
3. Run candidate generation SQL
4. Compute embeddings and similarity scores
5. Optimize threshold and evaluate results

## Future Enhancements

- **Hybrid Matching:** Combine embeddings with exact last name matching to catch edge cases
- **Production Pipeline:** Add orchestration (Airflow, Prefect) and monitoring
- **Scalability:** Batch processing for larger datasets
- **Active Learning:** Use missed cases to fine-tune the model

## Author

Andy Neil  
[LinkedIn](your-linkedin) | [Portfolio](your-portfolio)

**Context:** Created as a technical demonstration for data engineering roles in clean energy advocacy.

## License

MIT License - feel free to use for learning or portfolio purposes.
```

---

## Step 3: Additional files needed

**requirements.txt:**
```
google-cloud-bigquery>=3.0.0
pandas>=1.5.0
sentence-transformers>=2.2.0
scikit-learn>=1.2.0
numpy>=1.23.0
```

**.gitignore:**
```
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
.venv

# Jupyter
.ipynb_checkpoints
*/.ipynb_checkpoints/*

# GCP credentials
*.json
credentials/
.google/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Data
*.csv
*.parquet
data/
