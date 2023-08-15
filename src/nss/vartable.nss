void main()
{
  string sDump, sError; int nLength, i, n;
  json jValue, jArray, jFull, jName, jType, jVarVal;
  object oObject, oArea = GetFirstArea(), oPC = GetFirstPC();

  while (GetIsObjectValid(oArea))
  {
    // first translate the object to json
    jValue = ObjectToJson(oArea);

    // now we can get the structure
    jValue = JsonPointer(jValue, "/GIT/value/VarTable/value");
    // how many items are in there?
    nLength = JsonGetLength(jValue);

    // loop every item
    for (i = 0; i<nLength; ++i)
    {
      jFull = JsonArrayGet(jValue, i);  // get the actual entry
      sError = JsonGetError(jFull);     // are there any errors?

      sDump = JsonDump(jFull);                         // dump it as string (easier for me to work with
      sDump = RegExpReplace("[\{-\}-\"]", sDump, "");  // now kill {, } and "
      sDump = RegExpReplace("[:,]", sDump, "|");       // and change :, , to |

    // [int32_t] Test_Int = 100  => dump from ##dm_dumparealocals
    // val key: Name|type|cexostring|value|Test_Int|Type|type|dword|value|1|Value|type|int|value|100|__struct_id|0
    // [STR] Test_String = "String_Test"
    // val key: Name|type|cexostring|value|Test_String|Type|type|dword|value|3|Value|type|cexostring|value|String_Test|__struct_id|0
    // [FLT] Test_Float = 50.049999
    // val key: Name|type|cexostring|value|Test_Float|Type|type|dword|value|2|Value|type|float|value|50.04999923706055|__struct_id|0

      SendMessageToPC(oPC, "val err: " + sError);  // debug
      SendMessageToPC(oPC, "val key: " + sDump);   // debug
    }

    // next scan objects
    // first get above working as intended
    
    // goto next area
    oArea = GetNextArea();
  }

  // at least scan unused blueprints
}

/* notes from a area.git
        "VarTable": {
          "type": "list", "value":
          [
            { "__struct_id": 0,
              "Name":  { "type": "cexostring", "value": "CEP_L_LIGHTCONST" },
              "Type":  { "type": "dword", "value": 3 },
              "Value": { "type": "cexostring", "value": "ORANGE_5"}
            },
            { "__struct_id": 0,
              "Name":  { "type": "cexostring", "value": "CEP_L_AMION" },
              "Type":  { "type": "dword", "value": 1 },
              "Value": { "type": "int", "value": 1 }
            },
            { "__struct_id": 0,
              "Name":  { "type": "cexostring", "value": "CEP_L_LIGHTCYCLE" },
              "Type":  { "type": "dword", "value": 1 },
              "Value": { "type": "int", "value": 0 }
            },
            { "__struct_id": 0,
              "Name":  { "type": "cexostring", "value": "CEP_L_LIGHTSWAP" },
              "Type":  { "type": "dword", "value": 3 },
              "Value": { "type": "cexostring", "value": "zep_ocandle03" }
            }
          ]
        },
*/
