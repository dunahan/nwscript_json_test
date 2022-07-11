// from Lokey, found on the nwn-vault discord, 10.07.2022  01:17


#include "nw_inc_gff"

void main()
{
  object oArea = GetAreaFromLocation(GetStartingLocation());
  json jArea = ObjectToJson(oArea);
  
  jArea = GffReplaceInt(jArea, "ARE/Value/Heigth", 20);
  jArea = GffReplaceInt(jArea, "ARE/Value/Width", 20);
  jArea = GffReplaceResRef(jArea, "ARE/Value/Tileset", "tcn01");
  
  json jTileList = JsonArray();
  intnTile, nNumTiles = 20 * 20;
  for (nTile = 0; nTile < nNumTiles; nTile++)
  {
    jTileList = JsonArrayInsert(jTileList, GffAddInt(JsonObject(), "Tile_ID", nTile));
  }
  
  jArea = GffReplaceList(jArea, "ARE/value/Tile_List", jTileList);
  oArea = JsonToObject(jArea, GetStartingLocation());
}
