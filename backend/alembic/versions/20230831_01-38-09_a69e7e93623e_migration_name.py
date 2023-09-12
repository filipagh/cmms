"""migration name

Revision ID: a69e7e93623e
Revises: 1235898d1af0
Create Date: 2023-08-31 01:38:09.235149

"""
import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = 'a69e7e93623e'
down_revision = '1235898d1af0'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('component_service_contracts',
                    sa.Column('component_id', postgresql.UUID(as_uuid=True), nullable=False),
                    sa.Column('station_id', postgresql.UUID(as_uuid=True), nullable=False),
                    sa.Column('contract_id', postgresql.UUID(as_uuid=True), nullable=False),
                    sa.ForeignKeyConstraint(['station_id', 'contract_id'], ['station_service_contracts.station_id',
                                                                            'station_service_contracts.contract_id'], ),
                    sa.PrimaryKeyConstraint('component_id', 'station_id', 'contract_id')
                    )
    op.create_index(op.f('ix_component_service_contracts_component_id'), 'component_service_contracts',
                    ['component_id'], unique=False)
    op.create_index(op.f('ix_component_service_contracts_contract_id'), 'component_service_contracts', ['contract_id'],
                    unique=False)
    op.create_index(op.f('ix_component_service_contracts_station_id'), 'component_service_contracts', ['station_id'],
                    unique=False)
    ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_index(op.f('ix_component_service_contracts_station_id'), table_name='component_service_contracts')
    op.drop_index(op.f('ix_component_service_contracts_contract_id'), table_name='component_service_contracts')
    op.drop_index(op.f('ix_component_service_contracts_component_id'), table_name='component_service_contracts')
    op.drop_table('component_service_contracts')
    ### end Alembic commands ###
