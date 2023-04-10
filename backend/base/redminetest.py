from redminelib import Redmine
from redminelib.resources import Project


# pridanie note
# issue: Issue = projekt.issues[0]
#
# journals  = issue.journals
# note=  redmine.issue.update(1,notes='moja notes')


def load_custom_fields():
    custom_fields = redmine.custom_field.all()
    return custom_fields


# load users from project in redmine
def load_users(project_id):
    users = redmine.project_membership.filter(project_id=project_id)
    return users


# load issue cattegory from redmine
def load_issue_category(project_id):
    issue_categories = redmine.issue_category.filter(project_id=project_id)
    return issue_categories


# create function to create redmine issue
def create_issue(project_id, subject, description, priority_id, tracker_id, assigned_to_id, category_id):
    issue = redmine.issue.new()
    issue.custom_fields = ({'id': 1, 'value': '1'}, {'id': 2, 'value': 'www.google.sk'})
    issue.project_id = project_id
    issue.subject = subject
    issue.description = description
    issue.priority_id = priority_id
    issue.tracker_id = tracker_id
    issue.assigned_to_id = assigned_to_id
    issue.category_id = category_id
    issue.save()
    return issue


redmine: Redmine = Redmine('http://localhost:3000', version='5.0.5', key='6c129bfb76088fec637a4d498e8d2f07cca18def')
a = redmine.project
projekt: Project = redmine.project.get("projekt")
id = projekt.id

v = load_custom_fields()
print(v)

u = load_users(id)

create_issue(id, "test", "test", 1, 1, 1, 10)
