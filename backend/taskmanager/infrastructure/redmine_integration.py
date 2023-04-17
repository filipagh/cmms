import os
from typing import Optional

from redminelib import Redmine
from redminelib.exceptions import ResourceNotFoundError

from base.appsettings.settings_enum import SettingsEnum
from base.appsettings.settings_repo import SettingsRepo
from taskmanager.application.model.redmine_integration.schema import RedmineAuthSchema, RedmineAuthResponseSchema, \
    RedmineObjectSchema, RedmineSetupRequestSchema, RedmineIssueDataSchema, RedmineCommentDataSchema

ODKAZ_NA_CMMS = 'Odkaz na CMMS'
SUPER_VYSOR = 'Supervízor'


def _redmine_connect():
    redmine_url = SettingsRepo().get_settings(key=SettingsEnum.redmine_url)
    redmine_api_key = SettingsRepo().get_settings(key=SettingsEnum.redmine_api_key)
    return Redmine(redmine_url, key=redmine_api_key, requests={'verify': False})


def redmine_auth(auth: RedmineAuthSchema) -> RedmineAuthResponseSchema:
    try:
        redmine = Redmine(auth.redmine_url, key=auth.redmine_api_key, requests={'verify': False})
        projects = list(redmine.project.all())
    except Exception as e:
        raise Exception("Invalid login: " + e.__str__(), e)
    trackers = list(redmine.tracker.all())
    users = list(redmine.user.all())

    projects = [RedmineObjectSchema(id=project.id, name=project.name) for project in projects]
    trackers = [RedmineObjectSchema(id=tracker.id, name=tracker.name) for tracker in trackers]
    users = [RedmineObjectSchema(id=user.id, name=(user.firstname + " " + user.lastname)) for user in users]

    return RedmineAuthResponseSchema(redmine_url=auth.redmine_url, redmine_api_key=auth.redmine_api_key,
                                     projects=projects, trackers=trackers, users=users)


def redmine_setup(auth: RedmineSetupRequestSchema):
    redmine = Redmine(auth.redmine_url, key=auth.redmine_api_key, requests={'verify': False})
    # check if project exists
    try:
        project = redmine.project.get(auth.redmine_project_id)
    except ResourceNotFoundError:
        raise Exception("Invalid redmine project id")
    try:
        is_tracker_in_project = False
        for t in list(project.trackers):
            if t.id == int(auth.redmine_tracker_id):
                is_tracker_in_project = True
                break

        if not is_tracker_in_project:
            raise Exception("Tracker is not allowed in selected project")
    except:
        raise Exception("Tracker is not allowed in selected project")

    is_supervisor_in_project = False
    for u in list(project.memberships):
        if u.user.id == int(auth.redmine_supervisor_id):
            is_supervisor_in_project = True
            break
    if not is_supervisor_in_project:
        raise Exception("Selected supervisor is not in selected project")

    # validate redmine custom field if exists for project and tracker
    custom_fields = _load_custom_fields(redmine)
    validate_custom_field(auth, project, custom_fields, ODKAZ_NA_CMMS)
    validate_custom_field(auth, project, custom_fields, SUPER_VYSOR)

    SettingsRepo().set_setting(SettingsEnum.redmine_url, auth.redmine_url)
    SettingsRepo().set_setting(SettingsEnum.redmine_api_key, auth.redmine_api_key)
    SettingsRepo().set_setting(SettingsEnum.redmine_project_id, auth.redmine_project_id)
    SettingsRepo().set_setting(SettingsEnum.redmine_tracker_id, auth.redmine_tracker_id)
    SettingsRepo().set_setting(SettingsEnum.redmine_supervisor_id, auth.redmine_supervisor_id)
    SettingsRepo().set_setting(SettingsEnum.redmine_feature, True)


