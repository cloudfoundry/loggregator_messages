class LogMessage
  def message_type_name
    {MessageType::OUT => "STDOUT", MessageType::ERR => "STDERR"}[message_type]
  end

  def source_name(id = nil)
    id_string = id ? "/#{id}" : ""

    {SourceType::CLOUD_CONTROLLER => "CF[CC#{id_string}]",
     SourceType::ROUTER => "CF[Router#{id_string}]",
     SourceType::UAA => "CF[UAA#{id_string}]",
     SourceType::DEA => "CF[DEA#{id_string}]",
     SourceType::WARDEN_CONTAINER => "App#{id_string}",}[source_type]
  end

  def time=(time)
    self.timestamp = (time.tv_sec * 1000000000) + time.tv_nsec
  end

  def time
    num_secs = @timestamp / 1000000000
    fractional_usecs = (@timestamp % 1000000000).to_f / 1000
    Time.at(num_secs, fractional_usecs)
  end
end
