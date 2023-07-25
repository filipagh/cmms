"""migration name

Revision ID: f27568460fb0
Revises: 10241630802c
Create Date: 2023-07-25 11:31:10.176776

"""
import sqlalchemy as sa
from alembic import op

from base.database import dump_notifications_eventstore_db_service

# revision identifiers, used by Alembic.
revision = 'f27568460fb0'
down_revision = '10241630802c'
branch_labels = None
depends_on = None


def upgrade() -> None:
    dump_notifications_eventstore_db_service('actionhistoryprojector_tracking'
                                             )
    op.execute("delete from action_history")
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('action_history',
                  sa.Column('is_internal', sa.BOOLEAN(), server_default=sa.text('true'), nullable=False))
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('action_history', 'is_internal')
    # ### end Alembic commands ###