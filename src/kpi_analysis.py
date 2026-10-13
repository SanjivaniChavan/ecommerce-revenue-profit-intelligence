
from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
DATA_FILE = ROOT / "data" / "processed" / "clean_sales.csv"
OUTPUT = ROOT / "data" / "processed"


def main():
    df = pd.read_csv(
        DATA_FILE,
        dtype={"invoice_id": str, "stockcode": str},
        parse_dates=["invoice_date"],
        low_memory=False
    )

    # Validate required fields
    required = {
        "invoice_id", "invoice_date", "revenue",
        "quantity", "country", "stockcode", "description"
    }
    missing = required - set(df.columns)
    if missing:
        raise ValueError(f"Missing columns: {sorted(missing)}")

    # Executive KPIs
    total_revenue = df["revenue"].sum()
    total_orders = df["invoice_id"].nunique()
    total_units = df["quantity"].sum()
    aov = total_revenue / total_orders if total_orders else 0

    print("\n===== EXECUTIVE KPIs =====")
    print(f"Gross sales value: £{total_revenue:,.2f}")
    print(f"Unique invoices: {total_orders:,}")
    print(f"Units sold: {total_units:,}")
    print(f"Average order value: £{aov:,.2f}")

    # Monthly revenue trends
    df["year_month"] = df["invoice_date"].dt.to_period("M").astype(str)

    monthly = (
        df.groupby("year_month", as_index=False)
        .agg(
            revenue=("revenue", "sum"),
            orders=("invoice_id", "nunique"),
            units=("quantity", "sum")
        )
        .sort_values("year_month")
    )

    monthly.to_csv(OUTPUT / "monthly_sales.csv", index=False)

    # Top products
    products = (
        df.groupby(["stockcode", "description"], dropna=False)
        .agg(
            revenue=("revenue", "sum"),
            units=("quantity", "sum")
        )
        .reset_index()
        .sort_values("revenue", ascending=False)
    )

    products.to_csv(OUTPUT / "product_performance.csv", index=False)

    # Country performance
    countries = (
        df.groupby("country", dropna=False)
        .agg(
            revenue=("revenue", "sum"),
            orders=("invoice_id", "nunique")
        )
        .reset_index()
        .sort_values("revenue", ascending=False)
    )

    countries.to_csv(OUTPUT / "country_performance.csv", index=False)

    print("\nTop 5 countries by gross sales:")
    print(countries.head(5).to_string(index=False))

    print("\nKPI analysis completed successfully.")


if __name__ == "__main__":
    main()
