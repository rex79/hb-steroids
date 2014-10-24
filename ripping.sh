#!/usr/bin/env ruby

base_dir = ARGV[0]
preset = ARGV[1]
ext = ARGV[2]
audio = ARGV[3]
command  = "HandBrakeCLI -i '{{input_file}}' -o '{{output_file}}.mp4' --preset='#{preset}' -a #{audio} --srt-file {{srt_string}} "

Dir[ "#{base_dir}/*.#{ext}" ].each do |video|
  file_name = File.basename(video)
  only_file_name = File.basename(video, '.*').gsub("ITA.ENG", "ITA_ENG")
  simple_name = File.basename( video, File.extname(video) )


  str_cmd = command.gsub("{{input_file}}", "#{base_dir}/#{file_name}")
  						.gsub("{{output_file}}", "#{base_dir}/ripped/#{simple_name}")
  						.gsub("{{srt_string}}", "#{base_dir}/#{only_file_name}.it.srt,#{base_dir}/#{only_file_name}.en.srt")
  puts str_cmd
  if !Dir.exists?( "#{base_dir}/ripped" )
    Dir.mkdir( "#{base_dir}/ripped" )
  end
  system "#{str_cmd}"
end

