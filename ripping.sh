#!/usr/bin/env ruby

base_dir = ARGV[0]
preset = ARGV[1]
command  = "HandBrakeCLI -i '{{input_file}}' -o '{{output_file}}.mp4' --preset='#{preset}'"

Dir[ "#{base_dir}/*.avi" ].each do |video|
  file_name = File.basename(video)
  simple_name = File.basename( video, File.extname(video) )

  str_cmd = command.gsub("{{input_file}}", "#{base_dir}/#{file_name}").gsub("{{output_file}}", "#{base_dir}/ripped/#{simple_name}")
  puts str_cmd
  if !Dir.exists?( "#{base_dir}/ripped" )
    Dir.mkdir( "#{base_dir}/ripped" )
  end
  exec( str_cmd )
end

