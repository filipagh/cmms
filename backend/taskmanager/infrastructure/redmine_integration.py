from redminelib import Redmine

from base.appsettings.settings_enum import SettingsEnum
from base.appsettings.settings_repo import SettingsRepo
from taskmanager.application.model.redmine_integration.schema import RedmineAuthSchema, RedmineAuthResponseSchema, \
    RedmineObjectSchema, RedmineSetupRequestSchema


def _redmine_connect():
    redmine_url = SettingsRepo().get_settings(key=SettingsEnum.redmine_url)
    redmine_api_key = SettingsRepo().get_settings(key=SettingsEnum.redmine_api_key)
    return Redmine(redmine_url, version='5.0.5', key=redmine_api_key)


def redmine_auth(auth: RedmineAuthSchema) -> RedmineAuthResponseSchema:
    redmine = Redmine(auth.redmine_url, version='5.0.5', key=auth.redmine_api_key)
    projects = list(redmine.project.all())
    trackers = list(redmine.tracker.all())
    users = list(redmine.user.all())

    projects = [RedmineObjectSchema(id=project.id, name=project.name) for project in projects]
    trackers = [RedmineObjectSchema(id=tracker.id, name=tracker.name) for tracker in trackers]
    users = [RedmineObjectSchema(id=user.id, name=(user.firstname + " " + user.lastname)) for user in users]

    return RedmineAuthResponseSchema(projects=projects, trackers=trackers, users=users)


def redmine_setup(auth: RedmineSetupRequestSchema):
    SettingsRepo().set_setting(SettingsEnum.redmine_url, auth.redmine_url)
    SettingsRepo().set_setting(SettingsEnum.redmine_api_key, auth.redmine_api_key)
    SettingsRepo().set_setting(SettingsEnum.redmine_project_id, auth.redmine_project_id)
    SettingsRepo().set_setting(SettingsEnum.redmine_tracker_id, auth.redmine_tracker_id)
    SettingsRepo().set_setting(SettingsEnum.redmine_supervisor_id, auth.redmine_supervisor_id)
    SettingsRepo().set_setting(SettingsEnum.redmine_feature, True)


def setup_redmine():
    redmine = _redmine_connect()
    _load_custom_fields(redmine)
    _load_or_create_redmine_category(redmine, 'test')


def _load_custom_fields(redmine):
    custom_fields = redmine.custom_field.all()
    return list(custom_fields)


def _load_or_create_redmine_category(redmine, project_id, category_name):
    category = list(redmine.issue_category.filter(project_id=project_id, name=category_name))
    if len(category) == 0:
        category = redmine.issue_category.new()
        category.name = category_name
        category.save()
    else:
        category = category[0]
    return category


def is_redmine_active():
    return bool(SettingsRepo().get_settings(key=SettingsEnum.redmine_feature))


def create_issue(subject, description, assigned_to_id, category_name) -> str:
    redmine = _redmine_connect()
    link_to_cmms_id = None
    supervisor_id = None

    for cf in _load_custom_fields(redmine):
        if cf.name == 'Odkaz na CMMS':
            link_to_cmms_id = cf.id
        if cf.name == 'Supervízor':
            supervisor_id = cf.id

    if link_to_cmms_id is None or supervisor_id is None:
        raise Exception('Redmine custom fields not found')

    project_id = SettingsRepo().get_settings(key=SettingsEnum.redmine_project_id)
    category_id = _load_or_create_redmine_category(redmine, project_id, category_name).id

    issue = redmine.issue.new()
    issue.custom_fields = ({'id': supervisor_id, 'value': '1'}, {'id': link_to_cmms_id, 'value': 'www.google.sk'})

    issue.project_id = project_id
    issue.subject = subject
    issue.description = description
    issue.priority_id = 1
    issue.tracker_id = SettingsRepo().get_settings(key=SettingsEnum.redmine_tracker_id)
    issue.assigned_to_id = assigned_to_id
    issue.category_id = category_id
    issue.save()
    return issue.id
