#!/usr/bin/env -e ruby

2.times do |i|
  fork do
    `env PORT=#{23000 + i} ruby -rubygems app.rb`
  end
end
Process.waitall

