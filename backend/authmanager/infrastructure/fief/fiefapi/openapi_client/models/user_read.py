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


class UserRead(object):
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
        'created_at': 'datetime',
        'updated_at': 'datetime',
        'id': 'object',
        'email': 'str',
        'is_active': 'bool',
        'is_superuser': 'bool',
        'is_verified': 'bool',
        'tenant_id': 'str',
        'tenant': 'TenantEmbedded',
        'fields': 'object'
    }

    attribute_map = {
        'created_at': 'created_at',
        'updated_at': 'updated_at',
        'id': 'id',
        'email': 'email',
        'is_active': 'is_active',
        'is_superuser': 'is_superuser',
        'is_verified': 'is_verified',
        'tenant_id': 'tenant_id',
        'tenant': 'tenant',
        'fields': 'fields'
    }

    def __init__(self, created_at=None, updated_at=None, id=None, email=None, is_active=True, is_superuser=False,
                 is_verified=False, tenant_id=None, tenant=None, fields=None,
                 local_vars_configuration=None):  # noqa: E501
        """UserRead - a model defined in OpenAPI"""  # noqa: E501
        if local_vars_configuration is None:
            local_vars_configuration = Configuration()
        self.local_vars_configuration = local_vars_configuration

        self._created_at = None
        self._updated_at = None
        self._id = None
        self._email = None
        self._is_active = None
        self._is_superuser = None
        self._is_verified = None
        self._tenant_id = None
        self._tenant = None
        self._fields = None
        self.discriminator = None

        self.created_at = created_at
        self.updated_at = updated_at
        if id is not None:
            self.id = id
        self.email = email
        if is_active is not None:
            self.is_active = is_active
        if is_superuser is not None:
            self.is_superuser = is_superuser
        if is_verified is not None:
            self.is_verified = is_verified
        self.tenant_id = tenant_id
        self.tenant = tenant
        self.fields = fields

    @property
    def created_at(self):
        """Gets the created_at of this UserRead.  # noqa: E501


        :return: The created_at of this UserRead.  # noqa: E501
        :rtype: datetime
        """
        return self._created_at

    @created_at.setter
    def created_at(self, created_at):
        """Sets the created_at of this UserRead.


        :param created_at: The created_at of this UserRead.  # noqa: E501
        :type: datetime
        """
        if self.local_vars_configuration.client_side_validation and created_at is None:  # noqa: E501
            raise ValueError("Invalid value for `created_at`, must not be `None`")  # noqa: E501

        self._created_at = created_at

    @property
    def updated_at(self):
        """Gets the updated_at of this UserRead.  # noqa: E501


        :return: The updated_at of this UserRead.  # noqa: E501
        :rtype: datetime
        """
        return self._updated_at

    @updated_at.setter
    def updated_at(self, updated_at):
        """Sets the updated_at of this UserRead.


        :param updated_at: The updated_at of this UserRead.  # noqa: E501
        :type: datetime
        """
        if self.local_vars_configuration.client_side_validation and updated_at is None:  # noqa: E501
            raise ValueError("Invalid value for `updated_at`, must not be `None`")  # noqa: E501

        self._updated_at = updated_at

    @property
    def id(self):
        """Gets the id of this UserRead.  # noqa: E501


        :return: The id of this UserRead.  # noqa: E501
        :rtype: object
        """
        return self._id

    @id.setter
    def id(self, id):
        """Sets the id of this UserRead.


        :param id: The id of this UserRead.  # noqa: E501
        :type: object
        """

        self._id = id

    @property
    def email(self):
        """Gets the email of this UserRead.  # noqa: E501


        :return: The email of this UserRead.  # noqa: E501
        :rtype: str
        """
        return self._email

    @email.setter
    def email(self, email):
        """Sets the email of this UserRead.


        :param email: The email of this UserRead.  # noqa: E501
        :type: str
        """
        if self.local_vars_configuration.client_side_validation and email is None:  # noqa: E501
            raise ValueError("Invalid value for `email`, must not be `None`")  # noqa: E501

        self._email = email

    @property
    def is_active(self):
        """Gets the is_active of this UserRead.  # noqa: E501


        :return: The is_active of this UserRead.  # noqa: E501
        :rtype: bool
        """
        return self._is_active

    @is_active.setter
    def is_active(self, is_active):
        """Sets the is_active of this UserRead.


        :param is_active: The is_active of this UserRead.  # noqa: E501
        :type: bool
        """

        self._is_active = is_active

    @property
    def is_superuser(self):
        """Gets the is_superuser of this UserRead.  # noqa: E501


        :return: The is_superuser of this UserRead.  # noqa: E501
        :rtype: bool
        """
        return self._is_superuser

    @is_superuser.setter
    def is_superuser(self, is_superuser):
        """Sets the is_superuser of this UserRead.


        :param is_superuser: The is_superuser of this UserRead.  # noqa: E501
        :type: bool
        """

        self._is_superuser = is_superuser

    @property
    def is_verified(self):
        """Gets the is_verified of this UserRead.  # noqa: E501


        :return: The is_verified of this UserRead.  # noqa: E501
        :rtype: bool
        """
        return self._is_verified

    @is_verified.setter
    def is_verified(self, is_verified):
        """Sets the is_verified of this UserRead.


        :param is_verified: The is_verified of this UserRead.  # noqa: E501
        :type: bool
        """

        self._is_verified = is_verified

    @property
    def tenant_id(self):
        """Gets the tenant_id of this UserRead.  # noqa: E501


        :return: The tenant_id of this UserRead.  # noqa: E501
        :rtype: str
        """
        return self._tenant_id

    @tenant_id.setter
    def tenant_id(self, tenant_id):
        """Sets the tenant_id of this UserRead.


        :param tenant_id: The tenant_id of this UserRead.  # noqa: E501
        :type: str
        """
        if self.local_vars_configuration.client_side_validation and tenant_id is None:  # noqa: E501
            raise ValueError("Invalid value for `tenant_id`, must not be `None`")  # noqa: E501

        self._tenant_id = tenant_id

    @property
    def tenant(self):
        """Gets the tenant of this UserRead.  # noqa: E501


        :return: The tenant of this UserRead.  # noqa: E501
        :rtype: TenantEmbedded
        """
        return self._tenant

    @tenant.setter
    def tenant(self, tenant):
        """Sets the tenant of this UserRead.


        :param tenant: The tenant of this UserRead.  # noqa: E501
        :type: TenantEmbedded
        """
        if self.local_vars_configuration.client_side_validation and tenant is None:  # noqa: E501
            raise ValueError("Invalid value for `tenant`, must not be `None`")  # noqa: E501

        self._tenant = tenant

    @property
    def fields(self):
        """Gets the fields of this UserRead.  # noqa: E501


        :return: The fields of this UserRead.  # noqa: E501
        :rtype: object
        """
        return self._fields

    @fields.setter
    def fields(self, fields):
        """Sets the fields of this UserRead.


        :param fields: The fields of this UserRead.  # noqa: E501
        :type: object
        """
        if self.local_vars_configuration.client_side_validation and fields is None:  # noqa: E501
            raise ValueError("Invalid value for `fields`, must not be `None`")  # noqa: E501

        self._fields = fields

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
        if not isinstance(other, UserRead):
            return False

        return self.to_dict() == other.to_dict()

    def __ne__(self, other):
        """Returns true if both objects are not equal"""
        if not isinstance(other, UserRead):
            return True

        return self.to_dict() != other.to_dict()
