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

function rgb_to_r_g_b(color, alpha)
    return ((color / 0x10000) % 0x100) / 255., ((color / 0x100) % 0x100) / 255., (color % 0x100) / 255., alpha
end
function log(x, base)
	return math.log(x)/math.log(base)
end

function list_ext_mountpoints()
	local t = {}
	local h = io.popen('df -h|grep \'/dev/sd\'|awk \'{print $6}\'')
	for entry in h:lines() do
		table.insert(t, entry)
	end
	h:close()
	return t
end

function draw_arc(cr, x, y, radius, startDeg, endDeg, width, color, alpha)
	local startRad = (startDeg - 90) * (math.pi/180.0)
	local endRad = (endDeg + startDeg - 90) * (math.pi/180.0)
	
	cairo_set_line_width(cr, width)
	cairo_set_source_rgba(cr, rgb_to_r_g_b(color, alpha))
	cairo_arc(cr, x, y, radius, startRad, endRad)
	cairo_stroke(cr)
end
function draw_negarc(cr, x, y, radius, startDeg, endDeg, width, color, alpha)
	local startRad = (startDeg - 90) * (math.pi/180.0)
	local endRad = (startDeg - 90 - endDeg) * (math.pi/180.0)
	
	cairo_set_line_width(cr, width)
	cairo_set_source_rgba(cr, rgb_to_r_g_b(color, alpha))
	cairo_arc_negative(cr, x, y, radius, startRad, endRad)
	cairo_stroke(cr)
end

function draw_rect(cr, x, y, width, height, color, alpha)
	cairo_set_source_rgba(cr, rgb_to_r_g_b(color, alpha))
	cairo_set_line_width(cr, 0)
	cairo_rectangle(cr, x, y - height, width, height)
	cairo_fill(cr)
	cairo_stroke(cr)
end

function draw_text(cr, x, y, value, size, weight, color, alpha)
    cairo_select_font_face(cr, 'ubuntu', CAIRO_FONT_SLANT_NORMAL, weight)
    cairo_set_font_size(cr, size)
    cairo_set_source_rgba(cr, rgb_to_r_g_b(color, alpha))
	cairo_move_to(cr, x, y)
    cairo_show_text(cr, value)
	cairo_stroke(cr)
end

--------------------------------------------------------------------------------
-- CLASS Graph
Graph = {
	name = '',
	arg = '',
	value = 0,
	max_value = 100,
	x = 85,
	y = 0,
	logarithm = false,
	reverse = false,
	background = {
		color = colorGraphBackground,
		alpha = alphaGraphBackground
	},
	highlight = {
		color = colorGraphHeighlight,
		alpha = alphaGraphHeighlight
	},
	--[[text = {
		value = "",
		radius = 34,
		size = 10,
		weight = 0,
		color = 0xFFFFFF,
		alpha = 0.3
	}]]
	caption = {
		value = "",
		size = 10,
		margin = 5,
		weight = 1,
		color = 0xFFFFFF,
		alpha = 0.5
	}
}

function Graph:new(values)
	self.__index = self
	local obj = values or {}
	obj.background = setmetatable({}, {__index = Graph.background})
	obj.highlight = setmetatable({}, {__index = Graph.highlight})
	obj.text = setmetatable({}, {__index = Graph.text})
	obj.caption = setmetatable({}, {__index = Graph.caption})
	return setmetatable(obj, self)
end
function Graph:drawArc(cr, x, y, radius, startDeg, endDeg, width, color, alpha)
	if self.reverse then
		draw_negarc(cr, x, y, radius, startDeg, endDeg, width, color, alpha)
	else
		draw_arc(cr, x, y, radius, startDeg, endDeg, width, color, alpha)
	end
end
function Graph:update(cr)
	if self.name ~= '' then
		local new = conky_parse(string.format('${%s %s}', self.name, self.arg))
		if new ~= self.text.value then
			self.text.value = new
			self.value = tonumber(new) or 0
		end
	end
	self:display(cr)
