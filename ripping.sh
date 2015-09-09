#!/usr/bin/env ruby

# example
#/Volumes/Data/Lavoro/scripts/hb-steroids/ripping.sh "/Volumes/2TB/tmp/once_upon_a_time_serie_2" "AppleTV 3" "avi" "1,2"

base_dir =ARGV[0]
preset = ARGV[1]
ext = ARGV[2]
audio = ARGV[3]
subtitle = ARGV[4]

cmd  = "HandBrakeCLI -i '{{input_file}}' -o '{{output_file}}.mp4' --preset='#{preset}' --srt-file {{srt_string}} -a #{audio}"
cmd_no_subtitle = "HandBrakeCLI -i '{{input_file}}' -o '{{output_file}}.mp4' --preset='#{preset}' -a #{audio}"

Dir[ "#{base_dir}/*.#{ext}" ].each do |video|
  file_name = File.basename(video)
  only_file_name = File.basename(video, '.*')
  simple_name = File.basename( video, File.extname(video) )


  if subtitle == "none"
    str_cmd = cmd_no_subtitle.gsub("{{input_file}}", "#{base_dir}/#{file_name}").gsub("{{output_file}}", "#{base_dir}/ripped/#{simple_name}")
  else
    str_cmd = cmd.gsub("{{input_file}}", "#{base_dir}/#{file_name}").gsub("{{output_file}}", "#{base_dir}/ripped/#{simple_name}").gsub("{{srt_string}}", "#{base_dir}/#{only_file_name}.it.srt,#{basE_dir}/#{only_file_name}.en.srt")
  end

  if !Dir.exists?( "#{base_dir}/ripped" )
    Dir.mkdir( "#{base_dir}/ripped" )
  end
  system "#{str_cmd}"
end