def validate_custom_field(auth, project, custom_fields, custom_field_name):
    for field in custom_fields:
        if field.name == custom_field_name:
            for t in list(field.trackers):
                if t.id == int(auth.redmine_tracker_id):
                    for p in list(project.issue_custom_fields):
                        if p.id == field.id:
                            return
                    raise Exception("Custom field " + custom_field_name + " is not allowed in selected project")
    raise Exception("Custom field " + custom_field_name + " is not allowed in selected tracker")


def redmine_disable():
    SettingsRepo().set_setting(SettingsEnum.redmine_feature, False)
    SettingsRepo().set_setting(SettingsEnum.redmine_url, "")


def setup_redmine():
    redmine = _redmine_connect()
    _load_custom_fields(redmine)
    _load_or_create_redmine_category(redmine, 'test')


def _load_custom_fields(redmine):
    custom_fields = redmine.custom_field.all()
    return list(custom_fields)


def _load_or_create_redmine_category(redmine, project_id, category_name):
    categories = list(redmine.issue_category.filter(project_id=project_id))
    category = None
    for c in categories:
        if c.name == category_name:
            category = c

    if category is None:
        category = redmine.issue_category.new()
        category.name = category_name
        category.project_id = project_id
        category.save()

    return category


def is_redmine_active():
    return SettingsRepo().get_settings(key=SettingsEnum.redmine_feature) == 'true'


def create_issue(task_id, subject, description, assigned_to_id, category_name) -> str:
    redmine = _redmine_connect()
    link_to_cmms_id = None
    supervisor_id = None

    for cf in _load_custom_fields(redmine):
        if cf.name == ODKAZ_NA_CMMS:
            link_to_cmms_id = cf.id
        if cf.name == SUPER_VYSOR:
            supervisor_id = cf.id

    if link_to_cmms_id is None or supervisor_id is None:
        raise Exception('Redmine custom fields not found')

    project_id = SettingsRepo().get_settings(key=SettingsEnum.redmine_project_id)
    supervisor_user_id = SettingsRepo().get_settings(key=SettingsEnum.redmine_supervisor_id)
    category_id = _load_or_create_redmine_category(redmine, project_id, category_name).id
    cmms_url = os.environ.get('FE_URL') + '/task/' + str(task_id)

    issue = redmine.issue.new()
    issue.custom_fields = ({'id': supervisor_id, 'value': supervisor_user_id}, {'id': link_to_cmms_id, 'value': cmms_url})

    issue.project_id = project_id
    issue.subject = subject
    issue.description = description
    issue.priority_id = 1
    issue.tracker_id = SettingsRepo().get_settings(key=SettingsEnum.redmine_tracker_id)
    issue.category_id = category_id
    issue.save()
    return issue.id


def _get_issue_from_redmine(issue_id):
    redmine = _redmine_connect()
    try:
        return redmine.issue.get(int(issue_id))
    except:
        return None


def add_note_to_issue(issue_id, note):
    issue = _get_issue_from_redmine(issue_id)
    if issue is None:
        return

    issue.notes = note
    issue.save()


def get_issue(issue_id) -> Optional[RedmineIssueDataSchema]:
    issue = _get_issue_from_redmine(issue_id)
    if issue is None:
        return None
    notes = _get_notes_from_issue(issue)
    try:
        assigned_to_name = issue.assigned_to.name
    except:
        assigned_to_name = ""
    return RedmineIssueDataSchema(task_id=issue_id, description=issue.description, assigned_to=assigned_to_name,
                                  link_to_redmine=issue.url, comments=notes)


def _get_notes_from_issue(issue):
    notes = []
    for journal in issue.journals:
        if journal.notes == '':
            continue
        notes.append(RedmineCommentDataSchema(
            author=journal.user.name,
            created_on=journal.created_on,
            comment=journal.notes))
    return notes


def complete_issue(issue_id):
    issue = _get_issue_from_redmine(int(issue_id))
    if issue is None:
        return
    issue.status_id = 3
    issue.save()


def close_issue(issue_id):
    issue = _get_issue_from_redmine(int(issue_id))
    if issue is None:
        return
    issue.status_id = 5
    issue.save()
