#include "nw_inc_gff"

void main()
{
  json jArea, jObject, jValue, jArray, jGff;
  object oObject, oArea = GetFirstArea(), oPC = GetFirstPC();
  
  while (GetIsObjectValid(oArea))
  {
    // translate area (GIT) to json
    jArea = ObjectToJson(oArea);
    
    // if this json contains the vartable list continue
    if (GffGetFieldExists(jArea, "GIT/value/VarTable"))
    {
      // get the gff list as array?
      jArray = GffGetList(jArea, "VarTable");
      SendMessageToPC(oPC, JsonDump(jArray));   // dump that array?
      
      /*  so we can later dump these vars like
          Test_Float=float=50
          Test_Int=int=100
          Test_String=string=String_Test  */
    }
    
    // later, scan the area containing objects
    
    // else get next area...
    oArea = GetNextArea();
  }
  
  // after that scan blueprints eventually?
}
