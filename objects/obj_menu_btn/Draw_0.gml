draw_set_color(c_white)

draw_set_font(fnt_times)

draw_text(x,y, "Finished")

draw_set_font(fnt_jersey)
draw_text(x,y+275,string(global.points))

draw_set_font(fnt_jersey)
draw_text(x,y+400, "Click to Continue")