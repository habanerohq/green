module Green
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      desc <<DESC
Description:
  Copy green files into your application.
DESC

      include Rails::Generators::Migration

      def self.source_root # :nodoc:
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end

      def self.next_migration_number(dirname) # :nodoc:
        Time.now.strftime("%Y%m%d%H%M%S")
      end

      def copy_initializer
      end

      def setup_routes
        route('Green.routes(self)')
      end

      def create_migrations
        template_path = File.join(self.class.source_root, 'migrations', '*.rb')

        Dir[template_path].sort.each do |file_path|
          file_name = File.basename(file_path)
          migration_template("migrations/#{file_name}",
                             "db/migrate/#{file_name.gsub(/^\d+_/, '')}")

          sleep(1)
        end
      end

      def setup_acts_as_taggable_on
        generate('acts_as_taggable_on:migration')
      end

      # todo: generate migration for pantry
    end
  end
end
