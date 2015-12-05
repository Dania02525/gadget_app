require "singleton"
class SqlTemplate < ActiveRecord::Base
  validates :body, :path, presence: true
  validates :format, inclusion: Mime::SET.symbols.map(&:to_s)
  validates :locale, inclusion: I18n.available_locales.map(&:to_s)
  validates :handler, inclusion: ActionView::Template::Handlers.extensions.map(&:to_s)

  after_save do
    SqlTemplate::Resolver.instance.clear_cache
    Rails.cache.delete("view_cache:#{self.path}.#{self.locale}.#{self.format}.#{self.partial}")
  end

  class Resolver < ActionView::Resolver
    include Singleton

    protected

    def find_templates(name, prefix, partial, details)
      conditions = {
        path: normalize_path(name, prefix),
        locale: normalize_array(details[:locale]).first,
        format: normalize_array(details[:formats]).first,
        handler: normalize_array(details[:handlers]),
        partial: partial || false
      }
      maybe_fetch_from_catch(conditions).map do |record|
        initialize_template(record)
      end
    end

    def normalize_path(name, prefix)
      prefix.present? ? "#{prefix}/#{name}" : name
    end

    def normalize_array(array)
      array.map(&:to_s)
    end

    def initialize_template(record)
      source = record[:body]
      identifier = "SqlTemplate - #{record[:id]} - #{record[:path]}"
      handler = ActionView::Template::registered_template_handler(record[:handler])
      details = {
        format: Mime[record[:format]],
        updated_at: record[:updated_at],
        virtual_path: virtual_path(record[:path], record[:partial])
      }
      ActionView::Template.new(source, identifier, handler, details)
    end

    def virtual_path(path, partial)
      return path unless partial
      if index = path.rindex("/")
        path.insert(index + 1, "_")
      else
        "_#{path}"
      end
    end

    def maybe_fetch_from_catch(conditions)
      Rails.cache.fetch(keystring(conditions), :expires_in => 90.minutes) do
        to_hash ::SqlTemplate.where(conditions)
      end
    end

    def keystring(conditions)
      "view_cache:#{conditions[:path]}.#{conditions[:locale]}.#{conditions[:format]}.#{conditions[:partial]}"
    end

    def to_hash(records) 
      records.map do |record|
        {
          id: record.id,
          body: record.body,
          path: record.path,
          format: record.format,
          locale: record.locale,
          handler: record.handler,
          partial: record.partial
        }
      end
    end

  end
end
