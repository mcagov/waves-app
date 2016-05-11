namespace :puma do
  desc "Restart puma cluster"
  task :kill do
    puma_pids = `ps ax | grep puma | grep -v grep | cut -d " " -f 1`
      .split("\n")
      .map(&:to_i)

    if puma_pids.empty?
      puts "Puma is not running!"
      exit 0
    end

    puts "Found the following puma PIDs: #{puma_pids.inspect}"

    puts "Killing them now..."
    puma_pids.each do |pid|
      Process.kill("TERM", pid)
    end

    sleep 3

    begin
      Process.getpgid( puma_pids.first )
      fail "Puma is still up..."
      exit 1
    rescue Errno::ESRCH
      puts "Puma is down!"
    end
  end
end
