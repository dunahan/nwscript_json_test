object GetAreaByTag(string sTag)
{
  object oArea = GetFirstArea();
  while (GetIsObjectValid(oArea))
  {
    if (GetTag(oArea) == sTag)
      return oArea;

    oArea = GetNextArea();
  }

  return OBJECT_INVALID;
}

// this gets a specific area by tag and encodes to a json string

void main()
{
  if (!GetIsPC(GetEnteringObject()))  return;

  json jArea = ObjectToJson(GetAreaByTag("_temp_"), TRUE);
  SendMessageToPC(GetFirstPC(), GetName(GetAreaByTag("_temp_")) +"|"+ JsonDump(jArea));
}
