from enum import Enum


class TaskComponentState(str, Enum):
    AWAITING = "awaiting",
    ALLOCATED = "allocated",
    INSTALLED = "installed",
    REMOVED = "removed"