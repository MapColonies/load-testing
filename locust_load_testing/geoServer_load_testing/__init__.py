import pandas as pd
params_data = pd.read_csv("wmts-params-5k.csv")
iter_params = params_data.iterrows()

x = iter_params




VERSION = "1.0.0"
LAYER = "cite:BlueMarbleNG-TB_2004-12-01_rgb_1440x720"
WMTS_URL = "/geoserver/gwc/service/wmts"
REQUEST= "GetTile"
SERVICE = "WMTS"
STYLE = ""
FORMAT = "image/png"



data  = iter_params.__next__()
tile_matrix = str(data[1]['TileMatrix'])
TileCol = str(data[1]['TileCol'])
TileRow = str(data[1]['TileRow'])

get_url = WMTS_URL+"?REQUEST="+REQUEST+"&SERVICE="+SERVICE+"&VERSION="+VERSION+"&LAYER="+LAYER+"&STYLE="+STYLE+"&TILEMATRIX="+self.tile_matrix+"&TileCol="+self.TileCol+"&TileRow="+self.TileRow+"&FORMAT="+FORMAT
# self.client.get("/geoserver/gwc/service/wmts?REQUEST=getCapabilities")
