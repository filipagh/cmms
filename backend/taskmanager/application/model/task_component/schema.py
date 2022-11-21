import uuid

from pydantic import BaseModel

from taskmanager.domain.model.task_component_state import TaskComponentState


class TaskComponentSchemaBASE(BaseModel):
    pass



class TaskComponentAddNewSchema(TaskComponentSchemaBASE):
    new_asset_id: uuid.UUID
    pass

class TaskComponentRemoveNewSchema(TaskComponentSchemaBASE):
    assigned_component_id: uuid.UUID
    pass


class TaskComponentIdSchema(BaseModel):
    id: uuid.UUID


class TaskComponentSchema(TaskComponentIdSchema, TaskComponentSchemaBASE):
    assigned_component: uuid.UUID
    action_id: uuid.UUID
    state: TaskComponentState
