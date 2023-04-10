from pydantic import BaseModel

from base.appsettings.settings_enum import SettingsEnum


class SettingSchema(BaseModel):
    key: SettingsEnum
    enabled: bool
    value: str
