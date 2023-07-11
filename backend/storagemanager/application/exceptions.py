from base.api_exception import AppException


class AppStorageException(AppException):

    def __init__(self, message):
        super(AppStorageException, self).__init__(str(message))

    def to_dict(self):
        return {'message': self.message}
