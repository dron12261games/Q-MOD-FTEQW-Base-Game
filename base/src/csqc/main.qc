#include "../../../include/genericdefs/fte_csqc_api.qc"

void(float apilevel, string enginename, float engineversion) CSQC_Init =
{
    print("Client: initialized\n");
};

void(float isnew) CSQC_Ent_Update =
{
};

void(float vwidth, float vheight, float notmenu) CSQC_UpdateView =
{
};

void() CSQC_Input_Frame =
{
};

void() CSQC_Renderer =
{
};

void() CSQC_Shutdown =
{
};
