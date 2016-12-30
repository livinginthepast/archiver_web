namespace :reset do
  task :lapine do
    user = 'archiver'
    exchange = 'archiver.topic'
    sh "rabbitmqadmin declare user name=#{user} password=guest tags=administrator"

    %w(/archiver.development /archiver.test).each do |vhost|
      unless system("rabbitmqadmin list vhosts | grep -c #{vhost} > /dev/null")
        sh "rabbitmqadmin declare vhost name=#{vhost}"
      end
      sh "rabbitmqadmin declare permission vhost=#{vhost} user=#{user} configure='.*' write='.*' read='.*'"
      sh "rabbitmqadmin declare exchange name=#{exchange} type=topic --vhost=#{vhost} --username=#{user} --password=guest"
    end
  end
end