end
GaugeGraph = Graph:new({
	radius = 20,
	thickness = 15,
	start_deg = 180,
	end_deg = 270
})
function GaugeGraph:display(cr)
	local max_value = self.max_value
	if self.logarithm ~= false then
		local base = self.logarithm.base or 10
		max_value = log(max_value + 1.0, base)
		self.value = log(self.value + 1.0, base)
	end

	-- background ring
	self:drawArc(cr, self.x, self.y, self.radius, self.start_deg, self.end_deg, self.thickness, self.background.color, self.background.alpha)

	-- arc of value
	self:drawArc(cr, self.x, self.y, self.radius, self.start_deg, (self.end_deg * self.value)/max_value, self.thickness, self.highlight.color, self.highlight.alpha)

	-- hand
	--[[
	start_arc = (graph_unit_angle * val) - (graph_unit_thickness * 2)
	stop_arc = (graph_unit_angle * val)
	cairo_arc(cr, x, y, graph_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
	cairo_set_source_rgba(cr, rgb_to_r_g_b(hand_fg_colour, hand_fg_alpha))
	cairo_stroke(cr)

	-- graduations marks
	local graduation_radius = data['graduation_radius']
	local graduation_thickness, graduation_mark_thickness = data['graduation_thickness'], data['graduation_mark_thickness']
	local graduation_unit_angle = data['graduation_unit_angle']
	local graduation_fg_colour, graduation_fg_alpha = data['graduation_fg_colour'], data['graduation_fg_alpha']
	if data.graduation_radius > 0 and graduation_thickness > 0 and graduation_unit_angle > 0 then
		local nb_graduation = graph_end_angle / graduation_unit_angle
		local i = 0
		while i < nb_graduation do
			cairo_set_line_width(cr, graduation_thickness)
			start_arc = (graduation_unit_angle * i) - (graduation_mark_thickness / 2)
			stop_arc = (graduation_unit_angle * i) + (graduation_mark_thickness / 2)
			cairo_arc(cr, x, y, data.graduation_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
			cairo_set_source_rgba(cr,rgb_to_r_g_b(graduation_fg_colour,graduation_fg_alpha))
			cairo_stroke(cr)
			cairo_set_line_width(cr, graph_thickness)
			i = i + 1
		end
	end
	-- text
	local txt_radius = data.txt_radius
	local txt_weight, txt_size = data['txt_weight'], data['txt_size']
	local txt_fg_colour, txt_fg_alpha = data['txt_fg_colour'], data['txt_fg_alpha']
	local movex = txt_radius * math.cos(angle_to_position(graph_start_angle, (data.graph_end_angle * value)/max_value)) * 1.15
	local movey = txt_radius * math.sin(angle_to_position(graph_start_angle, (data.graph_end_angle * value)/max_value)) * 1.05
	if data.reverse then
		movey = movey *-1
	end

	cairo_select_font_face (cr, "ubuntu", CAIRO_FONT_SLANT_NORMAL, txt_weight)
	cairo_set_font_size (cr, txt_size)
	cairo_set_source_rgba (cr, rgb_to_r_g_b(txt_fg_colour, txt_fg_alpha))
	cairo_move_to (cr, x + movex, y + movey)
	cairo_show_text (cr, txt_value)
	cairo_stroke (cr)
	]]

	-- caption
    if self.caption.value ~= '' then
		draw_text(cr, self.x + self.caption.margin, self.y + self.radius + self.caption.size/4, self.caption.value, self.caption.size, self.caption.weight, self.caption.color, self.caption.alpha)
	end
end
BarGraph = Graph:new({
	width = 70,
	height = 15
})
function BarGraph:display(cr)
	local max_value = self.max_value
	if self.logarithm ~= false then
		local base = self.logarithm.base or 10
		max_value = log(max_value + 1.0, base)
		self.value = log(self.value + 1.0, base)
	end
	
	-- background
	draw_rect(cr, self.x, self.y, self.width, self.height, self.background.color, self.background.alpha)
	-- value
	draw_rect(cr, self.x, self.y, (self.width * self.value)/max_value, self.height, self.highlight.color, self.highlight.alpha)
    -- caption
    if self.caption.value ~= '' then
		draw_text(cr, self.x + self.width + self.caption.margin, self.y - self.height/2 + self.caption.size/4, self.caption.value, self.caption.size, self.caption.weight, self.caption.color, self.caption.alpha)
	end
end
GraphGradiation = GaugeGraph:new({
	count = 59,
	graduation_deg = 1.5
})
function GraphGradiation:display(cr)
	local max_value = self.max_value
	if self.logarithm ~= false then
		local base = self.logarithm.base or 10
		max_value = log(max_value + 1.0, base)
		self.value = log(self.value + 1.0, base)
	end
	
	-- background ring
	for i = 0, self.count do
		self:drawArc(cr, self.x, self.y, self.radius, self.start_deg + i * (self.end_deg / self.count), self.graduation_deg, self.thickness, self.background.color, self.background.alpha)
	end
	
	-- arc of value
	for i = 0, (self.count * self.value)/max_value do
		self:drawArc(cr, self.x, self.y, self.radius, self.start_deg + i * (self.end_deg / self.count), self.graduation_deg, self.thickness, self.highlight.color, self.highlight.alpha)
	end

	-- caption
    if self.caption.value ~= '' then
		draw_text(cr, self.x + self.caption.margin, self.y + self.radius + self.caption.size/4, self.caption.value, self.caption.size, self.caption.weight, self.caption.color, self.caption.alpha)
	end
end
--------------------------------------------------------------------------------
--                                                                    gauge DATA
config = {
	GaugeGraph:new({name='cpu', arg='cpu0', y=vtop_cpu, radius=20, thickness=5}),
	GaugeGraph:new({name='cpu', arg='cpu1', y=vtop_cpu, radius=25, thickness=5}),
	GaugeGraph:new({name='cpu', arg='cpu2', y=vtop_cpu, radius=30, thickness=5}),
	GaugeGraph:new({name='cpu', arg='cpu3', y=vtop_cpu, radius=35, thickness=5}),
	GaugeGraph:new({name='cpu', arg='cpu4', y=vtop_cpu, radius=40, thickness=5}),
	GaugeGraph:new({name='cpu', arg='cpu5', y=vtop_cpu, radius=45, thickness=5}),
	GaugeGraph:new({name='cpu', arg='cpu6', y=vtop_cpu, radius=50, thickness=5}),
	GaugeGraph:new({name='cpu', arg='cpu7', y=vtop_cpu, radius=55, thickness=5}),
	GaugeGraph:new({name='memperc', y=vtop_mem, radius=45}),
	GaugeGraph:new({name='swapperc', y=vtop_mem, radius=25}),
	GaugeGraph:new({name='downspeedf', arg='eth0', y=vtop_net, radius=45, logarithm = {base = 10}, end_deg = 180, max_value=1000000}),
	GaugeGraph:new({name='downspeedf', arg='wlan0', y=vtop_net, radius=25, logarithm = {base = 10}, end_deg = 180, max_value=1000000}),
	GaugeGraph:new({name='upspeedf', arg='eth0', x=Graph.x+5, y=vtop_net, radius=45, logarithm = {base = 10}, reverse=true, start_deg = 90, end_deg = 90, max_value=1000000}),
	GaugeGraph:new({name='upspeedf', arg='wlan0', x=Graph.x+5, y=vtop_net, radius=25, logarithm = {base = 10}, reverse=true, start_deg = 90, end_deg = 90, max_value=1000000}),
	GaugeGraph:new({name='battery_percent', arg='BAT0', y=vtop_bat, radius=25}),
	GaugeGraph:new({name='time', arg='%I', x=160, y=vtop_clock, radius=80, thickness=5, start_deg = 0, end_deg = 360, max_value=12}),
	GaugeGraph:new({name='time', arg='%M', x=160, y=vtop_clock, radius=92, thickness=3, start_deg = 0, end_deg = 360, max_value=59}),
	GraphGradiation:new({name='time', arg='%S', x=160, y=vtop_clock, radius=98, thickness=2, start_deg = 0, end_deg = 354, max_value=59}),
	GraphGradiation:new({name='time', arg='%I', x=160, y=vtop_clock, radius=87, thickness=6, start_deg = 0, end_deg = 360, max_value=12, count=12, graduation_deg=1}),
}

-------------------------------------------------------------------------------
--                                                                         MAIN
function conky_main()
	if conky_window == nil then 
		return
	end

	local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
	local display = cairo_create(cs)

	--if tonumber(conky_parse('${updates}')) > 5 then
    for i,entry in ipairs(config) do
		entry:update(display)
	end
	
	-- draw hdd
	-- get mount points
	local mountpoints = {
		int = {
			'/',
			'/media/hdd'
		},
		ext = list_ext_mountpoints()
	}
	for datai,mountpoint in ipairs(mountpoints.int) do
		local graph = GaugeGraph:new({
			name = 'fs_used_perc',
			arg = mountpoint,
			y = vtop_disk,
			radius = 40 / datai + 5,
			thickness = 30 / table.getn(mountpoints.int),
			end_deg = (table.getn(mountpoints.ext) > 0) and 180 or 270
		})
		--graph.caption = {}
		--graph.caption.__index = Graph.caption
		graph.caption.value = mountpoint
		graph:update(display)
		graph = nil
	end
	
	local posY = vtop_disk - 45 - 15/ table.getn(mountpoints.int)
	local Anz = math.max(table.getn(mountpoints.int), table.getn(mountpoints.ext))
	local a = 10 / Anz
	local h = (35 - (a*(Anz-1))) / Anz
	
	for datai,mountpoint in ipairs(mountpoints.ext) do
		local graph = BarGraph:new({
			name = 'fs_used_perc',
			arg = mountpoint,
			x = BarGraph.x+5,
			y = posY + datai * (h+a) - a,
			height = h
		})
		graph.caption.value = mountpoint
		graph.caption.size = math.min(h, 10)
		graph:update(display)
		graph = nil
	end
	--end

	cairo_destroy(display)
	cairo_surface_destroy(cs)
end

