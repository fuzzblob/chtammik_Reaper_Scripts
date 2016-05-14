-- ReaScript Name: chtammik_Move selected items [direction] [duration] seconds.lua
-- Description: See title
-- Instructions: slect region(s), run
-- Author: chtammik
-- Author URI: http://tammik.ca
-- Repository: GitHub > chtammik > chtammik_Reaper_Scripts
-- Repository URI: https://github.com/chtammik/chtammik_Reaper_Scripts
-- File URI:
-- Licence: GPL v3
-- Forum Thread: Script: Script name
-- Forum Thread URI: http://forum.cockos.com/***.html
-- REAPER: 5.18
-- Extensions: None
-- Version: 1.0

posn_move = -1.0	-- set item position translation, left is negative (-1.7 was requested)
msg_flag = true		-- flag to report errors to console

function msg(val)        --define msg function...
    if msg_flag then reaper.ShowConsoleMsg(tostring(val).."\n") end
end

function get_posn(sel)			-- get position of sel item (sel number)
	return reaper.GetMediaItemInfo_Value(reaper.GetSelectedMediaItem(0, sel), "D_POSITION")		-- read item position
end

function move_item(sel, val)			-- move position of sel item (sel number)
	reaper.SetMediaItemInfo_Value(reaper.GetSelectedMediaItem(0, sel), "D_POSITION", val)		-- write item position
end

reaper.Undo_BeginBlock() -- Hold undo block to main code...
num_sel_items = reaper.CountSelectedMediaItems(0)	-- count selected items
if num_sel_items >0 then -- if items selected...
	for i = 0, num_sel_items -1 do	-- cycle through selected items
		item_posn = get_posn(i)		-- get position of sel item number
		if item_posn + posn_move >=0 then move_item(i, item_posn + posn_move) else msg("An item was not moved (neg pos'n)") end	-- move if won't create neg position
	end
else
	msg("No selected items...") 	 --if no sel items, msg to console
end
reaper.Undo_EndBlock("Move "..tostring(num_sel_items).." sel item(s) "..tostring(posn_move).."s", -1) -- close undo block and give annotation to undo stack.