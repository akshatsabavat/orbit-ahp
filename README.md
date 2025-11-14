# Orbit-AHP

**AI Agents + Analytic Hierarchy Process for Personalized Recommendations & Vendor Intelligence**

Orbit is a proof-of-concept hackathon project that combines AI agents (Gemini) with the Analytic Hierarchy Process (AHP) to automatically generate dynamic, context-aware criteria weights — eliminating the biggest pain point of traditional AHP (manual expert pairwise comparisons).

- **Micro layer** → personalized product recommendations with full mathematical transparency
- **Macro layer** → aggregates thousands of individual decisions into actionable vendor strategy (segmentation, priority weights, product gaps, concrete recommendations)

Built solo in ~48 hours at the 5th T.L. Saaty Decision Making for Leaders Hackathon (Oct 31 – Nov 2, 2025, University of Pittsburgh).

---

## Tech Stack

- **Backend**: FastAPI + Python 3.11+
- **AI reasoning & NLP**: Google Gemini (gemini-1.5-flash or gemini-2.0-flash-exp)
- **Database**: Supabase (PostgreSQL + real-time)
- **AHP math**: NumPy
- **Visualization**: Matplotlib (quick charts only)
- **Other**: python-dotenv, pydantic, httpx, etc.

---

## Project Structure

```
ORBIT-AHP/
├── output/                         # Generated visualizations and results
│   ├── macro/                      # Macro-level analysis outputs
│   └── [user]_*.png                # User-specific AHP visualizations
├── sql_scripts/                    # Database schema and seed data
│   ├── macro_synthesized_seed.sql
│   └── products_seed.sql
├── ahp_engine.py                   # Core AHP calculation engine
├── ahp_matrix_viz.py               # AHP matrix visualization
├── db.py                           # Database connection and queries
├── macro_ahp_engine.py             # Macro-level AHP processing
├── macro_main.py                   # Macro-level analysis entry point
├── macro_visualizer.py             # Macro-level visualizations
├── main.py                         # Main FastAPI application
├── models.py                       # Pydantic models
├── test_macro.py                   # Macro-level tests
├── visualizer.py                   # Micro-level visualizations
├── .env                            # Environment variables (create from .env.example)
├── .gitignore
├── pyproject.toml                  # Project configuration
├── python-version                  # Python version specification
├── uv.lock                         # UV package manager lock file
└── README.md
```

---

## Setup & Running Locally

### 1. Clone the repo

```bash
git clone https://github.com/akshatsabavat/orbit-ahp.git
cd orbit-ahp
```

### 2. Virtual environment (recommended)

```bash
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

_(If requirements.txt is missing, create it with at least the packages listed in the Tech Stack above.)_

### 4. Create your own Supabase project (required)

1. Go to [https://supabase.com](https://supabase.com) → Sign up / log in → New project (free tier works perfectly)
2. Wait for it to spin up (~2 minutes)
3. **Project Settings** → **API** → copy:
   - Project URL
   - anon public key (use this for local dev)
   - service_role key (only if you need to bypass RLS)

### 5. Initialize the database with the provided SQL scripts

In your Supabase dashboard → **SQL editor** → run the SQL files in `scripts/` in order (01 → 02 → 03 …).

These scripts:

- Create all necessary tables (users, purchases, products, segments, etc.)
- Seed real laptop product data
- Seed optional synthesized macro-layer example data so the vendor endpoints work out of the box

### 6. Google Gemini API key

1. Go to [https://ai.google.dev](https://ai.google.dev) → Get API key (free tier is more than enough)
2. Enable Gemini 1.5 Flash (or 2.0 flash experimental)

### 7. Create `.env` file

Copy `.env.example` → `.env` and fill:

```env
GEMINI_API_KEY=your_gemini_key_here
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_KEY=your_anon_public_key_here
```

### 8. Run the server

```bash
uvicorn app.main:app --reload --port 8000
```

- **API** → [http://127.0.0.1:8000](http://127.0.0.1:8000)
- **Swagger docs** → [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)

### 9. Quick test – Micro layer

execute - uv run main.py, and if you see the main.py code you can see other stuff I have set up, allowing you to put in custom queries

### 10. Quick test – Macro layer

execute - uv run macro_main.py

## Known Limitations (it's a 48-hour hackathon build)

- Macro recommendations are still prompt-based on aggregated data (works but can be brittle)
- No authentication / rate limiting missing
- Prompt engineering could use guardrails / caching
- Only laptops are fully implemented and seeded
- No frontend

---

## Contributing / Next Steps

This is intentionally rough so there's plenty of low-hanging fruit:

- Real aggregation pipelines
- Stable weight generation (ensemble prompts, fine-tuned model, etc.)
- Frontend demo
- Proper auth + deployment

PRs very welcome — just open an issue first for big changes.
