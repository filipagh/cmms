from base.api_exception import AppException


class AppRoadSegmentException(AppException):
    """class for station manager exceptions."""

    def __init__(self, message):
        super(AppRoadSegmentException, self).__init__(message)

    def to_dict(self):
        return {'message': self.message}
