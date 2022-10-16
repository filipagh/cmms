from storagemanager.infrastructure.persistance import storage_item_repo
from storagemanager.infrastructure.persistance.storage_item_repo import StorageItemModel


def load_all_storage_items() -> list[StorageItemModel]:
    return storage_item_repo.get_storage_items()

