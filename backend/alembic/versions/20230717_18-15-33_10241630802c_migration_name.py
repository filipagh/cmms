"""migration name

Revision ID: 10241630802c
Revises: a78413a57fba
Create Date: 2023-07-17 18:15:33.207833

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = '10241630802c'
down_revision = 'a78413a57fba'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('assets', sa.Column('is_archived', sa.Boolean(), nullable=False, server_default=sa.text('false')))
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('assets', 'is_archived')
    # ### end Alembic commands ###