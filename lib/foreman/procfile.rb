require "foreman"
require "foreman/procfile_entry"

YAML::ENGINE.yamler = 'psych'

# A valid Procfile entry is captured by this regex.
# All other lines are ignored.
#
# /^([A-Za-z0-9_]+):\s*(.+)$/
#
# $1 = name
# $2 = command
#
class Foreman::Procfile

  attr_reader :entries

  def initialize(filename, options={})
    @entries = parse_procfile(filename, options)
  end

  def [](name)
    entries.detect { |entry| entry.name == name }
  end

  def process_names
    entries.map(&:name)
  end

  private

  def parse_procfile(filename, options={})
    opts = if options[:slice].nil?
             ::YAML.load(ERB.new(File.read(filename)).result)
           else
             ::YAML.load(ERB.new(File.read(filename)).result)[options[:slice]]
           end
    if opts
      opts.map { |name, command|
        Foreman::ProcfileEntry.new(name, command)
      }.compact
    else
      []
    end
  end

end
