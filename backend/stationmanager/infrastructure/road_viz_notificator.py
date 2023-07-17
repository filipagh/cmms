import json
import logging
import os
import uuid

import requests

from stationmanager.domain.model.assigned_component import AssignedComponentState


def send_sync_cmms(station_id: uuid.UUID, component_id: uuid.UUID, status: AssignedComponentState):
    return
    # not used anymore todo remove env configs and setting

    if os.environ["ROAD_VIZ_API_KEY"] != "" and os.environ["ROAD_VIZ_API_KEY"] is not None:
        try:
            url = os.environ["ROAD_VIZ_URL_SYNC"]
            headers = {'Content-Type': 'application/json'}
            data = json.dumps([station_id.__str__(), component_id.__str__(), status.value])
            cookies = {"apiKey": os.environ["ROAD_VIZ_API_KEY"]}
            requests.post(url, headers=headers, data=data, cookies=cookies)
        except Exception as e:
            logging.log(logging.ERROR, "Error while syncing with RoadViz " + e.__str__())
