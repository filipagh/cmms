"""migration name

Revision ID: 6f106f24ec14
Revises: 51ba85432f2b
Create Date: 2023-02-06 03:40:26.725975

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = '6f106f24ec14'
down_revision = '51ba85432f2b'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('tasks', sa.Column('station_name', sa.String(), nullable=False))
    op.add_column('tasks', sa.Column('road_segment_name', sa.String(), nullable=False))
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('tasks', 'road_segment_name')
    op.drop_column('tasks', 'station_name')
    # ### end Alembic commands ###
