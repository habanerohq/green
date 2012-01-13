Rails.configuration.to_prepare do
  Habanero::Sorbet.includes(:namespace, :parent).each(&:chill!) if Habanero::Sorbet.table_exists?
end