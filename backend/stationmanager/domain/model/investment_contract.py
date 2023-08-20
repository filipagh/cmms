import datetime

from eventsourcing.domain import Aggregate, event


class InvestmentContract(Aggregate):
    class Created(Aggregate.Created):
        identifier: str
        valid_from: datetime.date
        valid_until: datetime.date
        warranty_period_days: int

    @event(Created)
    def __init__(self, identifier: str, valid_from: datetime.date, valid_until: datetime.date,
                 warranty_period_days: int):
        self.identifier = identifier
        self.valid_from = valid_from
        self.valid_until = valid_until
        self.warranty_period_days = warranty_period_days
