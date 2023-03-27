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


class UserFieldCreate(object):
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
        'name': 'str',
        'slug': 'str',
        'type': 'UserFieldType',
        'configuration': 'UserFieldConfiguration'
    }

    attribute_map = {
        'name': 'name',
        'slug': 'slug',
        'type': 'type',
        'configuration': 'configuration'
    }

    def __init__(self, name=None, slug=None, type=None, configuration=None,
                 local_vars_configuration=None):  # noqa: E501
        """UserFieldCreate - a model defined in OpenAPI"""  # noqa: E501
        if local_vars_configuration is None:
            local_vars_configuration = Configuration()
        self.local_vars_configuration = local_vars_configuration

        self._name = None
        self._slug = None
        self._type = None
        self._configuration = None
        self.discriminator = None

        self.name = name
        self.slug = slug
        self.type = type
        self.configuration = configuration

    @property
    def name(self):
        """Gets the name of this UserFieldCreate.  # noqa: E501


        :return: The name of this UserFieldCreate.  # noqa: E501
        :rtype: str
        """
        return self._name

    @name.setter
    def name(self, name):
        """Sets the name of this UserFieldCreate.


        :param name: The name of this UserFieldCreate.  # noqa: E501
        :type: str
        """
        if self.local_vars_configuration.client_side_validation and name is None:  # noqa: E501
            raise ValueError("Invalid value for `name`, must not be `None`")  # noqa: E501

        self._name = name

    @property
    def slug(self):
        """Gets the slug of this UserFieldCreate.  # noqa: E501


        :return: The slug of this UserFieldCreate.  # noqa: E501
        :rtype: str
        """
        return self._slug

    @slug.setter
    def slug(self, slug):
        """Sets the slug of this UserFieldCreate.


        :param slug: The slug of this UserFieldCreate.  # noqa: E501
        :type: str
        """
        if self.local_vars_configuration.client_side_validation and slug is None:  # noqa: E501
            raise ValueError("Invalid value for `slug`, must not be `None`")  # noqa: E501

        self._slug = slug

    @property
    def type(self):
        """Gets the type of this UserFieldCreate.  # noqa: E501


        :return: The type of this UserFieldCreate.  # noqa: E501
        :rtype: UserFieldType
        """
        return self._type

    @type.setter
    def type(self, type):
        """Sets the type of this UserFieldCreate.


        :param type: The type of this UserFieldCreate.  # noqa: E501
        :type: UserFieldType
        """
        if self.local_vars_configuration.client_side_validation and type is None:  # noqa: E501
            raise ValueError("Invalid value for `type`, must not be `None`")  # noqa: E501

        self._type = type

    @property
    def configuration(self):
        """Gets the configuration of this UserFieldCreate.  # noqa: E501


        :return: The configuration of this UserFieldCreate.  # noqa: E501
        :rtype: UserFieldConfiguration
        """
        return self._configuration

    @configuration.setter
    def configuration(self, configuration):
        """Sets the configuration of this UserFieldCreate.


        :param configuration: The configuration of this UserFieldCreate.  # noqa: E501
        :type: UserFieldConfiguration
        """
        if self.local_vars_configuration.client_side_validation and configuration is None:  # noqa: E501
            raise ValueError("Invalid value for `configuration`, must not be `None`")  # noqa: E501

        self._configuration = configuration

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
        if not isinstance(other, UserFieldCreate):
            return False

        return self.to_dict() == other.to_dict()

    def __ne__(self, other):
        """Returns true if both objects are not equal"""
        if not isinstance(other, UserFieldCreate):
            return True

        return self.to_dict() != other.to_dict()
