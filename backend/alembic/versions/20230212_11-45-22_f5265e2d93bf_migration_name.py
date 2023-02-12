"""migration name

Revision ID: f5265e2d93bf
Revises: 6f106f24ec14
Create Date: 2023-02-12 11:45:22.847633

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = 'f5265e2d93bf'
down_revision = '6f106f24ec14'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('service_contracts',
    sa.Column('id', postgresql.UUID(as_uuid=True), nullable=False),
    sa.Column('created_at', sa.Date(), nullable=False),
    sa.Column('valid_from', sa.Date(), nullable=False),
    sa.Column('valid_until', sa.Date(), nullable=False),
    sa.Column('name', sa.String(), nullable=False),
    sa.PrimaryKeyConstraint('id')
    )
    op.create_index(op.f('ix_service_contracts_id'), 'service_contracts', ['id'], unique=False)
    op.create_table('station_service_contracts',
    sa.Column('station_id', postgresql.UUID(as_uuid=True), nullable=False),
    sa.Column('contract_id', postgresql.UUID(as_uuid=True), nullable=False),
    sa.ForeignKeyConstraint(['contract_id'], ['service_contracts.id'], ),
    sa.PrimaryKeyConstraint('station_id', 'contract_id')
    )
    op.create_index(op.f('ix_station_service_contracts_contract_id'), 'station_service_contracts', ['contract_id'], unique=False)
    op.create_index(op.f('ix_station_service_contracts_station_id'), 'station_service_contracts', ['station_id'], unique=False)
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index(op.f('ix_station_service_contracts_station_id'), table_name='station_service_contracts')
    op.drop_index(op.f('ix_station_service_contracts_contract_id'), table_name='station_service_contracts')
    op.drop_table('station_service_contracts')
    op.drop_index(op.f('ix_service_contracts_id'), table_name='service_contracts')
    op.drop_table('service_contracts')
    # ### end Alembic commands ###
