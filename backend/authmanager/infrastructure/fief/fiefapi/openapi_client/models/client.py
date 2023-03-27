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


class Client(object):
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
        'id': 'str',
        'name': 'str',
        'first_party': 'bool',
        'client_type': 'ClientType',
        'client_id': 'str',
        'client_secret': 'str',
        'redirect_uris': 'list[str]',
        'authorization_code_lifetime_seconds': 'int',
        'access_id_token_lifetime_seconds': 'int',
        'refresh_token_lifetime_seconds': 'int',
        'tenant_id': 'str',
        'tenant': 'TenantEmbedded',
        'encrypt_jwk': 'str'
    }

    attribute_map = {
        'created_at': 'created_at',
        'updated_at': 'updated_at',
        'id': 'id',
        'name': 'name',
        'first_party': 'first_party',
        'client_type': 'client_type',
        'client_id': 'client_id',
        'client_secret': 'client_secret',
        'redirect_uris': 'redirect_uris',
        'authorization_code_lifetime_seconds': 'authorization_code_lifetime_seconds',
        'access_id_token_lifetime_seconds': 'access_id_token_lifetime_seconds',
        'refresh_token_lifetime_seconds': 'refresh_token_lifetime_seconds',
        'tenant_id': 'tenant_id',
        'tenant': 'tenant',
        'encrypt_jwk': 'encrypt_jwk'
    }

    def __init__(self, created_at=None, updated_at=None, id=None, name=None, first_party=None, client_type=None,
                 client_id=None, client_secret=None, redirect_uris=None, authorization_code_lifetime_seconds=None,
                 access_id_token_lifetime_seconds=None, refresh_token_lifetime_seconds=None, tenant_id=None,
                 tenant=None, encrypt_jwk=None, local_vars_configuration=None):  # noqa: E501
        """Client - a model defined in OpenAPI"""  # noqa: E501
        if local_vars_configuration is None:
            local_vars_configuration = Configuration()
        self.local_vars_configuration = local_vars_configuration

        self._created_at = None
        self._updated_at = None
        self._id = None
        self._name = None
        self._first_party = None
        self._client_type = None
        self._client_id = None
        self._client_secret = None
        self._redirect_uris = None
        self._authorization_code_lifetime_seconds = None
        self._access_id_token_lifetime_seconds = None
        self._refresh_token_lifetime_seconds = None
        self._tenant_id = None
        self._tenant = None
        self._encrypt_jwk = None
        self.discriminator = None

        self.created_at = created_at
        self.updated_at = updated_at
        self.id = id
        self.name = name
        self.first_party = first_party
        self.client_type = client_type
        self.client_id = client_id
        self.client_secret = client_secret
        self.redirect_uris = redirect_uris
        self.authorization_code_lifetime_seconds = authorization_code_lifetime_seconds
        self.access_id_token_lifetime_seconds = access_id_token_lifetime_seconds
        self.refresh_token_lifetime_seconds = refresh_token_lifetime_seconds
        self.tenant_id = tenant_id
        self.tenant = tenant
        if encrypt_jwk is not None:
            self.encrypt_jwk = encrypt_jwk

    @property
    def created_at(self):
        """Gets the created_at of this Client.  # noqa: E501


        :return: The created_at of this Client.  # noqa: E501
        :rtype: datetime
        """
        return self._created_at

    @created_at.setter
    def created_at(self, created_at):
        """Sets the created_at of this Client.


        :param created_at: The created_at of this Client.  # noqa: E501
        :type: datetime
        """
        if self.local_vars_configuration.client_side_validation and created_at is None:  # noqa: E501
            raise ValueError("Invalid value for `created_at`, must not be `None`")  # noqa: E501

        self._created_at = created_at

    @property
    def updated_at(self):
        """Gets the updated_at of this Client.  # noqa: E501


        :return: The updated_at of this Client.  # noqa: E501
        :rtype: datetime
        """
        return self._updated_at

    @updated_at.setter
    def updated_at(self, updated_at):
        """Sets the updated_at of this Client.


        :param updated_at: The updated_at of this Client.  # noqa: E501
        :type: datetime
        """
        if self.local_vars_configuration.client_side_validation and updated_at is None:  # noqa: E501
            raise ValueError("Invalid value for `updated_at`, must not be `None`")  # noqa: E501

        self._updated_at = updated_at

    @property
    def id(self):
        """Gets the id of this Client.  # noqa: E501


        :return: The id of this Client.  # noqa: E501
        :rtype: str
        """
        return self._id

    @id.setter
    def id(self, id):
        """Sets the id of this Client.


        :param id: The id of this Client.  # noqa: E501
        :type: str
        """
        if self.local_vars_configuration.client_side_validation and id is None:  # noqa: E501
            raise ValueError("Invalid value for `id`, must not be `None`")  # noqa: E501

        self._id = id

    @property
    def name(self):
        """Gets the name of this Client.  # noqa: E501


        :return: The name of this Client.  # noqa: E501
        :rtype: str
        """
        return self._name

    @name.setter
    def name(self, name):
        """Sets the name of this Client.


        :param name: The name of this Client.  # noqa: E501
        :type: str
        """
        if self.local_vars_configuration.client_side_validation and name is None:  # noqa: E501
            raise ValueError("Invalid value for `name`, must not be `None`")  # noqa: E501

        self._name = name

    @property
    def first_party(self):
        """Gets the first_party of this Client.  # noqa: E501


        :return: The first_party of this Client.  # noqa: E501
        :rtype: bool
        """
        return self._first_party

    @first_party.setter
    def first_party(self, first_party):
        """Sets the first_party of this Client.


        :param first_party: The first_party of this Client.  # noqa: E501
        :type: bool
        """
        if self.local_vars_configuration.client_side_validation and first_party is None:  # noqa: E501
            raise ValueError("Invalid value for `first_party`, must not be `None`")  # noqa: E501

        self._first_party = first_party

    @property
    def client_type(self):
        """Gets the client_type of this Client.  # noqa: E501


        :return: The client_type of this Client.  # noqa: E501
        :rtype: ClientType
        """
        return self._client_type

    @client_type.setter
    def client_type(self, client_type):
        """Sets the client_type of this Client.


        :param client_type: The client_type of this Client.  # noqa: E501
        :type: ClientType
        """
        if self.local_vars_configuration.client_side_validation and client_type is None:  # noqa: E501
            raise ValueError("Invalid value for `client_type`, must not be `None`")  # noqa: E501

        self._client_type = client_type

    @property
    def client_id(self):
        """Gets the client_id of this Client.  # noqa: E501


        :return: The client_id of this Client.  # noqa: E501
        :rtype: str
        """
        return self._client_id

    @client_id.setter
    def client_id(self, client_id):
        """Sets the client_id of this Client.


        :param client_id: The client_id of this Client.  # noqa: E501
        :type: str
        """
        if self.local_vars_configuration.client_side_validation and client_id is None:  # noqa: E501
            raise ValueError("Invalid value for `client_id`, must not be `None`")  # noqa: E501

        self._client_id = client_id

    @property
    def client_secret(self):
        """Gets the client_secret of this Client.  # noqa: E501


        :return: The client_secret of this Client.  # noqa: E501
        :rtype: str
        """
        return self._client_secret

    @client_secret.setter
    def client_secret(self, client_secret):
        """Sets the client_secret of this Client.


        :param client_secret: The client_secret of this Client.  # noqa: E501
        :type: str
        """
        if self.local_vars_configuration.client_side_validation and client_secret is None:  # noqa: E501
            raise ValueError("Invalid value for `client_secret`, must not be `None`")  # noqa: E501

        self._client_secret = client_secret

    @property
    def redirect_uris(self):
        """Gets the redirect_uris of this Client.  # noqa: E501


        :return: The redirect_uris of this Client.  # noqa: E501
        :rtype: list[str]
        """
        return self._redirect_uris

    @redirect_uris.setter
    def redirect_uris(self, redirect_uris):
        """Sets the redirect_uris of this Client.


        :param redirect_uris: The redirect_uris of this Client.  # noqa: E501
        :type: list[str]
        """
        if self.local_vars_configuration.client_side_validation and redirect_uris is None:  # noqa: E501
            raise ValueError("Invalid value for `redirect_uris`, must not be `None`")  # noqa: E501

        self._redirect_uris = redirect_uris

    @property
    def authorization_code_lifetime_seconds(self):
        """Gets the authorization_code_lifetime_seconds of this Client.  # noqa: E501


        :return: The authorization_code_lifetime_seconds of this Client.  # noqa: E501
        :rtype: int
        """
        return self._authorization_code_lifetime_seconds

    @authorization_code_lifetime_seconds.setter
    def authorization_code_lifetime_seconds(self, authorization_code_lifetime_seconds):
        """Sets the authorization_code_lifetime_seconds of this Client.


        :param authorization_code_lifetime_seconds: The authorization_code_lifetime_seconds of this Client.  # noqa: E501
        :type: int
        """
        if self.local_vars_configuration.client_side_validation and authorization_code_lifetime_seconds is None:  # noqa: E501
            raise ValueError(
                "Invalid value for `authorization_code_lifetime_seconds`, must not be `None`")  # noqa: E501

        self._authorization_code_lifetime_seconds = authorization_code_lifetime_seconds

    @property
    def access_id_token_lifetime_seconds(self):
        """Gets the access_id_token_lifetime_seconds of this Client.  # noqa: E501


        :return: The access_id_token_lifetime_seconds of this Client.  # noqa: E501
        :rtype: int
        """
        return self._access_id_token_lifetime_seconds

    @access_id_token_lifetime_seconds.setter
    def access_id_token_lifetime_seconds(self, access_id_token_lifetime_seconds):
        """Sets the access_id_token_lifetime_seconds of this Client.


        :param access_id_token_lifetime_seconds: The access_id_token_lifetime_seconds of this Client.  # noqa: E501
        :type: int
        """
        if self.local_vars_configuration.client_side_validation and access_id_token_lifetime_seconds is None:  # noqa: E501
            raise ValueError("Invalid value for `access_id_token_lifetime_seconds`, must not be `None`")  # noqa: E501

        self._access_id_token_lifetime_seconds = access_id_token_lifetime_seconds

    @property
    def refresh_token_lifetime_seconds(self):
        """Gets the refresh_token_lifetime_seconds of this Client.  # noqa: E501


        :return: The refresh_token_lifetime_seconds of this Client.  # noqa: E501
        :rtype: int
        """
        return self._refresh_token_lifetime_seconds

    @refresh_token_lifetime_seconds.setter
    def refresh_token_lifetime_seconds(self, refresh_token_lifetime_seconds):
        """Sets the refresh_token_lifetime_seconds of this Client.


        :param refresh_token_lifetime_seconds: The refresh_token_lifetime_seconds of this Client.  # noqa: E501
        :type: int
        """
        if self.local_vars_configuration.client_side_validation and refresh_token_lifetime_seconds is None:  # noqa: E501
            raise ValueError("Invalid value for `refresh_token_lifetime_seconds`, must not be `None`")  # noqa: E501

        self._refresh_token_lifetime_seconds = refresh_token_lifetime_seconds

    @property
    def tenant_id(self):
        """Gets the tenant_id of this Client.  # noqa: E501


        :return: The tenant_id of this Client.  # noqa: E501
        :rtype: str
        """
        return self._tenant_id

    @tenant_id.setter
    def tenant_id(self, tenant_id):
        """Sets the tenant_id of this Client.


        :param tenant_id: The tenant_id of this Client.  # noqa: E501
        :type: str
        """
        if self.local_vars_configuration.client_side_validation and tenant_id is None:  # noqa: E501
            raise ValueError("Invalid value for `tenant_id`, must not be `None`")  # noqa: E501

        self._tenant_id = tenant_id

    @property
    def tenant(self):
        """Gets the tenant of this Client.  # noqa: E501


        :return: The tenant of this Client.  # noqa: E501
        :rtype: TenantEmbedded
        """
        return self._tenant

    @tenant.setter
    def tenant(self, tenant):
        """Sets the tenant of this Client.


        :param tenant: The tenant of this Client.  # noqa: E501
        :type: TenantEmbedded
        """
        if self.local_vars_configuration.client_side_validation and tenant is None:  # noqa: E501
            raise ValueError("Invalid value for `tenant`, must not be `None`")  # noqa: E501

        self._tenant = tenant

    @property
    def encrypt_jwk(self):
        """Gets the encrypt_jwk of this Client.  # noqa: E501


        :return: The encrypt_jwk of this Client.  # noqa: E501
        :rtype: str
        """
        return self._encrypt_jwk

    @encrypt_jwk.setter
    def encrypt_jwk(self, encrypt_jwk):
        """Sets the encrypt_jwk of this Client.


        :param encrypt_jwk: The encrypt_jwk of this Client.  # noqa: E501
        :type: str
        """

        self._encrypt_jwk = encrypt_jwk

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
        if not isinstance(other, Client):
            return False

        return self.to_dict() == other.to_dict()

    def __ne__(self, other):
        """Returns true if both objects are not equal"""
        if not isinstance(other, Client):
            return True

        return self.to_dict() != other.to_dict()
