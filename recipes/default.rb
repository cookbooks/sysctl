if node.platform_family == "rhel"
  cookbook_file "/etc/init.d/procps" do
    source "procps.init"
    mode 0755
  end
end

service "procps"

directory "/etc/sysctl.d" do
  mode 0755
  action :create
end

if node[:sysctl][:settings]
  template "/etc/sysctl.d/60_chef.conf" do
    source "sysctl.conf.erb"
    notifies :restart, resources(:service => "procps")
  end
end
