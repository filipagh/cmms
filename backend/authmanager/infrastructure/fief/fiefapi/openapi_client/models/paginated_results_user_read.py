# coding: utf-8

"""
    Fief Administration API

    No description provided (generated by Openapi Generator https://github.com/openapitools/openapi-generator)  # noqa: E501

    The version of the OpenAPI document: 0.23.2
    Contact: contact@fief.dev
    Generated by: https://openapi-generator.tech
"""

import pprint
import re  # noqa: F401

import six

from authmanager.infrastructure.fief.fiefapi.openapi_client.configuration import Configuration


class PaginatedResultsUserRead(object):
    """NOTE: This class is auto generated by OpenAPI Generator.
    Ref: https://openapi-generator.tech

    Do not edit the class manually.
    """

    """
    Attributes:
      openapi_types (dict): The key is attribute name
                            and the value is attribute type.
      attribute_map (dict): The key is attribute name
                            and the value is json key in definition.
    """
    openapi_types = {
        'count': 'int',
        'results': 'list[UserRead]'
    }

    attribute_map = {
        'count': 'count',
        'results': 'results'
    }

    def __init__(self, count=None, results=None, local_vars_configuration=None):  # noqa: E501
        """PaginatedResultsUserRead - a model defined in OpenAPI"""  # noqa: E501
        if local_vars_configuration is None:
            local_vars_configuration = Configuration()
        self.local_vars_configuration = local_vars_configuration

        self._count = None
        self._results = None
        self.discriminator = None

        self.count = count
        self.results = results

    @property
    def count(self):
        """Gets the count of this PaginatedResultsUserRead.  # noqa: E501


        :return: The count of this PaginatedResultsUserRead.  # noqa: E501
        :rtype: int
        """
        return self._count

    @count.setter
    def count(self, count):
        """Sets the count of this PaginatedResultsUserRead.


        :param count: The count of this PaginatedResultsUserRead.  # noqa: E501
        :type: int
        """
        if self.local_vars_configuration.client_side_validation and count is None:  # noqa: E501
            raise ValueError("Invalid value for `count`, must not be `None`")  # noqa: E501

        self._count = count

    @property
    def results(self):
        """Gets the results of this PaginatedResultsUserRead.  # noqa: E501


        :return: The results of this PaginatedResultsUserRead.  # noqa: E501
        :rtype: list[UserRead]
        """
        return self._results

    @results.setter
    def results(self, results):
        """Sets the results of this PaginatedResultsUserRead.


        :param results: The results of this PaginatedResultsUserRead.  # noqa: E501
        :type: list[UserRead]
        """
        if self.local_vars_configuration.client_side_validation and results is None:  # noqa: E501
            raise ValueError("Invalid value for `results`, must not be `None`")  # noqa: E501

        self._results = results

    def to_dict(self):
        """Returns the model properties as a dict"""
        result = {}

        for attr, _ in six.iteritems(self.openapi_types):
            value = getattr(self, attr)
            if isinstance(value, list):
                result[attr] = list(map(
                    lambda x: x.to_dict() if hasattr(x, "to_dict") else x,
                    value
                ))
            elif hasattr(value, "to_dict"):
                result[attr] = value.to_dict()
            elif isinstance(value, dict):
                result[attr] = dict(map(
                    lambda item: (item[0], item[1].to_dict())
                    if hasattr(item[1], "to_dict") else item,
                    value.items()
                ))
            else:
                result[attr] = value

        return result

    def to_str(self):
        """Returns the string representation of the model"""
        return pprint.pformat(self.to_dict())

    def __repr__(self):
        """For `print` and `pprint`"""
        return self.to_str()

    def __eq__(self, other):
        """Returns true if both objects are equal"""
        if not isinstance(other, PaginatedResultsUserRead):
            return False

        return self.to_dict() == other.to_dict()

    def __ne__(self, other):
        """Returns true if both objects are not equal"""
        if not isinstance(other, PaginatedResultsUserRead):
            return True

        return self.to_dict() != other.to_dict()
