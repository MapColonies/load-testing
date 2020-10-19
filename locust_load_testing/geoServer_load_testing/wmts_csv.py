from locust import TaskSet, task, HttpLocust
import pandas as pd
# params_data = pd.read_csv("wmts-params-5k.csv")
# iter_params = params_data.iterrows()
# csv_data_iter = iter_params

VERSION = "1.0.0"
LAYER = "cite:BlueMarbleNG-TB_2004-12-01_rgb_1440x720"
WMTS_URL = "/geoserver/gwc/service/wmts"
REQUEST= "GetTile"
SERVICE = "WMTS"
STYLE = ""
FORMAT = "image/png"
TILEMATRIXSET = "EPSG:4326"


class UserBehaviour(TaskSet):

    def on_start(self):
        self.params_data = pd.read_csv("wmts-params-5k.csv")
        self.iter_params = self.params_data.iterrows()
        self.csv_data_iter = self.iter_params

    @task
    def launch_url(self):
        try:
            self.data = self.csv_data_iter.__next__()


        except StopIteration:
            self.csv_data_iter = self.iter_params
            self.data = self.csv_data_iter.__next__()

        self.tile_matrix = str(self.data[1]['TileMatrix'])
        self.TileCol = str(self.data[1]['TileCol'])
        self.TileRow = str(self.data[1]['TileRow'])
        self.client.get("/geoserver/gwc/service/wmts?REQUEST=GetTile&SERVICE="+SERVICE+"&VERSION="+VERSION+"&LAYER="+LAYER+"&STYLE="+STYLE+"&TILEMATRIXSET="+TILEMATRIXSET+"&TILEMATRIX="+self.tile_matrix+"&TileCol="+self.TileCol+"&TileRow="+self.TileRow+"&FORMAT="+FORMAT)

class User(HttpLocust):
    task_set = UserBehaviour
    min_wait = 500
    max_wait = 500

    host = "http://localhost:8080"

