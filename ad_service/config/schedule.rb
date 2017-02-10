set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every :day do
  runner "Advert.set_archive", environment: 'development' 
end
