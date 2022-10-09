import uuid
from typing import List, Optional

from eventsourcing.domain import Aggregate, event


class Dog(Aggregate):
    class Registered(Aggregate.Created):
        asset_category_id: uuid.UUID
        name: str
        description: str


    @event(Registered)
    def __init__(self, asset_category_id: uuid.UUID, name: str, description: Optional[str]):
        self.asset_category_id: uuid.UUID = asset_category_id
        self.name: str = name
        self.description: str = description


from typing import Any, Dict
from uuid import UUID

from eventsourcing.application import Application



class DogSchool(Application):
    is_snapshotting_enabled = True

    def add_new_asset(self, asset_category_id: uuid.UUID, name: str, description: Optional[str]):
        asset = Dog(asset_category_id, name, description)
        self.save(asset)
        return asset.id



    def get_dog(self, dog_id: UUID):
        dog: Dog = self.repository.get(dog_id)
        return dog

from unittest import TestCase




class TestDogSchool(TestCase):
    def test_dog_school(self) -> None:
        # Construct application object.
        school = DogSchool()

        # Evolve application state.
        dog_id = school.add_new_asset(uuid.uuid4(),"deddd",None)

        # Query application state.
        dog = school.get_dog(dog_id)
        a=4