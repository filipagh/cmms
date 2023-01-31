import datetime


def warranty_until_date_calc(date_from: datetime.date, warranty_days: int):
    return date_from + datetime.timedelta(days=warranty_days)
