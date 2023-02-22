import os
import sys
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy_utils import database_exists


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
    SessionLocal.close_all()
    SessionLocal = None


def get_sesionmaker():
    global SessionLocal
    if SessionLocal is None:
        create_sesionmaker()

    return SessionLocal()


def create_sesionmaker():
    engine = create_engine(get_db_link())
    global SessionLocal
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    if not database_exists(engine.url):
        sys.exit(
            f'Database "{os.environ["POSTGRES_DBNAME"]} " on "{os.environ["POSTGRES_REPLICA_HOST"]} ":"{os.environ["POSTGRES_REPLICA_PORT"]}" was not initialized with alembic')
    Base.metadata.create_all(bind=engine)
