export $(grep -v '^#' .env | xargs)
alembic revision --autogenerate -m "migration name"
