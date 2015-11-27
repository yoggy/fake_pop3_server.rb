#!/usr/bin/ruby
#
# fake_pop3_server.rb
#
# github:
#     https://github.com/yoggy/fake_pop3_server.rb
#
# license:
#     Copyright (c) 2015 yoggy <yoggy0@gmail.com>
#     Released under the MIT license
#     http://opensource.org/licenses/mit-license.php;
#
require "socket"

STDOUT.sync = true

$port = 110

gs = TCPServer.open($port)
addr = gs.addr
addr.shift
printf("server is on %s\n", addr.join(":"))

while true
  Thread.start(gs.accept) do |s|
    addr = s.addr
    addr.shift
    printf("#{Time.now.to_i} connect from %s\n", addr.join(":"))
	s.puts("+OK 0")
    while l = s.gets
	  l = l.chomp
	  puts("#{Time.now.to_i} recv : [#{addr.join(":")}] #{l}")
	  s.puts("+OK 0")
	  if l == "quit"
	    s.close
	    break
	  end
    end
    s.close
  end
end
