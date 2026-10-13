
import os
from getpass import getpass
from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL

def get_engine():
    password = os.getenv("DB_PASSWORD")

    if not password:
        password = getpass("Enter PostgreSQL password: ")

    url = URL.create(
        drivername="postgresql+psycopg2",
        username="postgres",
        password=password,
        host="localhost",
        port=5432,
        database="ecommerce_analytics"
    )

    return create_engine(url, pool_pre_ping=True)

if __name__ == "__main__":
    engine = get_engine()

    with engine.connect() as connection:
        result = connection.execute(text("SELECT version();"))
        print("Connected successfully!")
        print(result.scalar())
