#include "../../include/genericdefs/menu_api.qc" // Include the FTE menu API for menu functionality

///---------------------------------------------------
/// Menu Constants
///---------------------------------------------------

float MENU_START = 0;
float MENU_QUIT = 1;
float menu_selected;

void m_init(void)
{
    menu_selected = MENU_START;
}

void(float wantmode) m_toggle
{
    if (wantmode != 0)
        menu_selected = MENU_START;
}

///---------------------------------------------------
/// Menu Functions
///---------------------------------------------------

void menu_start_game(void)
{
    localcmd("map testmap\n");
}

void menu_quit_game(void)
{
    localcmd("quit\n");
}

///---------------------------------------------------
/// Menu Navigation Functions
///---------------------------------------------------

void menu_select_next(void)
{
    menu_selected++;
    if (menu_selected > MENU_QUIT)
        menu_selected = MENU_START;
}

void menu_select_prev(void)
{
    menu_selected--;
    if (menu_selected < MENU_START)
        menu_selected = MENU_QUIT;
}

void menu_activate_selected(void)
{
    if (menu_selected == MENU_START)
        menu_start_game();
    else if (menu_selected == MENU_QUIT)
        menu_quit_game();
}

void(float scan, float chr) m_keydown
{
    if (scan == K_ESCAPE)
    {
        m_toggle(0); 
        return;
    }

    if (scan == K_UPARROW || chr == 'w' || chr == 'W')
    {
        menu_select_prev();
        return;
    }

    if (scan == K_DOWNARROW || chr == 's' || chr == 'S')
    {
        menu_select_next();
        return;
    }

    if (scan == K_ENTER || chr == 13 || chr == 10)
    {
        menu_activate_selected();
        return;
    }
}

void(float scan, float chr) m_keyup
{
}

///---------------------------------------------------
/// Menu Rendering Function
///---------------------------------------------------

void m_draw(vector screensize)
{
    drawfill('0 0 0', screensize, '0 0 0', 1, 0);
    drawstring('220 100 0', "FTE Base Game", '18 18 0', '1 1 1', 1, 0);

    if (menu_selected == MENU_START)
    {
        drawstring('250 170 0', "> Start Game", '16 16 0', '1 1 1', 1, 0);
        drawstring('250 210 0', "  Quit", '16 16 0', '0.8 0.8 0.8', 1, 0);
    }
    else
    {
        drawstring('250 170 0', "  Start Game", '16 16 0', '0.8 0.8 0.8', 1, 0);
        drawstring('250 210 0', "> Quit", '16 16 0', '1 1 1', 1, 0);
    }

    
}