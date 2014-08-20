require 'facter'
Facter.add(:console) do
  setcode do
     Facter::Util::Resolution.exec('echo CONSOLE')
  end
end
