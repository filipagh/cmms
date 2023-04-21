from abc import abstractmethod


class AppException(Exception):
    """Base class for all Application exceptions."""

    @abstractmethod
    def __init__(self, message):
        super(AppException, self).__init__(message)
        self.message = message

    def to_dict(self):
        return {'message': self.message}
