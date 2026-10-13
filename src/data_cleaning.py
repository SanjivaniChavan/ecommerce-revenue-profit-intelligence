
from pathlib import Path
import pandas as pd

PROJECT_ROOT = Path(__file__).resolve().parents[1]
RAW_FILE = PROJECT_ROOT / "data" / "raw" / "online_retail_II.xlsx"
OUTPUT_DIR = PROJECT_ROOT / "data" / "processed"


def load_data():
    """Load both years of retail transactions."""
    print("Loading retail transaction data...")

    sheets = pd.read_excel(
        RAW_FILE,
        sheet_name=None,
        dtype={"Invoice": str, "StockCode": str}
    )

    df = pd.concat(sheets.values(), ignore_index=True)

    print(f"Raw records: {len(df):,}")
    return df


def clean_data(df):
    """Validate and clean retail transactions."""
    df = df.copy()

    df.columns = [
        col.strip().lower().replace(" ", "_")
        for col in df.columns
    ]

    df = df.rename(columns={
        "invoice": "invoice_id",
        "customer_id": "customer_id",
        "price": "unit_price",
        "invoicedate": "invoice_date"
    })

    print(f"Duplicate records: {df.duplicated().sum():,}")
    df = df.drop_duplicates()

    df["invoice_date"] = pd.to_datetime(
        df["invoice_date"], errors="coerce"
    )

    df["quantity"] = pd.to_numeric(
        df["quantity"], errors="coerce"
    )

    df["unit_price"] = pd.to_numeric(
        df["unit_price"], errors="coerce"
    )

    df["customer_id"] = pd.to_numeric(
        df["customer_id"], errors="coerce"
    ).astype("Int64")

    df["description"] = df["description"].astype("string").str.strip()
    df["country"] = df["country"].astype("string").str.strip()

    # Separate cancellations and returns
    cancellation_mask = (
        df["invoice_id"].astype(str).str.upper().str.startswith("C")
        | (df["quantity"] < 0)
    )

    cancellations = df[cancellation_mask].copy()
    sales = df[~cancellation_mask].copy()

    # Keep valid sales transactions
    sales = sales.dropna(subset=[
        "invoice_id", "invoice_date", "quantity", "unit_price"
    ])

    sales = sales[
        (sales["quantity"] > 0)
        & (sales["unit_price"] > 0)
    ].copy()

    # Revenue per transaction line
    sales["revenue"] = (
        sales["quantity"] * sales["unit_price"]
    ).round(2)

    print(f"Clean sales records: {len(sales):,}")
    print(f"Cancellation/return records: {len(cancellations):,}")
    print(f"Total gross sales value: {sales['revenue'].sum():,.2f}")

    return sales, cancellations


def save_data(sales, cancellations):
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    sales.to_csv(
        OUTPUT_DIR / "clean_sales.csv",
        index=False
    )

    cancellations.to_csv(
        OUTPUT_DIR / "cancellations.csv",
        index=False
    )

    print("Processed datasets saved successfully.")


def main():
    df = load_data()
    sales, cancellations = clean_data(df)
    save_data(sales, cancellations)


if __name__ == "__main__":
    main()
