require 'facter'
Facter.add(:system_role) do
  setcode do
     Facter::Util::Resolution.exec('date +%F')
  end
end
