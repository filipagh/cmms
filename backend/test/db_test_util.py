import os
from time import sleep

import alembic.config
from sqlalchemy_utils import drop_database, create_database

from base.database import get_db_link, close_sessions
from base.main import import_settings


def db_app_setup():
    drop_database(get_db_link())

    create_database(get_db_link())

    os.chdir(os.path.dirname(__file__) + '/../../backend')

    alembicArgs = [
        '-c', 'alembic.ini',
        'upgrade', 'head',
    ]
    alembic.config.main(argv=alembicArgs)
    sleep(4)
    close_sessions()

    import_settings()
def db_app_clean():
    close_sessions()
    drop_database(get_db_link())
    create_database(get_db_link())
