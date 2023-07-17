from eventsourcing.dispatch import singledispatchmethod
from eventsourcing.system import ProcessApplication

from assetmanager.domain.model.asset import Asset
from assetmanager.infrastructure.persistance import asset_repo
from assetmanager.infrastructure.persistance.asset_repo import AssetModel, AssetTelemetryModel


class AssetProjector(ProcessApplication):
    @singledispatchmethod
    def policy(self, domain_event, process_event):
        """Default policy"""

    @policy.register(Asset.Created)
    def _(self, domain_event: Asset.Created, process_event):
        telemetry_col = []
        for i in domain_event.telemetry:
            telemetry_col.append(AssetTelemetryModel(
                asset_id=domain_event.originator_id,
                type=i.type,
                value=i.value
            ))

        asset_repo.save_new(
            AssetModel(id=domain_event.originator_id,
                       category_id=domain_event.asset_category_id,
                       name=domain_event.name,
                       description=domain_event.description,
                       telemetry=telemetry_col,
                       is_archived=False))

    @policy.register(Asset.Archived)
    def _(self, domain_event: Asset.Archived, process_event):
        model = asset_repo.get_asset_by_id(domain_event.originator_id)
        model.is_archived = True
        asset_repo.save(model)
