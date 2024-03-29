"""migration name

Revision ID: 05b8c9b14058
Revises: 3b5f8e8e9c1f
Create Date: 2023-04-03 20:52:53.267644

"""
import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision = '05b8c9b14058'
down_revision = '3b5f8e8e9c1f'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('settings',
                    sa.Column('key', sa.String(), nullable=False),
                    sa.Column('value', sa.String(), nullable=True),
                    sa.PrimaryKeyConstraint('key')
                    )
    op.create_index(op.f('ix_settings_key'), 'settings', ['key'], unique=False)
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index(op.f('ix_settings_key'), table_name='settings')
    op.drop_table('settings')
    # ### end Alembic commands ###
