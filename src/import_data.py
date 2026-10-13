
import pandas as pd
from sqlalchemy import text
from db_connection import get_engine

engine = get_engine()

def import_csv(file_path, table_name, columns):
    print(f"\nLoading {table_name}...")

    total = 0

    for chunk in pd.read_csv(file_path, chunksize=10000):
        chunk.columns = chunk.columns.str.strip().str.lower()

        # Keep only columns defined in the database
        chunk = chunk[columns]

        chunk.to_sql(
            table_name,
            engine,
            if_exists="append",
            index=False,
            chunksize=1000,
            method="multi"
        )

        total += len(chunk)
        print(f"Imported {total:,} rows", end="\r")

    print(f"\nCompleted: {table_name} ({total:,} rows)")


def main():
    sales_columns = [
        "invoice_id",
        "stockcode",
        "description",
        "quantity",
        "invoice_date",
        "unit_price",
        "customer_id",
        "country",
        "revenue"
    ]

    rfm_columns = [
        "customer_id",
        "recency",
        "frequency",
        "monetary",
        "r_score",
        "f_score",
        "m_score",
        "rfm_score",
        "segment"
    ]

    with engine.connect() as conn:
        sales_count = conn.execute(
            text("SELECT COUNT(*) FROM sales_transactions")
        ).scalar()

        rfm_count = conn.execute(
            text("SELECT COUNT(*) FROM customer_rfm")
        ).scalar()

    if sales_count == 0:
        import_csv(
            "data/processed/clean_sales.csv",
            "sales_transactions",
            sales_columns
        )
    else:
        print("Sales table already contains data. Skipping.")

    if rfm_count == 0:
        import_csv(
            "data/processed/customer_rfm.csv",
            "customer_rfm",
            rfm_columns
        )
    else:
        print("RFM table already contains data. Skipping.")


if __name__ == "__main__":
    main()
