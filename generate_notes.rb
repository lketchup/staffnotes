require 'rubygems'
require 'nokogiri'

html = File.new('view.html', 'w+')
html.puts "<!doctype html>
<html>
<head>
  <link href='https://fonts.googleapis.com/css?family=Arial:400,700' rel='stylesheet' type='text/css'>
  <style>
    body {
      font-family: 'Arial', serif;
      font-size: 12px;
    }
  </style>
</head>
<body>"

@doc = Nokogiri::HTML(open('source.html'))
projects = @doc.css('.staffing-plans-project')

projects.each do |project|
  html.puts '<b>' + project.css('h2').text.to_s + ' - Client Principal </b>'
  html.puts '<br>' + project.css('h3').text.to_s.strip

  project_roles = project.css('tbody .staffing-plans-role')
  html.puts '<ul>'

  project_roles.each do |project_role|
    html.puts '<li>' + project_role.css('div')[0].text.to_s.gsub(/\s+/m, ' ').strip + ' [' + project_role.css('.tooltip p strong')[0].text +
                  ' - ' + project_role.css('.tooltip p strong')[1].text + '] - ' + project_role.css('.staffing-plans-future p').text.strip + '</li>'
  end

  html.puts '</ul>'
  html.puts ''

end

html.puts '</body></html>'

system('open view.html')
