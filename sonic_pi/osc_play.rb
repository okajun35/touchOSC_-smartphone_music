note_val = 60.4262
play note_val
puts "midi_note: #{note_val}"

live_loop :receive_and_play_x do
  use_real_time
  puts "x"
  
  # note_val = sync "/osc*/play_note"
  
  note_val = sync "/osc*/play_x"
  synth :piano, note: note_val[0] # ピアノ音を鳴らす
end

live_loop :receive_and_play_y do
  use_real_time
  puts "y"
  note_val = sync "/osc*/play_y"
  midi note_val[0] # MIDI音を鳴らす
end

live_loop :receive_and_play_z do
  use_real_time
  puts "z"
  note_val = sync "/osc*/play_y"
  synth :prophet, note: note_val[0] # 合成音を鳴らす
end
