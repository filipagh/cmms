from base.api_exception import AppException


class AppIssueException(AppException):

    def __init__(self, message):
        super(AppIssueException, self).__init__(message)

    def to_dict(self):
        return {'message': self.message}
