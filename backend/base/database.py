import os
import sys

from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy_utils import database_exists


def get_eventstore_db_link():
    return f'postgresql://' \
           f'{os.environ["POSTGRES_USER"]}:' \
           f'{os.environ["POSTGRES_PASSWORD"]}@' \
           f'{os.environ["POSTGRES_HOST"]}:' \
           f'{os.environ["POSTGRES_PORT"]}/' \
           f'{os.environ["POSTGRES_DBNAME"]}'


def execute_sql_eventstore_db(sql):
    engine = create_engine(get_eventstore_db_link())
    with engine.connect() as connection:
        connection.execute(sql)
    engine.dispose()


def get_db_link():
    return f'postgresql://' \
           f'{os.environ["POSTGRES_USER"]}:' \
           f'{os.environ["POSTGRES_PASSWORD"]}@' \
           f'{os.environ["POSTGRES_REPLICA_HOST"]}:' \
           f'{os.environ["POSTGRES_REPLICA_PORT"]}/' \
           f'{os.environ["POSTGRES_DBNAME"]}'


print(get_db_link())
Base = declarative_base()
SessionLocal = None


def close_sessions():
    global SessionLocal
    if SessionLocal is not None:
        SessionLocal.close_all()
        SessionLocal = None


def get_sesionmaker():
    global SessionLocal
    if SessionLocal is None:
        create_sesionmaker()

    return SessionLocal()


def get_db():
    return get_sesionmaker()


def create_sesionmaker():
    engine = create_engine(get_db_link())
    global SessionLocal
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    if not database_exists(engine.url):
        sys.exit(
            f'Database "{os.environ["POSTGRES_DBNAME"]} " on "{os.environ["POSTGRES_REPLICA_HOST"]} ":"{os.environ["POSTGRES_REPLICA_PORT"]}" was not initialized with alembic')
    Base.metadata.create_all(bind=engine)
