from base.api_exception import AppException


class AppStationException(AppException):
    """class for station manager exceptions."""

    def __init__(self, message):
        super(AppStationException, self).__init__(message)

    def to_dict(self):
        return {'message': self.message}
