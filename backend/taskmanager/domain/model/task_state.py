from enum import Enum


class TaskState(str, Enum):
    OPEN = "open",
    READY = "ready",
    DONE = "done",
    REMOVED = "removed",
