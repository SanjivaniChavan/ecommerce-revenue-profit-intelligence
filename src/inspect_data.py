
from pathlib import Path
import pandas as pd

project_root = Path(__file__).resolve().parents[1]
file_path = project_root / "data" / "raw" / "online_retail_II.xlsx"

excel = pd.ExcelFile(file_path)

print("Available sheets:", excel.sheet_names)

for sheet in excel.sheet_names:
    df = pd.read_excel(file_path, sheet_name=sheet, nrows=5)

    print(f"\nSheet: {sheet}")
    print("Columns:", df.columns.tolist())
    print(df.to_string(index=False))
