
from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
INPUT = ROOT / "data" / "processed" / "clean_sales.csv"
OUTPUT = ROOT / "data" / "processed"


def main():
    print("Loading customer transaction data...")

    df = pd.read_csv(
        INPUT,
        dtype={"invoice_id": str},
        parse_dates=["invoice_date"],
        low_memory=False
    )

    # RFM requires a known customer identity
    df = df.dropna(subset=["customer_id"]).copy()

    # Reference date: one day after the last transaction
    reference_date = df["invoice_date"].max().normalize() + pd.Timedelta(days=1)

    # Calculate Recency, Frequency and Monetary value
    rfm = df.groupby("customer_id").agg(
        last_purchase=("invoice_date", "max"),
        frequency=("invoice_id", "nunique"),
        monetary=("revenue", "sum")
    ).reset_index()

    rfm["recency"] = (
        reference_date - rfm["last_purchase"].dt.normalize()
    ).dt.days

    # Rank customers using percentile ranks
    rfm["r_score"] = pd.qcut(
        rfm["recency"].rank(method="first", ascending=False),
        5,
        labels=[1, 2, 3, 4, 5]
    ).astype(int)

    rfm["f_score"] = pd.qcut(
        rfm["frequency"].rank(method="first"),
        5,
        labels=[1, 2, 3, 4, 5]
    ).astype(int)

    rfm["m_score"] = pd.qcut(
        rfm["monetary"].rank(method="first"),
        5,
        labels=[1, 2, 3, 4, 5]
    ).astype(int)

    rfm["rfm_score"] = (
        rfm["r_score"].astype(str)
        + rfm["f_score"].astype(str)
        + rfm["m_score"].astype(str)
    )

    # Business-friendly customer segments
    def assign_segment(row):
        r, f = row["r_score"], row["f_score"]

        if r >= 4 and f >= 4:
            return "Champions"
        elif f >= 4 and r >= 2:
            return "Loyal Customers"
        elif r == 5 and f <= 2:
            return "New Customers"
        elif r <= 2 and f >= 4:
            return "At Risk"
        elif r <= 2 and f <= 2:
            return "Hibernating"
        else:
            return "Potential Loyalists"

    rfm["segment"] = rfm.apply(assign_segment, axis=1)

    rfm = rfm[[
        "customer_id", "recency", "frequency", "monetary",
        "r_score", "f_score", "m_score", "rfm_score", "segment"
    ]]

    OUTPUT.mkdir(parents=True, exist_ok=True)
    rfm.to_csv(OUTPUT / "customer_rfm.csv", index=False)

    segment_summary = (
        rfm.groupby("segment")
        .agg(
            customers=("customer_id", "count"),
            total_spend=("monetary", "sum"),
            average_spend=("monetary", "mean")
        )
        .reset_index()
        .sort_values("total_spend", ascending=False)
    )

    segment_summary.to_csv(
        OUTPUT / "customer_segments.csv", index=False
    )

    print(f"\nCustomers analyzed: {len(rfm):,}")
    print("\nCustomer segment summary:")
    print(segment_summary.to_string(index=False))
    print("\nRFM segmentation completed successfully.")


if __name__ == "__main__":
    main()
