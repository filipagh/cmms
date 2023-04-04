from sqlalchemy import Column, String

import base
from base.appsettings.settings_enum import SettingsEnum
from base.database import Base


class SettingsRepo:
    def get_settings(self, key: SettingsEnum) -> str:
        with base.database.get_db() as db:
            return db.query(SettingModel).filter(SettingModel.key == key.name).first().value

    def set_setting(self, key: SettingsEnum, value):
        with base.database.get_db() as db:
            setting = db.query(SettingModel).filter(SettingModel.key == key.name).first()
            if setting is None:
                setting = SettingModel(key=key.name, value=value)
                db.add(setting)
            else:
                setting.value = value
            db.commit()


class SettingModel(Base):
    __tablename__ = "settings"
    key = Column(String, primary_key=True, index=True)
    value = Column(String)
