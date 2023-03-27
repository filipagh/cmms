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


class WebhookEventType(object):
    """NOTE: This class is auto generated by OpenAPI Generator.
    Ref: https://openapi-generator.tech

    Do not edit the class manually.
    """

    """
    allowed enum values
    """
    CLIENT_CREATED = "client.created"
    CLIENT_UPDATED = "client.updated"
    CLIENT_DELETED = "client.deleted"
    EMAIL_TEMPLATE_UPDATED = "email_template.updated"
    OAUTH_PROVIDER_CREATED = "oauth_provider.created"
    OAUTH_PROVIDER_UPDATED = "oauth_provider.updated"
    OAUTH_PROVIDER_DELETED = "oauth_provider.deleted"
    PERMISSION_CREATED = "permission.created"
    PERMISSION_UPDATED = "permission.updated"
    PERMISSION_DELETED = "permission.deleted"
    ROLE_CREATED = "role.created"
    ROLE_UPDATED = "role.updated"
    ROLE_DELETED = "role.deleted"
    TENANT_CREATED = "tenant.created"
    TENANT_UPDATED = "tenant.updated"
    TENANT_DELETED = "tenant.deleted"
    USER_CREATED = "user.created"
    USER_UPDATED = "user.updated"
    USER_DELETED = "user.deleted"
    USER_FORGOT_PASSWORD_REQUESTED = "user.forgot_password_requested"
    USER_PASSWORD_RESET = "user.password_reset"
    USER_FIELD_CREATED = "user_field.created"
    USER_FIELD_UPDATED = "user_field.updated"
    USER_FIELD_DELETED = "user_field.deleted"
    USER_PERMISSION_CREATED = "user_permission.created"
    USER_PERMISSION_DELETED = "user_permission.deleted"
    USER_ROLE_CREATED = "user_role.created"
    USER_ROLE_DELETED = "user_role.deleted"

    allowable_values = [CLIENT_CREATED, CLIENT_UPDATED, CLIENT_DELETED, EMAIL_TEMPLATE_UPDATED, OAUTH_PROVIDER_CREATED,
                        OAUTH_PROVIDER_UPDATED, OAUTH_PROVIDER_DELETED, PERMISSION_CREATED, PERMISSION_UPDATED,
                        PERMISSION_DELETED, ROLE_CREATED, ROLE_UPDATED, ROLE_DELETED, TENANT_CREATED, TENANT_UPDATED,
                        TENANT_DELETED, USER_CREATED, USER_UPDATED, USER_DELETED, USER_FORGOT_PASSWORD_REQUESTED,
                        USER_PASSWORD_RESET, USER_FIELD_CREATED, USER_FIELD_UPDATED, USER_FIELD_DELETED,
                        USER_PERMISSION_CREATED, USER_PERMISSION_DELETED, USER_ROLE_CREATED,
                        USER_ROLE_DELETED]  # noqa: E501

    """
    Attributes:
      openapi_types (dict): The key is attribute name
                            and the value is attribute type.
      attribute_map (dict): The key is attribute name
                            and the value is json key in definition.
    """
    openapi_types = {
    }

    attribute_map = {
    }

    def __init__(self, local_vars_configuration=None):  # noqa: E501
        """WebhookEventType - a model defined in OpenAPI"""  # noqa: E501
        if local_vars_configuration is None:
            local_vars_configuration = Configuration()
        self.local_vars_configuration = local_vars_configuration
        self.discriminator = None

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
        if not isinstance(other, WebhookEventType):
            return False

        return self.to_dict() == other.to_dict()

    def __ne__(self, other):
        """Returns true if both objects are not equal"""
        if not isinstance(other, WebhookEventType):
            return True

        return self.to_dict() != other.to_dict()