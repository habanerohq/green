Rails.configuration.to_prepare do
  Habanero::Sorbet.all.each(&:chill!) if Habanero::Sorbet.table_exists?
end