--==============================================================================
--                                 conky_grey.lua
--
--  author  : SLK
--  version : v2011062101
--  license : Distributed under the terms of GNU GPL version 2 or later
--
--==============================================================================

require 'cairo'
require 'os'


vtop_clock = 120
vtop_cpu=vtop_clock + 150
vtop_mem=vtop_cpu + 150
vtop_disk=vtop_mem + 130
vtop_net=vtop_disk + 130
vtop_bat=vtop_net + 110

cPumpkin=0xd35400
cDeepOrange=0xff5722
cWhite=0xffffff

colorGraphHeighlight=cDeepOrange
alphaGraphHeighlight=1
colorGraphBackground=cWhite
alphaGraphBackground=0.1
--------------------------------------------------------------------------------
--                                                                    clock DATA
-- HOURS
clock_rings = {
    {
		name='time',                   arg='%H',
		min_value=1,                   max_value=12,
		x=160,                         y=vtop_clock,
		graph_radius=80,
		graph_thickness=5,
		graph_unit_angle=30,           graph_unit_thickness=30,
		graph_bg_colour=colorGraphBackground,      graph_bg_alpha=alphaGraphBackground,
		graph_fg_colour=colorGraphHeighlight,      graph_fg_alpha=alphaGraphHeighlight,
		txt_radius=0,
		txt_weight=1,                  txt_size=0,
		txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.6,
		graduation_radius=87,
		graduation_thickness=5,        graduation_mark_thickness=1,
		graduation_unit_angle=30,
		graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    },
-- MINUTES
    {
		name='time',                   arg='%M',
		min_value=1,                   max_value=60,
		x=160,                         y=vtop_clock,
		graph_radius=92,
		graph_thickness=3,
		graph_unit_angle=6,            graph_unit_thickness=6,
		graph_bg_colour=colorGraphBackground,      graph_bg_alpha=alphaGraphBackground,
		graph_fg_colour=colorGraphHeighlight,      graph_fg_alpha=alphaGraphHeighlight,
		txt_radius=0,
		txt_weight=0,                  txt_size=0,
		txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.6,
		graduation_radius=100,
		graduation_thickness=0,        graduation_mark_thickness=2,
		graduation_unit_angle=30,
		graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    },
-- SECONDS
    {
		name='time',                   arg='%S',
		min_value=0,                   max_value=60,
		x=160,                         y=vtop_clock,
		graph_radius=98,
		graph_thickness=2,
		graph_unit_angle=6,            graph_unit_thickness=1,
		graph_bg_colour=colorGraphBackground,      graph_bg_alpha=0,
		graph_fg_colour=colorGraphHeighlight,      graph_fg_alpha=alphaGraphHeighlight,
		txt_radius=0,
		txt_weight=0,                  txt_size=0,
		txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.3,
		graduation_radius=0,
		graduation_thickness=0,        graduation_mark_thickness=0,
		graduation_unit_angle=0,
		graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.0,
    }
}
--------------------------------------------------------------------------------
--                                                                    gauge DATA
gauge = {
{
    name='cpu',                    arg='cpu0',                  max_value=100,
    x=85,                          y=vtop_cpu,
    graph_radius=20,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=colorGraphBackground,      graph_bg_alpha=alphaGraphBackground,
    graph_fg_colour=colorGraphHeighlight,      graph_fg_alpha=alphaGraphHeighlight,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
    txt_radius=34,
    txt_weight=0,                  txt_size=0,
    txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.3,
    graduation_radius=0,
    graduation_thickness=8,        graduation_mark_thickness=2,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=8.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='cpu',                    arg='cpu1',                  max_value=100,
    x=85,                          y=vtop_cpu,
    graph_radius=25,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=colorGraphBackground,      graph_bg_alpha=alphaGraphBackground,
    graph_fg_colour=colorGraphHeighlight,      graph_fg_alpha=alphaGraphHeighlight,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
    txt_radius=34,
    txt_weight=0,                  txt_size=0,
    txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.3,
    graduation_radius=0,
    graduation_thickness=8,        graduation_mark_thickness=2,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=8.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='cpu',                    arg='cpu2',                  max_value=100,
    x=85,                          y=vtop_cpu,
    graph_radius=30,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=colorGraphBackground,      graph_bg_alpha=alphaGraphBackground,
    graph_fg_colour=colorGraphHeighlight,      graph_fg_alpha=alphaGraphHeighlight,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
    txt_radius=34,
    txt_weight=0,                  txt_size=0,
    txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.3,
    graduation_radius=0,
    graduation_thickness=8,        graduation_mark_thickness=2,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=8.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='cpu',                    arg='cpu3',                  max_value=100,
    x=85,                          y=vtop_cpu,
    graph_radius=35,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=colorGraphBackground,      graph_bg_alpha=alphaGraphBackground,
    graph_fg_colour=colorGraphHeighlight,      graph_fg_alpha=alphaGraphHeighlight,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
    txt_radius=34,
    txt_weight=0,                  txt_size=0,
    txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.3,
    graduation_radius=0,
    graduation_thickness=8,        graduation_mark_thickness=2,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=8.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='cpu',                    arg='cpu4',                  max_value=100,
    x=85,                          y=vtop_cpu,
    graph_radius=40,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=colorGraphBackground,      graph_bg_alpha=alphaGraphBackground,
    graph_fg_colour=colorGraphHeighlight,      graph_fg_alpha=alphaGraphHeighlight,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
    txt_radius=34,
    txt_weight=0,                  txt_size=0,
    txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.3,
    graduation_radius=0,
    graduation_thickness=8,        graduation_mark_thickness=2,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=8.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='cpu',                    arg='cpu5',                  max_value=100,
    x=85,                          y=vtop_cpu,
    graph_radius=45,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=colorGraphBackground,      graph_bg_alpha=alphaGraphBackground,
    graph_fg_colour=colorGraphHeighlight,      graph_fg_alpha=alphaGraphHeighlight,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
    txt_radius=34,
    txt_weight=0,                  txt_size=0,
    txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.3,
    graduation_radius=0,
    graduation_thickness=8,        graduation_mark_thickness=2,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=8.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='cpu',                    arg='cpu6',                  max_value=100,
    x=85,                          y=vtop_cpu,
    graph_radius=50,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=colorGraphBackground,      graph_bg_alpha=alphaGraphBackground,
    graph_fg_colour=colorGraphHeighlight,      graph_fg_alpha=alphaGraphHeighlight,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
    txt_radius=34,
    txt_weight=0,                  txt_size=0,
    txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.3,
    graduation_radius=0,
    graduation_thickness=8,        graduation_mark_thickness=2,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=8.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='cpu',                    arg='cpu7',                  max_value=100,
    x=85,                          y=vtop_cpu,
    graph_radius=55,
    graph_thickness=5,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=colorGraphBackground,      graph_bg_alpha=alphaGraphBackground,
    graph_fg_colour=colorGraphHeighlight,      graph_fg_alpha=alphaGraphHeighlight,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
    txt_radius=34,
    txt_weight=0,                  txt_size=0,
    txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.3,
    graduation_radius=0,
    graduation_thickness=8,        graduation_mark_thickness=2,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=8.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='memperc',                arg='',                      max_value=100,
    x=85,                          y=vtop_mem,
    graph_radius=45,
    graph_thickness=15,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=colorGraphBackground,      graph_bg_alpha=alphaGraphBackground,
    graph_fg_colour=colorGraphHeighlight,      graph_fg_alpha=alphaGraphHeighlight,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
    txt_radius=60,
    txt_weight=0,                  txt_size=8.0,
    txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.3,
    graduation_radius=0,
    graduation_thickness=8,        graduation_mark_thickness=2,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.5,
    caption='',
    caption_weight=1,              caption_size=8.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
	name='swapperc',
	arg='',
	max_value=100,
	x=85,
	y=vtop_mem,
	graph_radius=25,
	graph_thickness=15,
	graph_start_angle=180,
	graph_unit_angle=2.7,          graph_unit_thickness=2.7,
	graph_bg_colour=colorGraphBackground,      graph_bg_alpha=alphaGraphBackground,
	graph_fg_colour=colorGraphHeighlight,      graph_fg_alpha=alphaGraphHeighlight,
	hand_fg_colour=0xEF5A29,       hand_fg_alpha=0.0,
	txt_radius=10,
	txt_weight=0,                  txt_size=8.0,
	txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.3,
	graduation_radius=0,
	graduation_thickness=8,        graduation_mark_thickness=2,
	graduation_unit_angle=27,
	graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.5,
	caption='',
	caption_weight=1,              caption_size=8.0,
	caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='downspeedf',				arg='eth0',                     max_value=54000,
    x=85,							y=vtop_net,
    graph_radius=45,
    graph_thickness=15,
    graph_start_angle=180,
    graph_unit_angle=0.01,			graph_unit_thickness=2.7,
    graph_bg_colour=colorGraphBackground,		graph_bg_alpha=alphaGraphBackground,
    graph_fg_colour=colorGraphHeighlight,		graph_fg_alpha=alphaGraphHeighlight,
    hand_fg_colour=0xEF5A29,		hand_fg_alpha=0.0,
    txt_radius=60,
    txt_weight=0,                  txt_size=8,
    txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.5,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=5.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.5,
},
{
    name='upspeedf',				arg='eth0',                     max_value=54000,
    x=90,							y=vtop_net,
    graph_radius=45,
    graph_thickness=15,
    graph_start_angle=-270,
    graph_unit_angle=0.1,			graph_unit_thickness=2.7,
    graph_bg_colour=colorGraphBackground,		graph_bg_alpha=alphaGraphBackground,
    graph_fg_colour=colorGraphHeighlight,		graph_fg_alpha=alphaGraphHeighlight,
    hand_fg_colour=0xEF5A29,		hand_fg_alpha=0.0,
    txt_radius=60,
    txt_weight=0,                  txt_size=8,
    txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.5,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=5.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.5,
},
{
    name='downspeedf',				arg='wlan0',                     max_value=100000,
    x=85,							y=vtop_net,
    graph_radius=25,
    graph_thickness=15,
    graph_start_angle=180,
    graph_unit_angle=0.0018,		graph_unit_thickness=2.7,
    graph_bg_colour=colorGraphBackground,		graph_bg_alpha=alphaGraphBackground,
    graph_fg_colour=colorGraphHeighlight,		graph_fg_alpha=alphaGraphHeighlight,
    hand_fg_colour=0xEF5A29,		hand_fg_alpha=0.0,
    txt_radius=10,
    txt_weight=0,                  txt_size=8,
    txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.5,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=5.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.5,
},
{
    name='upspeedf',				arg='wlan0',                     max_value=100000,
    x=90,							y=vtop_net,
    graph_radius=25,
    graph_thickness=15,
    graph_start_angle=-270,
    graph_unit_angle=0.018,		graph_unit_thickness=2.7,
    graph_bg_colour=colorGraphBackground,		graph_bg_alpha=alphaGraphBackground,
    graph_fg_colour=colorGraphHeighlight,		graph_fg_alpha=alphaGraphHeighlight,
    hand_fg_colour=0xEF5A29,		hand_fg_alpha=0,
    txt_radius=10,
    txt_weight=0,                  txt_size=8,
    txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.5,
    graduation_radius=28,
    graduation_thickness=0,        graduation_mark_thickness=1,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=5.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.5,
},
{
    name='battery_percent',                    arg='BAT0',                  max_value=100,
    x=85,                          y=vtop_bat,
    graph_radius=25,
    graph_thickness=15,
    graph_start_angle=180,
    graph_unit_angle=2.7,          graph_unit_thickness=2.7,
    graph_bg_colour=colorGraphBackground,      graph_bg_alpha=alphaGraphBackground,
    graph_fg_colour=colorGraphHeighlight,      graph_fg_alpha=alphaGraphHeighlight,
    hand_fg_colour=0xEF5A29,       hand_fg_alpha=0,
    txt_radius=34,
    txt_weight=0,                  txt_size=0,
    txt_fg_colour=0xFFFFFF,        txt_fg_alpha=0.3,
    graduation_radius=0,
    graduation_thickness=8,        graduation_mark_thickness=2,
    graduation_unit_angle=27,
    graduation_fg_colour=0xFFFFFF, graduation_fg_alpha=0.3,
    caption='',
    caption_weight=1,              caption_size=0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
}

-------------------------------------------------------------------------------
--                                                                 rgb_to_r_g_b
-- converts color in hexa to decimal
--
function rgb_to_r_g_b(colour, alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

-------------------------------------------------------------------------------
--                                                            angle_to_position
-- convert degree to rad and rotate (0 degree is top/north)
--
function angle_to_position(start_angle, current_angle)
    local pos = current_angle + start_angle
    return ( ( pos * (2 * math.pi / 360) ) - (math.pi / 2) )
end

-------------------------------------------------------------------------------
--                                                              draw_clock_ring
-- displays clock
--
function draw_clock_ring(display, data, value)
    -- background ring
    if data.graph_bg_alpha > 0 then
		cairo_arc(display, data.x, data.y, data.graph_radius, 0, 2 * math.pi)
		cairo_set_source_rgba(display, rgb_to_r_g_b(data.graph_bg_colour, data.graph_bg_alpha))
		cairo_set_line_width(display, data.graph_thickness)
		cairo_stroke(display)
    end

    -- arc of value
    local val = (value % data.max_value)
    local i = data.min_value
    while i <= val do
        cairo_arc(display, data.x, data.y, data.graph_radius, (((data.graph_unit_angle * i) - data.graph_unit_thickness) * (2 * math.pi / 360)) - (math.pi/2), ((data.graph_unit_angle * i) * (2*math.pi/360))-(math.pi/2))
        cairo_set_source_rgba(display, rgb_to_r_g_b(data.graph_fg_colour, data.graph_fg_alpha))
        cairo_stroke(display)
        i = i + 1
    end
    local angle = (data.graph_unit_angle * i) - data.graph_unit_thickness

    -- graduations marks
    if data.graduation_radius > 0 and data.graduation_thickness > 0 and data.graduation_unit_angle > 0 then
        local nb_graduation = 360 / data.graduation_unit_angle
        local i = 1
        while i <= nb_graduation do
            cairo_set_line_width(display, data.graduation_thickness)
            cairo_arc(display, data.x, data.y, data.graduation_radius, (((data.graduation_unit_angle * i)-(data.graduation_mark_thickness/2))*(2*math.pi/360))-(math.pi/2),(((data.graduation_unit_angle * i)+(data.graduation_mark_thickness/2))*(2*math.pi/360))-(math.pi/2))
            cairo_set_source_rgba(display,rgb_to_r_g_b(data.graduation_fg_colour, data.graduation_fg_alpha))
            cairo_stroke(display)
            cairo_set_line_width(display, data.graph_thickness)
            i = i + 1
        end
    end

    -- text
    if data.txt_size > 0 then
		local movex = data.txt_radius * (math.cos((angle * 2 * math.pi / 360)-(math.pi/2)))
		local movey = data.txt_radius * (math.sin((angle * 2 * math.pi / 360)-(math.pi/2)))
		cairo_select_font_face (display, "ubuntu", CAIRO_FONT_SLANT_NORMAL, data.txt_weight);
		cairo_set_font_size (display, data.txt_size);
		cairo_set_source_rgba (display, rgb_to_r_g_b(data.txt_fg_colour, data.txt_fg_alpha));
		cairo_move_to (display, data.x + movex - (data.txt_size / 2), data.y + movey + 3);
		cairo_show_text (display, value);
		cairo_stroke (display);
	end
end
-------------------------------------------------------------------------------
--                                                                     draw_bar
-- displays bars
--
function draw_bar(display, data, value)
	--value
	local max_value = data['max_value']
	local value_ltr = data['value_ltr']
	--position and size
	local x, y = data['x'], data['y']
	local graph_width, graph_height = data['graph_width'], data['graph_height']
	--color
	local graph_bg_colour, graph_bg_alpha = data['graph_bg_colour'], data['graph_bg_alpha']
	local graph_fg_colour, graph_fg_alpha = data['graph_fg_colour'], data['graph_fg_alpha']
	local hand_fg_colour, hand_fg_alpha = data['hand_fg_colour'], data['hand_fg_alpha']
	local graduation_fg_colour, graduation_fg_alpha = data['graduation_fg_colour'], data['graduation_fg_alpha']
    --thickness
	local graph_thickness, hand_thickness, graduation_thickness, graduation_mark_thickness = data['graph_thickness'], data['hand_thickness'], data['graduation_thickness'], data['graduation_mark_thickness']
	local graduation_steps = data['graduation_steps']
	
	-- background bar
	cairo_set_source_rgba(display, rgb_to_r_g_b(graph_bg_colour, graph_bg_alpha))
	cairo_rectangle(display, x, y, graph_width, -graph_height)
	cairo_set_line_width(display, graph_thickness)
    cairo_stroke(display)

	-- bar of value
    local val = value % (max_value + 1)
	cairo_set_source_rgba(display, rgb_to_r_g_b(graph_fg_colour, graph_fg_alpha))
    cairo_set_line_width(display, graph_thickness)
    if value_ltr then
		cairo_rectangle(display, x, y, ((graph_width/max_value)*val), -graph_height)
	else
    	cairo_rectangle(display, x+graph_width, y, -((graph_width/max_value)*val), -graph_height)
	end
    cairo_stroke(display)
	
    -- hand
    cairo_set_line_width(display, hand_thickness)
    cairo_set_source_rgba(display, rgb_to_r_g_b(hand_fg_colour, hand_fg_alpha))
    if value_ltr then
		cairo_rectangle(display, x+((graph_width/max_value)*val), y, 1, -graph_height)
	else
    	cairo_rectangle(display, x+graph_width-((graph_width/max_value)*val), y, 1, -graph_height)
	end
    cairo_stroke(display)

    -- graduations marks
  --[[
	cairo_set_line_cap(display, CAIRO_LINE_CAP_ROUND)
	for graduationI = 0, graduation_steps do
		cairo_set_line_width(display, graduation_thickness)
		cairo_set_source_rgba(display,rgb_to_r_g_b(graduation_fg_colour,graduation_fg_alpha))
		cairo_rectangle(display, x+((graph_width/graduation_steps)*graduationI), y-1, 1, (2))
		-- TODO: missing: graduation_thickness, graduation_mark_thickness
		cairo_stroke(display)
	end
	cairo_set_line_cap(display, CAIRO_LINE_CAP_BUTT)
]]--
	
    -- text
--[[
    local txt_radius = data['txt_radius']
    local txt_weight, txt_size = data['txt_weight'], data['txt_size']
    local txt_fg_colour, txt_fg_alpha = data['txt_fg_colour'], data['txt_fg_alpha']
    local movex = txt_radius * math.cos(angle_to_position(graph_start_angle, angle))
    local movey = txt_radius * math.sin(angle_to_position(graph_start_angle, angle))
    cairo_select_font_face (display, "ubuntu", CAIRO_FONT_SLANT_NORMAL, txt_weight)
    cairo_set_font_size (display, txt_size)
    cairo_set_source_rgba (display, rgb_to_r_g_b(txt_fg_colour, txt_fg_alpha))
    cairo_move_to (display, x + movex - (txt_size / 2), y + movey + 3)
    cairo_show_text (display, value)
    cairo_stroke (display)
]]--
    -- caption
    local caption = data['caption']
    local caption_weight, caption_size = data['caption_weight'], data['caption_size']
    local caption_width, caption_x_offset, caption_y_offset = data['caption_width'], data['caption_x_offset'], data['caption_y_offset']
    local caption_fg_colour, caption_fg_alpha = data['caption_fg_colour'], data['caption_fg_alpha']
    cairo_select_font_face (display, "ubuntu", CAIRO_FONT_SLANT_NORMAL, caption_weight);
    cairo_set_font_size (display, caption_size)
    cairo_set_source_rgba (display, rgb_to_r_g_b(caption_fg_colour, caption_fg_alpha))
    if value_ltr then
		cairo_move_to (display, x - (caption_width + caption_x_offset), y + caption_y_offset)
    else
    	cairo_move_to (display, (x + graph_width + caption_x_offset), (y + caption_y_offset))
    end
    -- bad hack but not enough time !
    cairo_show_text (display, caption)
    cairo_stroke (display)
end
-------------------------------------------------------------------------------
--                                                              draw_gauge_ring
-- displays gauges
--
function draw_gauge_ring(display, data, value)
    local max_value = data['max_value']
    local x, y = data['x'], data['y']
    local graph_radius = data['graph_radius']
    local graph_thickness, graph_unit_thickness = data['graph_thickness'], data['graph_unit_thickness']
    local graph_start_angle = data['graph_start_angle']
    local graph_unit_angle = data['graph_unit_angle']
    local graph_bg_colour, graph_bg_alpha = data['graph_bg_colour'], data['graph_bg_alpha']
    local graph_fg_colour, graph_fg_alpha = data['graph_fg_colour'], data['graph_fg_alpha']
    local hand_fg_colour, hand_fg_alpha = data['hand_fg_colour'], data['hand_fg_alpha']
    local graph_end_angle = (max_value * graph_unit_angle) % 360

    -- background ring
    if graph_start_angle < 0 then
		cairo_arc_negative(display, x, y, graph_radius, angle_to_position(graph_start_angle, 0), angle_to_position(0, graph_end_angle))
    else
		cairo_arc(display, x, y, graph_radius, angle_to_position(graph_start_angle, 0), angle_to_position(graph_start_angle, graph_end_angle))
    end
    cairo_set_source_rgba(display, rgb_to_r_g_b(graph_bg_colour, graph_bg_alpha))
    cairo_set_line_width(display, graph_thickness)
    cairo_stroke(display)

    -- arc of value
    local val = value % (max_value + 1)
    local start_arc = 0
    local stop_arc = 0
    local i = 1
    while i <= val do
        start_arc = (graph_unit_angle * i) - graph_unit_thickness
        stop_arc = (graph_unit_angle * i)
        cairo_arc(display, x, y, graph_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
        cairo_set_source_rgba(display, rgb_to_r_g_b(graph_fg_colour, graph_fg_alpha))
        cairo_stroke(display)
        i = i + 1
    end
    local angle = start_arc

    -- hand
    start_arc = (graph_unit_angle * val) - (graph_unit_thickness * 2)
    stop_arc = (graph_unit_angle * val)
    cairo_arc(display, x, y, graph_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
    cairo_set_source_rgba(display, rgb_to_r_g_b(hand_fg_colour, hand_fg_alpha))
    cairo_stroke(display)

    -- graduations marks
    local graduation_radius = data['graduation_radius']
    local graduation_thickness, graduation_mark_thickness = data['graduation_thickness'], data['graduation_mark_thickness']
    local graduation_unit_angle = data['graduation_unit_angle']
    local graduation_fg_colour, graduation_fg_alpha = data['graduation_fg_colour'], data['graduation_fg_alpha']
    if data.graduation_radius > 0 and graduation_thickness > 0 and graduation_unit_angle > 0 then
        local nb_graduation = graph_end_angle / graduation_unit_angle
        local i = 0
        while i < nb_graduation do
            cairo_set_line_width(display, graduation_thickness)
            start_arc = (graduation_unit_angle * i) - (graduation_mark_thickness / 2)
            stop_arc = (graduation_unit_angle * i) + (graduation_mark_thickness / 2)
            cairo_arc(display, x, y, data.graduation_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
            cairo_set_source_rgba(display,rgb_to_r_g_b(graduation_fg_colour,graduation_fg_alpha))
            cairo_stroke(display)
            cairo_set_line_width(display, graph_thickness)
            i = i + 1
        end
    end

    -- text
    local txt_radius = data['txt_radius']
    local txt_weight, txt_size = data['txt_weight'], data['txt_size']
    local txt_fg_colour, txt_fg_alpha = data['txt_fg_colour'], data['txt_fg_alpha']
    local movex = txt_radius * math.cos(angle_to_position(graph_start_angle, angle))
    local movey = txt_radius * math.sin(angle_to_position(graph_start_angle, angle))
    cairo_select_font_face (display, "ubuntu", CAIRO_FONT_SLANT_NORMAL, txt_weight)
    cairo_set_font_size (display, txt_size)
    cairo_set_source_rgba (display, rgb_to_r_g_b(txt_fg_colour, txt_fg_alpha))
    cairo_move_to (display, x + movex - (txt_size / 2), y + movey + 3)
    cairo_show_text (display, value)
    cairo_stroke (display)

    -- caption
    local caption = data['caption']
    local caption_weight, caption_size = data['caption_weight'], data['caption_size']
    local caption_fg_colour, caption_fg_alpha = data['caption_fg_colour'], data['caption_fg_alpha']
    local tox = graph_radius * (math.cos((graph_start_angle * 2 * math.pi / 360)-(math.pi/2)))
    local toy = graph_radius * (math.sin((graph_start_angle * 2 * math.pi / 360)-(math.pi/2)))
    cairo_select_font_face (display, "ubuntu", CAIRO_FONT_SLANT_NORMAL, caption_weight);
    cairo_set_font_size (display, caption_size)
    cairo_set_source_rgba (display, rgb_to_r_g_b(caption_fg_colour, caption_fg_alpha))
    cairo_move_to (display, x + tox + 5, y + toy + 1)
    -- bad hack but not enough time !
    if graph_start_angle < 105 then
        cairo_move_to (display, x + tox - 30, y + toy + 1)
    end
    cairo_show_text (display, caption)
    cairo_stroke (display)
end

-------------------------------------------------------------------------------
--                                                               go_clock_rings
-- loads data and displays clock
--
function go_clock_rings(display)
    for i,data in ipairs(clock_rings) do
        draw_clock_ring(display, data, tonumber(conky_parse(string.format('${%s %s}',data['name'], data['arg']))))
    end
end

-------------------------------------------------------------------------------
--                                                               go_gauge_rings
-- loads data and displays gauges
--
function go_gauge_rings(display)
    local function load_gauge_rings(display, data)
        local str, value = '', 0
        str = conky_parse(string.format('${%s %s}', data['name'], data['arg']))
        value = tonumber(str)
        draw_gauge_ring(display, data, value)
    end
    local function load_gauge_bar(display, data)
        local str, value = '', 0
        str = conky_parse(string.format('${%s %s}',data['name'], data['arg']))
        value = tonumber(str)
        draw_bar(display, data, value)
    end
    
    for i,entry in ipairs(gauge) do
		load_gauge_rings(display, entry)
	end

	-- draw hdd
	-- get mount points
	local str = ""
	local tmpstr = ""
	local localdevices_only = true
	local drawer = {
		length = 0,
		graphs = {}
	}
	local graph
	local found = {
		int = {
			'/',
			'/media/hdd'
		},
		ext = list_ext_mountpoints()
	}

	--parsing the gathered internal partitions
	for datai,mountpoint in ipairs(found.int) do
		-- Full gauge or do we need space for external mounts? 
		angle = (table.getn(found.ext) > 0) and 1.8 or 2.7
		
		graph = {
			name				= 'fs_used_perc',
			arg					= mountpoint,
			max_value			= 100,
			x					= 85,
			y					= vtop_disk,
			--graph_radius		= (10*table.getn(found.int)*datai + 5 ), -- first is inner most gauge
			graph_radius		= ((20*table.getn(found.int))/datai + 5 ), -- first is outer most gauge
			graph_thickness		= (30/table.getn(found.int)),
			graph_start_angle	= 180,
			graph_unit_angle	= angle,
			graph_unit_thickness= 2.7,
			graph_bg_colour		= colorGraphBackground,
			graph_bg_alpha		= alphaGraphBackground,
			graph_fg_colour		= colorGraphHeighlight,
			graph_fg_alpha		= alphaGraphHeighlight,
			hand_fg_colour		= 0xEF5A29,
			hand_fg_alpha		= 0.0,
			txt_radius			= 34,
			txt_weight			= 0,
			txt_size			= 0,
			txt_fg_colour		= 0xFFFFFF,
			txt_fg_alpha		= 0.5,
			graduation_radius	= 28,
			graduation_thickness		= 0,
			graduation_mark_thickness	= 1,
			graduation_unit_angle		= 27,
			graduation_fg_colour		= 0xFFFFFF,
			graduation_fg_alpha	= 0.3,
			caption				= mountpoint,
			caption_weight		= 1,
			caption_size		= 10,
			caption_fg_colour	= 0xFFFFFF,
			caption_fg_alpha	= 0.5,
		}
		drawer.graphs[drawer.length] = graph
		drawer.length = drawer.length +1
		load_gauge_rings(display, graph)
	end
	--parsing the gathered external partitions
	local edrawer = {
		length = 0,
		graphs = {}
	}
	for datai,mountpoint in ipairs(found.ext) do
		graph = {
			name				= 'fs_used_perc',
			arg					= mountpoint,
			max_value			= 100,
			x					= 92,
			y					= (vtop_disk -((30/math.max(table.getn(found.int), table.getn(found.ext)) +5) * datai)) -5,
			value_ltr			= false,
			graph_start_angle	= 0,
			graph_width			= 70,
			graph_height		= 0,
			graph_thickness		= (30/math.max(table.getn(found.int), table.getn(found.ext))),
			graph_bg_colour		= 0xffffff,
			graph_bg_alpha		= 0.1,
			graph_fg_colour		= 0xFFFFFF,
			graph_fg_alpha		= 0.5,
			hand_fg_colour		= 0xEF5A29,
			hand_fg_alpha		= 0,
			hand_thickness		= 2,
			txt_weight			= 0,
			txt_size			= 0,
			txt_fg_colour		= 0xFFFFFF,
			txt_fg_alpha		= 0.5,
			graduation_thickness		= 1,
			graduation_mark_thickness	= 1,
			graduation_steps	= 10,
			graduation_fg_colour		= 0xFFFFFF,
			graduation_fg_alpha	= 1,
			--caption				= string.gsub(mountpoint,"(/media/)(%w+)","%2",1),
			caption				= mountpoint,
			caption_weight		= 0,
			caption_size		= 10,
			caption_fg_colour	= 0xFFFFFF,
			caption_fg_alpha	= 0.5,
			caption_width		= 5,
			caption_x_offset	= 7,
			caption_y_offset	= 2,
		}
		edrawer.graphs[edrawer.length] = graph
		edrawer.length = edrawer.length +1
		load_gauge_bar(display, graph)
	end
end

-------------------------------------------------------------------------------
function list_ext_mountpoints()
	local t = {}
	local h = io.popen('df -h|grep \'/dev/sd\'|awk \'{print $6}\'')
	for entry in h:lines() do
		table.insert(t, entry)
	end
	h:close()
	return t
end
-------------------------------------------------------------------------------
--                                                                         MAIN
function conky_main()
    if conky_window == nil then 
        return
    end

    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local display = cairo_create(cs)
    
    local updates = conky_parse('${updates}')
    local update_num = tonumber(updates)
    
    if update_num > 5 then
        go_clock_rings(display)
        go_gauge_rings(display)
    end
    
    cairo_surface_destroy(cs)
    cairo_destroy(display)
end

