"""migration name

Revision ID: 05ae98f32d03
Revises: a69e7e93623e
Create Date: 2023-09-05 01:30:10.043126

"""
import sqlalchemy as sa
from alembic import op
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = '05ae98f32d03'
down_revision = 'a69e7e93623e'
branch_labels = None
depends_on = None


def upgrade() -> None:
    enum = postgresql.ENUM('INVESTMENT_CONTRACT', 'COMPANY_WARRANTY', 'NAN', name='componentwarrantysource')
    enum.create(op.get_bind(), checkfirst=True)
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('assigned_component', sa.Column('component_warranty_until', sa.Date(), nullable=True))
    op.add_column('assigned_component', sa.Column('component_warranty_source', enum, nullable=True))
    op.add_column('assigned_component',
                  sa.Column('component_warranty_id', postgresql.UUID(as_uuid=True), nullable=True))
    op.add_column('assigned_component', sa.Column('prepaid_service_until', sa.Date(), nullable=True))
    op.add_column('assigned_component', sa.Column('service_contract_until', sa.Date(), nullable=True))
    op.add_column('assigned_component', sa.Column('service_contract_id', postgresql.UUID(as_uuid=True), nullable=True))
    op.drop_column('assigned_component', 'warranty_period_days')
    op.drop_column('assigned_component', 'warranty_period_until')
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('assigned_component',
                  sa.Column('warranty_period_until', sa.DATE(), autoincrement=False, nullable=True))
    op.add_column('assigned_component',
                  sa.Column('warranty_period_days', sa.INTEGER(), autoincrement=False, nullable=True))
    op.drop_column('assigned_component', 'service_contract_id')
    op.drop_column('assigned_component', 'service_contract_until')
    op.drop_column('assigned_component', 'prepaid_service_until')
    op.drop_column('assigned_component', 'component_warranty_id')
    op.drop_column('assigned_component', 'component_warranty_source')
    op.drop_column('assigned_component', 'component_warranty_until')
    # ### end Alembic commands ###
