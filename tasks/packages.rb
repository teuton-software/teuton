
namespace :install do
  def packages
    p = %w[net-ssh net-sftp rainbow terminal-table thor json_pure]
    p += %w[minitest yard rubocop]
    return p
  end
end
