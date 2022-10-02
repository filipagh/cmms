a=0
while True:
    print(a)
    a = a+1
# # import json
# # from typing import Union, cast, List, Dict, Any
# # from uuid import UUID
# #
# # from eventsourcing import application
# # from eventsourcing.application import Application
# # from eventsourcing.dispatch import singledispatchmethod
# # from eventsourcing.domain import Aggregate, event
# # from eventsourcing.persistence import Transcoding, Transcoder
# # from eventsourcing.utils import register_topic
# #
# #
# # class Dog(Aggregate):
# #     class Event(Aggregate.Event):
# #         def apply(self, aggregate: Aggregate) -> None:
# #             cast(Dog, aggregate).apply(self)
# #
# #     class Registered(Event, Aggregate.Created):
# #         name: str
# #
# #     class TrickAdded(Event):
# #         trick: str
# #
# #     @classmethod
# #     def register(cls, name: str) -> "Dog":
# #         return cls._create(cls.Registered, name=name)
# #
# #     def add_trick(self, trick: str) -> None:
# #         self.trigger_event(self.TrickAdded, trick=trick)
# #
# #     @singledispatchmethod
# #     def apply(self, event: Event) -> None:
# #         """Applies event to aggregate."""
# #
# #     @apply.register
# #     def _(self, event: Registered) -> None:
# #         self.name = event.name
# #         self.tricks: List[str] = []
# #
# #     @apply.register
# #     def _(self, event: TrickAdded) -> None:
# #         self.tricks.append(event.trick)
# #
# # register_topic("__main__:Dogg", Dog)
# #
# #
# #
# # class DogSchool(Application):
# #     is_snapshotting_enabled = True
# #
# #     def register_dog(self, name: str) -> UUID:
# #         dog = Dog.register(name=name)
# #         self.save(dog)
# #         return dog.id
# #
# #     def add_trick(self, dog_id: UUID, trick: str) -> None:
# #         dog: Dog = self.repository.get(dog_id)
# #         dog.add_trick(trick)
# #         self.save(dog)
# #
# #     def get_dog(self, dog_id: UUID) -> Dict[str, Any]:
# #         dog: Dog = self.repository.get(dog_id)
# #         return {"name": dog.name, "tricks": tuple(dog.tricks)}
# #
# # app = DogSchool()
# # app.get_dog('57fd74d5-2719-4c96-9976-7753c20ae19f')
# #
# #
# # notifications = app.notification_log.select(
# #     start=1, limit=10
# # )
# #
# #
# # a =4
#
#
# from eventsourcing.system import System, SingleThreadedRunner, MultiThreadedRunner
#
# from uuid import uuid4
#
# from eventsourcing.domain import Aggregate, event
#
# class Dog(Aggregate):
#     class Registered(Aggregate.Created):
#             name: str
#
#     @event(Registered)
#     def __init__(self, name):
#         self.name = name
#         self.tricks = []
#
#     class TrickAdded(Aggregate.Event):
#         trick: str
#
#     @event(TrickAdded)
#     def add_trick(self, trick):
#         self.tricks.append(trick)
#
# # Now let’s define an application…
#
# from eventsourcing.application import Application, LocalNotificationLog
#
#
# class DogSchool(Application):
#     def register_dog(self, name):
#         dog = Dog(name)
#         self.save(dog)
#         return dog.id
#
#     def add_trick(self, dog_id, trick):
#         dog = self.repository.get(dog_id)
#         dog.add_trick(trick)
#         self.save(dog)
#
#     def get_dog(self, dog_id):
#         dog = self.repository.get(dog_id)
#         return {'name': dog.name, 'tricks': tuple(dog.tricks)}
#
# # Now let’s define an analytics application…
#
# from uuid import uuid5, NAMESPACE_URL
#
# class Counter(Aggregate):
#     def __init__(self, name):
#         self.name = name
#         self.count = 0
#
#     @classmethod
#     def create_id(cls, name):
#         return uuid5(NAMESPACE_URL, f'/counters/{name}')
#
#     class Incremented(Aggregate.Event):
#         pass
#
#     @event(Incremented)
#     def increment(self):
#         self.count += 1
#
# from eventsourcing.application import AggregateNotFound
# from eventsourcing.system import ProcessApplication
# from eventsourcing.dispatch import singledispatchmethod
#
# class Counters(ProcessApplication):
#     @singledispatchmethod
#     def policy(self, domain_event, process_event):
#         """Default policy"""
#
#     @policy.register(Dog.TrickAdded)
#     def _(self, domain_event, process_event):
#         trick = domain_event.trick
#         try:
#             counter_id = Counter.create_id(trick)
#             counter = self.repository.get(counter_id)
#         except AggregateNotFound:
#             counter = Counter(trick)
#         counter.increment()
#         process_event.collect_events(counter)
#
#     def get_count(self, trick):
#         counter_id = Counter.create_id(trick)
#         try:
#             counter = self.repository.get(counter_id)
#         except AggregateNotFound:
#             return 0
#         return counter.count
#
#
# class Countersss(ProcessApplication):
#     @singledispatchmethod
#     def policy(self, domain_event, process_event):
#         """Default policy"""
#
#     @policy.register(Counter.Incremented)
#     def _(self, domain_event, process_event):
#         trick = domain_event
#         # try:
#         #     counter_id = Counter.create_id(trick)
#         #     counter = self.repository.get(counter_id)
#         # except AggregateNotFound:
#         #     counter = Counter(trick)
#         # counter.increment()
#         # process_event.collect_events(counter)
#
#     # def get_count(self, trick):
#     #     counter_id = Counter.create_id(trick)
#     #     try:
#     #         counter = self.repository.get(counter_id)
#     #     except AggregateNotFound:
#     #         return 0
#     #     return counter.count
#
# system = System(pipes=[[DogSchool, Counters],[Counters,Countersss]])
#
#
# runner = SingleThreadedRunner(system)
# runner.start()
#
# school = runner.get(DogSchool)
# counters = runner.get(Counters)
#
#
#
# dog_id1 = school.register_dog('Billy')
# dog_id2 = school.register_dog('Milly')
# dog_id3 = school.register_dog('Scrappy')
#
# school.add_trick(dog_id1, 'roll over')
# school.add_trick(dog_id2, 'roll over')
# school.add_trick(dog_id3, 'roll over')
#
#
# school.add_trick(dog_id1, 'fetch ball')
# school.add_trick(dog_id2, 'fetch ball')
#
#
# school.add_trick(dog_id1, 'play dead')
#
# # a= LocalNotificationLog().select(0,10)
# a=4
# a=4
# a=4
# a=4
# runner.stop()