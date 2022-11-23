"""migration name

Revision ID: b6ab4bb93c32
Revises: c51f60311919
Create Date: 2022-11-23 06:01:40.975410

"""
import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = 'b6ab4bb93c32'
down_revision = 'c51f60311919'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('assigned_component', sa.Column('task_id', postgresql.UUID(as_uuid=True), nullable=True))
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('assigned_component', 'task_id')
    # ### end Alembic commands ###
