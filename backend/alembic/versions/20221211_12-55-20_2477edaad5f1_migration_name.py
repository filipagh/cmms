"""migration name

Revision ID: 2477edaad5f1
Revises: ce800fea69b4
Create Date: 2022-12-11 12:55:20.655154

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = '2477edaad5f1'
down_revision = 'ce800fea69b4'
branch_labels = None
depends_on = None


def upgrade() -> None:
    op.execute("ALTER TYPE tasktype RENAME VALUE 'LOCAL_INSPECTION' TO 'ON_SITE_SERVICE';")
    op.execute("ALTER TYPE tasktype ADD VALUE 'REMOTE_SERVICE';")
    op.add_column('tasks', sa.Column('finished_at', sa.DateTime(), nullable=True))

def downgrade() -> None:
    raise Exception("downgrade need to be implemented")
    # https://stackoverflow.com/questions/14845203/altering-an-enum-field-using-alembic
    # ### commands auto generated by Alembic - please adjust! ###
    # op.drop_column('tasks', 'finished_at')
    # ### end Alembic commands ###