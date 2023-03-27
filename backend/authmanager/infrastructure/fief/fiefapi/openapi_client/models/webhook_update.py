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


class WebhookUpdate(object):
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
        'url': 'str',
        'events': 'list[WebhookEventType]'
    }

    attribute_map = {
        'url': 'url',
        'events': 'events'
    }

    def __init__(self, url=None, events=None, local_vars_configuration=None):  # noqa: E501
        """WebhookUpdate - a model defined in OpenAPI"""  # noqa: E501
        if local_vars_configuration is None:
            local_vars_configuration = Configuration()
        self.local_vars_configuration = local_vars_configuration

        self._url = None
        self._events = None
        self.discriminator = None

        if url is not None:
            self.url = url
        if events is not None:
            self.events = events

    @property
    def url(self):
        """Gets the url of this WebhookUpdate.  # noqa: E501


        :return: The url of this WebhookUpdate.  # noqa: E501
        :rtype: str
        """
        return self._url

    @url.setter
    def url(self, url):
        """Sets the url of this WebhookUpdate.


        :param url: The url of this WebhookUpdate.  # noqa: E501
        :type: str
        """
        if (self.local_vars_configuration.client_side_validation and
                url is not None and len(url) > 2083):
            raise ValueError("Invalid value for `url`, length must be less than or equal to `2083`")  # noqa: E501
        if (self.local_vars_configuration.client_side_validation and
                url is not None and len(url) < 1):
            raise ValueError("Invalid value for `url`, length must be greater than or equal to `1`")  # noqa: E501

        self._url = url

    @property
    def events(self):
        """Gets the events of this WebhookUpdate.  # noqa: E501


        :return: The events of this WebhookUpdate.  # noqa: E501
        :rtype: list[WebhookEventType]
        """
        return self._events

    @events.setter
    def events(self, events):
        """Sets the events of this WebhookUpdate.


        :param events: The events of this WebhookUpdate.  # noqa: E501
        :type: list[WebhookEventType]
        """

        self._events = events

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
        if not isinstance(other, WebhookUpdate):
            return False

        return self.to_dict() == other.to_dict()

    def __ne__(self, other):
        """Returns true if both objects are not equal"""
        if not isinstance(other, WebhookUpdate):
            return True

        return self.to_dict() != other.to_dict()
