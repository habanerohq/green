Rails.configuration.to_prepare do
  Habanero::Sorbet.includes(:namespace).each(&:chill!) if Habanero::Sorbet.table_exists?
end